        <?php

        class ControllerModuleDistributerToolsExtecom extends Controller {

            private $error           = array();
            private $this_version    = '1.1.0.0';
            private $this_extension  = 'distributer_tools_extecom';
            private $this_ocext_host = 'oc2101.ocext';
            private $path_oc = 'module';
            private $debug_mode      = 0;

            public function index() {

                $this->load->language($this->path_oc.'/distributer_tools_extecom');

                $this->document->setTitle($this->language->get('heading_title'));

                $this->load->model('tool/distributer_tools_extecom');
                
                $this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
                
                $data['heading_title'] = $this->language->get('heading_title');
                
                $data['tab_setting'] = $this->language->get('tab_setting');
                
                $data['button_save'] = $this->language->get('button_save');
                
                $data['button_cancel'] = $this->language->get('button_cancel');
                
                $data['text_setting_user_email'] = $this->language->get('text_setting_user_email');
                
                $data['text_setting_user_key'] = $this->language->get('text_setting_user_key');
                
                $data['text_setting_delete_product_option'] = $this->language->get('text_setting_delete_product_option');
                
                $data['text_setting_assortiment_categories_empty'] = $this->language->get('text_setting_assortiment_categories_empty');
                
                $data['text_setting_assortiment_categories'] = $this->language->get('text_setting_assortiment_categories');
                
                $data['text_setting_status'] = $this->language->get('text_setting_status');
                
                $data['path_oc'] = $this->path_oc;
                
                if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
                        
			$this->session->data['success'] = $this->language->get('text_success');
                        
                        $this->model_setting_setting->editSetting('distributer_tools_extecom', $this->request->post);
                        
                        $this->response->redirect($this->url->link($this->path_oc.'/distributer_tools_extecom', 'token=' . $this->session->data['token'], 'SSL'));
                        
		}
                
                $this->load->model('catalog/category');
                $filter_categories_data = array();
                $results = $this->model_catalog_category->getCategories($filter_categories_data);
                $data['categories'] = array();
                foreach ($results as $result) {
                    $data['categories'][] = array(
                            'category_id' => $result['category_id'], 
                            'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
                    );
                }
                
                $data['open_tab'] = 'tab_setting';
                
                $fields = array(
                    'delete_product_option'=>'delete_product_option',
                    'user_email'=>'user_email',
                    'user_key'=>'user_key',
                    'assortiment_categories'=>'assortiment_categories',
                    'status'=>'status'
                );
                
                $setting = $this->model_setting_setting->getSetting('distributer_tools_extecom');
                
                foreach ($fields as $field_name) {
                    
                    $data['text_setting_'.$field_name] = $this->language->get('text_setting_'.$field_name);
                    
                    if(!isset($setting['distributer_tools_extecom']['setting'][$field_name])){
                        
                        $data['distributer_tools_extecom']['setting'][$field_name] = '';
                        
                    }else{
                        
                        $data['distributer_tools_extecom']['setting'][$field_name] = $setting['distributer_tools_extecom']['setting'][$field_name];
                        
                    }
                    
                }
                
                $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
                
                $data['action_setting'] = $this->url->link($this->path_oc.'/distributer_tools_extecom', 'setting=1&'.'token=' . $this->session->data['token'], 'SSL');
                
                if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
                
                if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
                }elseif(isset ($this->session->data['error'])){
                        $data['error_warning'] = $this->session->data['error'];
                        unset($this->session->data['error']);
                } else {
			$data['error_warning'] = '';
		}
                
                $data['token'] = $this->session->data['token'];
  		$data['breadcrumbs'] = array();
   		$data['breadcrumbs'][] = array(
                    'text'      => $this->language->get('text_home'),
                    'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
                    'separator' => false
   		);
   		$data['breadcrumbs'][] = array(
                    'text'      => $this->language->get('text_module'),
                    'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
                    'separator' => ' :: '
   		);
   		$data['breadcrumbs'][] = array(
                    'text'      => $this->language->get('heading_title'),
                    'href'      => $this->url->link($this->path_oc.'/distributer_tools_extecom', 'token=' . $this->session->data['token'], 'SSL'),
                    'separator' => ' :: '
   		);
                
                $data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_content_top'] = $this->language->get('text_content_top');
		$data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->load->model('design/layout');
		$data['layouts'] = $this->model_design_layout->getLayouts();
                $data['back'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['button_back'] = $this->language->get( 'button_back' );
                $data['header'] = $this->load->controller('common/header');
                $data['column_left'] = $this->load->controller('common/column_left');
                $data['footer'] = $this->load->controller('common/footer');
                
                $this->response->setOutput($this->load->view($this->path_oc.'/distributer_tools_extecom.tpl', $data));
                
            }

            public function getForm() {

                $this->language->load($this->path_oc.'/distributer_tools_extecom');

                $this->document->setTitle($this->language->get('heading_title'));

                $this->load->model('tool/distributer_tools_extecom');

                $data['tab_assortiment'] = $this->language->get('tab_assortiment');
            }

            public function getAssortimentInfo() {
                
                $this->load->language('catalog/product');
		$data['entry_required'] = $this->language->get('entry_required');
                $data['entry_option'] = $this->language->get('entry_option');
		$data['entry_option_value'] = $this->language->get('entry_option_value');
                $data['entry_price'] = $this->language->get('entry_price');
		$data['entry_quantity'] = $this->language->get('entry_quantity');
                $data['entry_points'] = $this->language->get('entry_points');
		$data['entry_option_points'] = $this->language->get('entry_option_points');
		$data['entry_subtract'] = $this->language->get('entry_subtract');
                $data['entry_weight'] = $this->language->get('entry_weight');
                $data['button_remove'] = $this->language->get('button_remove');
                
                $this->language->load($this->path_oc.'/distributer_tools_extecom');
                $data['entry_model'] = $this->language->get('entry_model');
		$data['entry_sku'] = $this->language->get('entry_sku');
		$data['entry_upc'] = $this->language->get('entry_upc');
		$data['entry_ean'] = $this->language->get('entry_ean');
		$data['entry_jan'] = $this->language->get('entry_jan');
		$data['entry_isbn'] = $this->language->get('entry_isbn'); 
		$data['entry_mpn'] = $this->language->get('entry_mpn');
                $data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
                $data['text_product_assortiment_name'] = $this->language->get('text_product_assortiment_name');
                $data['button_assortiment_add'] = $this->language->get('button_assortiment_add');
                $data['text_new_product'] = '';
                $product_assortiments = array();
                $data['option_values'] = array();
                
                $this->load->model('tool/distributer_tools_extecom');
                
                $this->load->model('catalog/option');
                
                
                $product_id = !isset($this->request->get['product_id']) ? 0 : $this->request->get['product_id'];
                
                if($product_id){
                    
                    $product_assortiments = $this->model_tool_distributer_tools_extecom->getProductAssortiments($product_id);
                    
                    foreach ($product_assortiments as $product_assortiment_key => $product_assortiment) {
                        
                        $product_assortiment_value_data = $product_assortiment['product_assortiment_value'];
                        
                        $product_assortiments[$product_assortiment_key]['required'] = 0;
                        
                        $product_assortiments[$product_assortiment_key]['quantity'] = 0;
                        
                        $product_assortiments[$product_assortiment_key]['subtract'] = 0;
                        
                        $product_assortiments[$product_assortiment_key]['product_assortiment_value'] = array();
                        
                        $product_assortiments[$product_assortiment_key]['product_assortiment_value']['product_option_value'] = array();
                        
                        if($product_assortiment_value_data){
                            
                            foreach ($product_assortiment_value_data as $product_assortiment_value_data_product_option_value) {
                                
                                $product_option = $this->model_tool_distributer_tools_extecom->getProductOptions($product_id,$product_assortiment_value_data_product_option_value['product_option_id'],$product_assortiment_value_data_product_option_value['product_option_value_id']);
                                
                                if($product_option){
                                    
                                    $product_assortiments[$product_assortiment_key]['required'] = $product_option['required'];
                                    
                                    $product_assortiments[$product_assortiment_key]['subtract'] = $product_option['product_option_value']['subtract'];
                                    
                                    $product_assortiments[$product_assortiment_key]['quantity'] = $product_option['product_option_value']['quantity'];
                                    
                                    $product_option['product_option_value']['product_assortiment_value_id'] = $product_assortiment_value_data_product_option_value['product_assortiment_value_id'];
                                 
                                    $product_option['product_option_value']['option_id'] = $product_option['option_id'];
                                    
                                    $product_assortiments[$product_assortiment_key]['product_assortiment_value']['product_option_value'][] = $product_option['product_option_value'];
                                    
                                    if (!isset($data['option_values'][$product_option['option_id']])) {
                                        $data['option_values'][$product_option['option_id']] = $this->model_catalog_option->getOptionValues($product_option['option_id']);
                                    }

                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }else{
                    
                    $data['text_new_product'] = $this->language->get('text_new_product');
                    
                }
                
                $data['token'] = $this->session->data['token']; 
                
                $data['product_assortiments'] = $product_assortiments;

                return $this->load->view($this->path_oc.'/distributer_tools_extecom_assortiment_info.tpl', $data);
            }
            
            private function validate() {
            
		if (!$this->user->hasPermission('modify', $this->path_oc.'/distributer_tools_extecom')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	

        public function getNotifications() {
		sleep(1);
		$this->load->language($this->path_oc.'/distributer_tools_extecom');
		$response = $this->getNotificationsCurl();
		$json = array();
		if ($response===false) {
			$json['message'] = '';
			$json['error'] = $this->language->get( 'error_notifications' );
		} else {
			$json['message'] = $response;
			$json['error'] = '';
		}
		$this->response->setOutput(json_encode($json));
	}
        
        protected function curl_get_contents($url) {
            if(function_exists('curl_version')){
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_HEADER, 0);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
                $output = curl_exec($ch);
                curl_close($ch);
                return $output;
            }else{
                $output['ru'] = 'Проверка версии недоступна. Включите php расширение - CURL на Вашем хостинге';
                $output['en'] = 'You can not check the version. Enable php extension - CURL on your hosting';
                $language_code = $this->config->get( 'config_admin_language' );
                if(isset($output[$language_code])){
                    return $output[$language_code];
                }else{
                    return $output['en'];
                }
            }
	}


	public function getNotificationsCurl() {
		$language_code = $this->config->get( 'config_admin_language' );
		$result = $this->curl_get_contents("http://www.".$this->this_ocext_host.".com/index.php?route=information/check_update_version&license=".HTTP_SERVER."&version_opencart=".VERSION."&version_ocext=".$this->this_version."&extension=".$this->this_extension."&language_code=$language_code");
		if (stripos($result,'<html') !== false) {
			return '';
		}
		return $result;
	}
            
        }