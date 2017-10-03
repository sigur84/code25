<?php

class ControllerProductDistributerToolsExtecom extends Controller {
    
   public function Storekeeper() {
       
        $product_assortiment_info = new stdClass();
       
        $this->load->model('catalog/distributer_tools_extecom');

        if ($this->request->server['REQUEST_METHOD'] == 'GET' && isset($this->request->get['product_id'])) {
            
            $this->load->model('catalog/product');
            
            $product_assortiment_info = $this->model_catalog_distributer_tools_extecom->getAssortiment($this->request->get['product_id']);
            
        }
        
        echo json_encode($product_assortiment_info);
        
        exit();
        
    }

    public function addDistributerScript() {
        
        if (isset($this->request->get['product_id'])) {
                 $product_id_distributer = (int)$this->request->get['product_id'];
        } else {
                 $product_id_distributer = 0;
        }
        $currency_code = $this->config->get('config_currency');
        
        if($this->session->data['currency']){
            
            $currency_code = $this->session->data['currency'];
            
        }
        
        $this->load->model('setting/setting');
        
        $this->load->model('catalog/distributer_tools_extecom');
       
        $setting = $this->model_setting_setting->getSetting('distributer_tools_extecom');

        $setting = $setting['distributer_tools_extecom']['setting'];

        $product_to_categories = TRUE;

        if(isset($setting['assortiment_categories']) && $setting['assortiment_categories'] && isset($this->request->get['product_id'])){

            $where_catogories = $setting['assortiment_categories'];
            
            foreach ($where_catogories as $category_id => $where_category) {
                
                $where_catogories[$category_id] = " category_id = ".$where_category;
                
            }

            $product_to_categories = $this->model_catalog_distributer_tools_extecom->checkProductToCategories($this->request->get['product_id'],$where_catogories);
            
        }
        
        $status = 0;
        
        if(isset($setting['status'])){
            
            $status = $setting['status'];
            
        }
        
        $status_storekeeper = 'true';
        
        if(!$product_to_categories || !$status){
            
            $status_storekeeper = 'false';
            
        }
            
        $this->load->model('catalog/distributer_tools_extecom');
        
        $decimal_this = (int)$this->currency->getDecimalPlace($currency_code);
        
        $dimension_this_left = $this->currency->getSymbolLeft($currency_code);
        
        $dimension_this_right = $this->currency->getSymbolRight($currency_code);
                
        $distributer_script = '<script>var product_id_distributer = '.$product_id_distributer.'; var decimal_this = '.$decimal_this.'; var dimension_this_right = "'.$dimension_this_right.'"; var dimension_this_left = "'.$dimension_this_left.'";  var status_storekeeper = '.$status_storekeeper.';</script>';

        return  $distributer_script;
        
    }

}
