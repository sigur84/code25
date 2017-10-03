<?php

class ModelToolDistributerToolsExtecom extends Model {

    protected $registry;

    public function __construct($registry) {
        
        $this->registry = $registry;
        
        $this->install();
        
    }
    
    public function install() {
        
        $tables[] = 'product_assortiment';
        
        $tables[] = 'product_assortiment_value';
        
        foreach ($tables as $table) {
            $check = $query = $this->db->query('SHOW TABLES FROM `'.DB_DATABASE.'` LIKE "'.DB_PREFIX.$table.'" ');
            if(!$check->num_rows){
                $this->creatTables($table);
            }
        }
        
    }
    
    private function creatTables($table) {
        
        if($table=='product_assortiment'){
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . $table . "` (
                  `product_assortiment_id` int(11) NOT NULL AUTO_INCREMENT,
                  `ean` varchar(250) NOT NULL,
                  `model` varchar(250) NOT NULL,
                  `jan` varchar(250) NOT NULL,
                  `upc` varchar(250) NOT NULL,
                  `isbn` varchar(250) NOT NULL,
                  `mpn` varchar(250) NOT NULL,
                  `sku` varchar(250) NOT NULL,
                  `product_id` int(11) NOT NULL,
                  PRIMARY KEY (`product_assortiment_id`)
                ) ENGINE=MyISAM  DEFAULT CHARSET=utf8;"
            );
        }elseif($table=='product_assortiment_value'){
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . $table . "` (
                  `product_assortiment_value_id` int(11) NOT NULL AUTO_INCREMENT,
                  `product_assortiment_id` int(11) NOT NULL,
                  `product_id` int(11) NOT NULL,
                  `option_id` int(11) NOT NULL,
                  `product_option_id` int(11) NOT NULL,
                  `option_value_id` int(11) NOT NULL,
                  `product_option_value_id` int(11) NOT NULL,
                  `recommended_price` decimal(15,4)	 NOT NULL,
                  `purchase_price` decimal(15,4)	 NOT NULL,
                  PRIMARY KEY (`product_assortiment_value_id`)
                ) ENGINE=MyISAM  DEFAULT CHARSET=utf8;"
            );
        }
        
    }
    
    public function getProductAssortiments($product_id) {
        
        $product_assortiment_data = array();

        $product_assortiment_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_assortiment`  WHERE product_id = '" . (int) $product_id . "'");

        foreach ($product_assortiment_query->rows as $product_assortiment) {

            
            $product_assortiment_value_data = array();
            
            $product_assortiment_value_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_assortiment_value`  WHERE product_assortiment_id = '" . (int) $product_assortiment['product_assortiment_id'] . "'");

            
            foreach ($product_assortiment_value_query->rows as $product_assortiment_value) {
                
                $product_option_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_option_value` WHERE product_id = '" . (int)$product_id . "' AND option_id = '" . (int)$product_assortiment_value['option_id'] . "' AND option_value_id = '" . (int)$product_assortiment_value['option_value_id'] . "' AND product_option_value_id = '" . (int)$product_assortiment_value['product_option_value_id'] . "' AND product_option_id = '" . (int)$product_assortiment_value['product_option_id'] . "' ");
                
                /*
                 * В опциях должны быть записи. Если удалялись, то на вывод не показываем, т.к. нет ни цен, ни остатков
                 */
                
                if($product_option_query->num_rows){
                    
                    $product_assortiment_value_data[] = array(
                        'product_assortiment_value_id' => $product_assortiment_value['product_assortiment_value_id'],
                        'product_option_value_id'      => $product_assortiment_value['product_option_value_id'],
                        'option_value_id'              => $product_assortiment_value['option_value_id'],
                        'product_option_id'            => $product_assortiment_value['product_option_id'],
                        'option_id'                    => $product_assortiment_value['option_id'],
                    );
                    
                }
                
            }

            $product_assortiment_data[] = array(
                'product_assortiment_id'    => $product_assortiment['product_assortiment_id'],
                'product_assortiment_value' => $product_assortiment_value_data,
                'product_id'                => $product_id,
                'ean'                       => $product_assortiment['ean'],
                'model'                     => $product_assortiment['model'],
                'jan'                       => $product_assortiment['jan'],
                'upc'                       => $product_assortiment['upc'],
                'mpn'                       => $product_assortiment['mpn'],
                'sku'                       => $product_assortiment['sku'],
                'isbn'                      => $product_assortiment['isbn'],
            );
            
        }
         
        return $product_assortiment_data;
    }
    
    public function getProductOptions($product_id,$product_option_id,$product_option_value_id) {
            $product_option_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_option` po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN `" . DB_PREFIX . "option_description` od ON (o.option_id = od.option_id) WHERE po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "' AND product_option_id = ".$product_option_id);

            $product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON(pov.option_value_id = ov.option_value_id) WHERE pov.product_option_id = '" . (int)$product_option_id . "' AND product_option_value_id = ".$product_option_value_id);
            
            $product_option_value_data = array(
                    'product_option_value_id' => $product_option_value_query->row['product_option_value_id'],
                    'product_option_id'    => $product_option_query->row['product_option_id'],
                    'option_value_id'         => $product_option_value_query->row['option_value_id'],
                    'quantity'                => $product_option_value_query->row['quantity'],
                    'subtract'                => $product_option_value_query->row['subtract'],
                    'price'                   => $product_option_value_query->row['price'],
                    'price_prefix'            => $product_option_value_query->row['price_prefix'],
                    'points'                  => $product_option_value_query->row['points'],
                    'points_prefix'           => $product_option_value_query->row['points_prefix'],
                    'weight'                  => $product_option_value_query->row['weight'],
                    'weight_prefix'           => $product_option_value_query->row['weight_prefix']
            );
            
            $product_option_data = array(
                    'product_option_id'    => $product_option_query->row['product_option_id'],
                    'product_option_value' => $product_option_value_data,
                    'option_id'            => $product_option_query->row['option_id'],
                    'name'                 => $product_option_query->row['name'],
                    'type'                 => $product_option_query->row['type'],
                    'value'                => $product_option_query->row['value'],
                    'required'             => $product_option_query->row['required']
            );

            return $product_option_data;
    }
    
    
    public function editAssortiment($product_assortiment,$product_id) {
        
        //var_dump($product_assortiment['product_assortiment']);exit();
        
        $product_assortiment_columns = array(
            'ean'=>'ean',
            'model'=>'model',
            'jan'=>'jan',
            'upc'=>'upc',
            'isbn'=>'isbn',
            'mpn'=>'mpn',
            'sku'=>'sku',
        );
        
        $setting = $this->config->get('distributer_tools_extecom');
        
        $setting = $setting['setting'];
        
        $product_option_values_assortiments = $this->getProductOptionValuesAssortiments($product_id);
        
        if(!isset($product_assortiment['product_assortiment'])){
            
            $this->db->query("DELETE FROM " . DB_PREFIX . "product_assortiment WHERE product_id = '" . (int)$product_id . "'");
            $this->db->query("DELETE FROM " . DB_PREFIX . "product_assortiment_value WHERE product_id = '" . (int)$product_id . "'");
            
            if(isset($setting['delete_product_option']) && $setting['delete_product_option']){
                
                foreach ($product_option_values_assortiments as $product_option_value_id) {

                    $this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_option_value_id = '" . (int)$product_option_value_id . "'");

                }
                
            }
            
        }else{
            
            $product_assortiment = $product_assortiment['product_assortiment'];
        
            if($product_assortiment){

                $this->db->query("DELETE FROM " . DB_PREFIX . "product_assortiment WHERE product_id = '" . (int)$product_id . "'");

                foreach ($product_assortiment as $product_assortiment_position) {

                    $insert_assortiment = array();

                    if(isset($product_assortiment_position['product_assortiment_id']) && $product_assortiment_position['product_assortiment_id']){

                        $insert_assortiment[] = ' product_assortiment_id='.$product_assortiment_position['product_assortiment_id'];

                    }

                    $insert_assortiment[] = ' product_id='.$product_id;

                    foreach ($product_assortiment_columns as $product_assortiment_column) {

                        $insert_assortiment[] = $product_assortiment_column." = '".$this->db->escape(trim(ltrim($product_assortiment_position[$product_assortiment_column])))."'";

                    }
                    
                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_assortiment SET ".  implode(', ', $insert_assortiment));

                    $product_assortiment_id = $this->db->getLastId();

                    $this->db->query("DELETE FROM " . DB_PREFIX . "product_assortiment_value WHERE product_id = '" . (int)$product_id . "' AND product_assortiment_id = ".$product_assortiment_id);

                    if($product_assortiment_position['product_assortiment_value']){

                        foreach ($product_assortiment_position['product_assortiment_value'] as $product_assortiment_value) {

                            if($product_assortiment_value['product_option_value_id']){

                                $this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_option_value_id = '" . (int)$product_assortiment_value['product_option_value_id'] . "'");
                                
                                $option_id = $this->getOptionIdByOptionValueId($product_assortiment_value['option_value_id']);
                                
                                $product_option_id = $this->getProductOptionIdByOptionIdAndProductId($option_id,$product_id);
                                
                                if($product_option_id){
                                    
                                    $this->db->query("UPDATE " . DB_PREFIX . "product_option SET option_id = '" . (int)$option_id . "', required = '" . (int)$product_assortiment_position['required']."' WHERE product_option_id = '".$product_option_id."' ");
                                    
                                }else{
                                    
                                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', required = '" . (int)$product_assortiment_position['required']."' ");
                                    
                                    $product_option_id = $this->db->getLastId();
                                    
                                }
                                
                                $product_option_value_id = $product_assortiment_value['product_option_value_id'];
                                
                                unset($product_option_values_assortiments[$product_option_value_id]);
                                
                                $this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_value_id = '" . (int)$product_option_value_id . "', product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', option_value_id = '" . (int)$product_assortiment_value['option_value_id'] . "', quantity = '" . (int)$product_assortiment_position['quantity'] . "', subtract = '" . (int)$product_assortiment_position['subtract'] . "', price = '" . (float)$product_assortiment_value['price'] . "', price_prefix = '" . $this->db->escape($product_assortiment_value['price_prefix']) . "', points = '" . (int)$product_assortiment_value['points'] . "', points_prefix = '" . $this->db->escape($product_assortiment_value['points_prefix']) . "', weight = '" . (float)$product_assortiment_value['weight'] . "', weight_prefix = '" . $this->db->escape($product_assortiment_value['weight_prefix']) . "'");

                                $product_assortiment_value_id_sql = "";

                                if($product_assortiment_value['product_assortiment_value_id']){

                                    $product_assortiment_value_id_sql = ", product_assortiment_value_id = ".$product_assortiment_value['product_assortiment_value_id'];

                                }

                                $this->db->query("INSERT INTO " . DB_PREFIX . "product_assortiment_value SET product_assortiment_id = '".$product_assortiment_id."', product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', product_option_id = '" . (int)$product_option_id . "', product_option_value_id = '".$product_option_value_id."', option_value_id = '" . (int)$product_assortiment_value['option_value_id'] . "' ".$product_assortiment_value_id_sql);

                            }
                            
                            else{

                                $option_id = $this->getOptionIdByOptionValueId($product_assortiment_value['option_value_id']);
                                
                                $product_option_id = $this->getProductOptionIdByOptionIdAndProductId($option_id,$product_id);
                                
                                if($product_option_id){
                                    
                                    $this->db->query("UPDATE " . DB_PREFIX . "product_option SET option_id = '" . (int)$option_id . "', required = '" . (int)$product_assortiment_position['required']."' WHERE product_option_id = '".$product_option_id."' ");
                                    
                                }else{
                                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', required = '" . (int)$product_assortiment_position['required']."' ");
                                    
                                    $product_option_id = $this->db->getLastId();
                                    
                                }

                                $this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', option_value_id = '" . (int)$product_assortiment_value['option_value_id'] . "', quantity = '" . (int)$product_assortiment_position['quantity'] . "', subtract = '" . (int)$product_assortiment_position['subtract'] . "', price = '" . (float)$product_assortiment_value['price'] . "', price_prefix = '" . $this->db->escape($product_assortiment_value['price_prefix']) . "', points = '" . (int)$product_assortiment_value['points'] . "', points_prefix = '" . $this->db->escape($product_assortiment_value['points_prefix']) . "', weight = '" . (float)$product_assortiment_value['weight'] . "', weight_prefix = '" . $this->db->escape($product_assortiment_value['weight_prefix']) . "'");

                                $product_option_value_id = $this->db->getLastId();
                                
                                unset($product_option_values_assortiments[$product_option_value_id]);
                                
                                $this->db->query("INSERT INTO " . DB_PREFIX . "product_assortiment_value SET product_assortiment_id = '".$product_assortiment_id."', product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', product_option_id = '" . (int)$product_option_id . "', product_option_value_id = '".$product_option_value_id."', option_value_id = '" . (int)$product_assortiment_value['option_value_id'] . "' ");
                                
                            }

                        }

                    }

                }

            }
            
            if(isset($setting['delete_product_option']) && $setting['delete_product_option']){
                
                foreach ($product_option_values_assortiments as $product_option_value_id) {

                    $this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_option_value_id = '" . (int)$product_option_value_id . "'");

                }
                
            }
            
        }
        
    }
    
    public function getOptionIdByOptionValueId($option_value_id) {
        
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "option_value  WHERE option_value_id = '" . (int)$option_value_id . "' ");

            return $query->row['option_id'];
    }
    
    public function getProductOptionIdByOptionIdAndProductId($option_id,$product_id) {
        
            $product_option_id = 0;
        
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option  WHERE option_id = '" . (int)$option_id . "' AND product_id = ".$product_id);
            
            if(isset($query->row['product_option_id'])){
                
                $product_option_id = $query->row['product_option_id'];
                
            }
            
            return $product_option_id;
    }
    
    public function getProductOptionValuesAssortiments($product_id) {
        
            $result = array();
        
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_assortiment_value  WHERE product_id = ".$product_id);
            
            if($query->rows){
                
                foreach ($query->rows as $row) {
                    
                    $result[$row['product_option_value_id']] = $row['product_option_value_id'];
                    
                }
                
            }
            
            return $result;
    }

}
