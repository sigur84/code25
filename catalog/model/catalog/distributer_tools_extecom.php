<?php

class ModelCatalogDistributerToolsExtecom extends Model {

    public function getAssortiment($product_id) {

        $where_assortiment_ids = array();        

        $assortiment_info = new stdClass;
        
        $quantity;
        
        $product_assortiment_id;

        $sql = "SELECT pav.*, pa.ean, pa.model , pa.jan, pa.upc, pa.isbn, pa.mpn, pa.sku, ovd.name, pov.price_prefix, pov.price, pov.quantity as quantity FROM `" . DB_PREFIX . "product_assortiment_value` pav LEFT JOIN `" . DB_PREFIX . "product_assortiment` pa ON (pav.product_assortiment_id = pa.product_assortiment_id) LEFT JOIN `" . DB_PREFIX . "option_value_description` ovd ON (pav.option_value_id = ovd.option_value_id) LEFT JOIN `" . DB_PREFIX . "product_option_value` pov ON (pav.product_option_value_id = pov.product_option_value_id) WHERE pav.product_id ='" . (int) $product_id . "'GROUP BY pav.product_option_value_id";

        $query = $this->db->query($sql);
        
        $currency_code_config = $this->config->get('config_currency');
            
        $currency_code_selected = $currency_code_config;

        if(isset($this->session->data['currency'])){

            $currency_code_selected = $this->session->data['currency'];

        }

        foreach ($query->rows as $product_assortiment => $product_assortiment_value) {

            $quantity = $product_assortiment_value['quantity'];
            
            $product_assortiment_value['price'] = $this->currency->convert($product_assortiment_value['price'], $currency_code_config, $currency_code_selected);
            
            if ($quantity >= 1){
            $assortiment_info->{$product_assortiment} = $product_assortiment_value;
            }
        
        }
        $sql = "SELECT product_assortiment_id,option_value_id FROM `" . DB_PREFIX . "product_assortiment_value` WHERE product_id ='" . (int) $product_id . "'";
        
        $query = $this->db->query($sql);
        
         foreach ($query->rows as $product_assortiment => $product_assortiment_value) {

            $product_assortiment_id = $product_assortiment_value['product_assortiment_id'];
            
            if (isset($assortiment_info->OVI{$product_assortiment_id})){
           
            $assortiment_info->OVI{$product_assortiment_id} .= "_".$product_assortiment_value['option_value_id'];
            
            }else{
                
             $assortiment_info->OVI{$product_assortiment_id} = "".$product_assortiment_value['option_value_id'];
             
            }
        }
        
        return $assortiment_info;
    }
    
    public function checkProductToCategories($product_id,$where_catogories) {
        $result = TRUE;
        if($where_catogories){
            
            $query = $this->db->query('SELECT product_id FROM `' . DB_PREFIX . 'product_to_category` WHERE product_id = '.$product_id.' AND ('.  implode(' OR ', $where_catogories).')');
            if(!$query->num_rows){
                
                $result = FALSE;
                
            }
            
        }
        return $result;
    }

}
