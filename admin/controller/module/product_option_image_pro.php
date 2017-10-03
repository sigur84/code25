<?php
//  Product Option Image PRO / Изображения опций PRO
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru
?>
<?php
class ControllerModuleProductOptionImagePro extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/product_option_image_pro');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			$this->model_setting_setting->editSetting('poip_module', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->response->redirect($this->url->link('module/product_option_image_pro', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$data['heading_title'] 							= $this->language->get('heading_title');

		$data['text_edit']									= $this->language->get('text_edit');
		$data['text_enabled']								= $this->language->get('text_enabled');
		$data['entry_import'] 							= $this->language->get('entry_import');
		$data['entry_import_description'] 	= $this->language->get('entry_import_description');
		$data['entry_import_nothing_before']= $this->language->get('entry_import_nothing_before');
		$data['entry_import_delete_before'] = $this->language->get('entry_import_delete_before');
		$data['button_upload'] 							= $this->language->get('button_upload');		
		$data['button_upload_help'] 				= $this->language->get('button_upload_help');
		$data['entry_server_response'] 			= $this->language->get('entry_server_response');
		$data['entry_import_result'] 				= $this->language->get('entry_import_result');
		$data['entry_export'] 							= $this->language->get('entry_export');
		$data['button_export'] 							= $this->language->get('button_export');
		$data['entry_export_description'] 	= $this->language->get('entry_export_description');
		
		$data['entry_settings'] 						= $this->language->get('entry_settings');
		$data['text_enabled'] 							= $this->language->get('text_enabled');
		
		$data['entry_layout'] 							= $this->language->get('entry_layout');
		$data['entry_position'] 						= $this->language->get('entry_position');
		$data['entry_status'] 							= $this->language->get('entry_status');
		$data['entry_sort_order'] 					= $this->language->get('entry_sort_order');
		
		$data['button_save'] 								= $this->language->get('button_save');
		$data['button_cancel'] 							= $this->language->get('button_cancel');
		$data['button_add_module'] 					= $this->language->get('button_add_module');
		$data['button_remove'] 							= $this->language->get('button_remove');
		
		$data['text_update_alert'] 					= $this->language->get('text_update_alert');
		$data['entry_about']								= $this->language->get('entry_about');
		$data['module_description']					= $this->language->get('module_description');
		$data['text_conversation']					= $this->language->get('text_conversation');
		$data['entry_we_recommend']					= $this->language->get('entry_we_recommend');
		$data['text_we_recommend']					= $this->language->get('text_we_recommend');
		$data['module_copyright']						= $this->language->get('module_copyright');
		$data['module_info'] 								= $this->language->get('module_info');
		$data['module_page'] 								= $this->language->get('module_page');
		
		$data['config_admin_language']			= $this->config->get('config_admin_language');
		
		$data['PHPExcelNotFound'] 					= $this->language->get('PHPExcelNotFound');
		
		$data['PHPExcelExists']							= file_exists($this->PHPExcelPath());
		$data['PHPExcelPath']				 				= $this->PHPExcelPath(true);
		
		$data['token'] = $this->session->data['token'];
		
		$this->load->model('module/product_option_image_pro');
		$settings_names = $this->model_module_product_option_image_pro->getSettingsNames(false);
		// new
		$settings_values = array();
		foreach ($settings_names as $setting_name) {
			$data['entry_'.$setting_name] = $this->language->get('entry_'.$setting_name);
			$data['entry_'.$setting_name.'_help'] = $this->language->get('entry_'.$setting_name.'_help');
			for ($i=0; $i<10; $i++) {
				$value_key = 'entry_'.$setting_name.'_v'.$i;
				if ( $this->language->get($value_key) != $value_key ) {
					$data[$value_key] = $this->language->get($value_key);
					// new
					$settings_values[] = $value_key; 
				}
			}
		}
		$data['settings_names'] = $settings_names;
		

		$data['settings_values'] = $settings_values;
		
		$data['module_version'] = $this->model_module_product_option_image_pro->current_version();
		
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
      $data['success'] = $this->session->data['success'];
      unset($this->session->data['success']);
    } 

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
					'href'      => $this->url->link('module/product_option_image_pro', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$data['action'] 				= $this->url->link('module/product_option_image_pro', 'token=' . $this->session->data['token'], 'SSL');
		$data['action_export'] 	= $this->url->link('module/product_option_image_pro/export', '&token=' . $this->session->data['token'], 'SSL');
		
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$data['modules'] = array();
		
		if (isset($this->request->post['poip_module'])) {
			$data['modules'] = $this->request->post['poip_module'];
		} elseif ($this->config->get('poip_module')) {
			$data['modules'] = $this->config->get('poip_module');
		}
		
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
				
		$this->response->setOutput($this->load->view('module/product_option_image_pro.tpl', $data));
		
	}
	
	
	private function PHPExcelPath($short = false) {
		if ($short) {
			return './system/PHPExcel/Classes/PHPExcel.php';
		} else {
			return DIR_SYSTEM . '/PHPExcel/Classes/PHPExcel.php';
		}
	}
	
	
	public function import() {
		
		$this->load->model('module/product_option_image_pro');
		
		$json = array();
		
		if (!empty($this->request->files['file']['name'])) {
			
			ini_set('display_errors', 1);
			error_reporting(E_ALL);
			
			require_once $this->PHPExcelPath();
			
			$cacheMethod = PHPExcel_CachedObjectStorageFactory:: cache_to_phpTemp; //PHPExcel_CachedObjectStorageFactory::cache_to_discISAM ; //
			$cacheSettings = array( 'memoryCacheSize' => '32MB');
			PHPExcel_Settings::setCacheStorageMethod($cacheMethod, $cacheSettings);
			
			$excel = PHPExcel_IOFactory::load($this->request->files['file']['tmp_name']); // PHPExcel
			$sheet = $excel->getSheet(0);
			
			$data = $sheet->toArray();
			
			
			if (count($data) > 1) {
				
				if (isset($this->request->post['import_delete_before']) && $this->request->post['import_delete_before'] == 1) {
					$this->model_module_product_option_image_pro->deleteAllImages();
				}
				
				
				
				
				foreach ($data[0] as $head_key => &$head_val) {
					$head_val = trim($head_val);
				}
				unset($head_val);
				$head = array_flip($data[0]);
				
				
				if (!isset($head['product_id'])) {
					$json['error'] = "product_id not found";
				}
				
				if (!isset($head['image'])) {
					$json['error'] = "image not found";
				}
				
				if (!isset($head['option_value_id'])) {
					$json['error'] = "option_value_id not found";
				}
				
				if (!isset($json['error'])) {
					
					$images = 0;
					$skipped = 0;
					for ($i=1;$i<count($data);$i++) {
						
						$row = $data[$i];
						
						if (trim((string)$row[$head['image']]) != "") {
							
							if ($this->model_module_product_option_image_pro->add_product_option_value_image((int)$row[$head['product_id']], (int)$row[$head['option_value_id']], (string)$row[$head['image']])) {
								$images++;
							} else {
								$skipped++;
							}
						
						}
						
					}
					
					$json['rows'] = count($data)-1;
					$json['images'] = $images;
					$json['skipped'] = $skipped;
					
				}
				
			} else {
				$json['error'] = "empty table";
			}
			
			
			
		} else {
			$json['error'] = "file not uploaded";
		}
		
		$this->response->setOutput(json_encode($json));
	}
	
	public function export() {
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') ) {
		
			ini_set('display_errors', 1);
			error_reporting(E_ERROR|E_PARSE);	
			
			$this->load->model('module/product_option_image_pro');
			$data = $this->model_module_product_option_image_pro->getAllImages();
			
			require_once $this->PHPExcelPath();
			
			/*
PHPExcel_CachedObjectStorageFactory::cache_in_memory;
PHPExcel_CachedObjectStorageFactory::cache_in_memory_serialized;
PHPExcel_CachedObjectStorageFactory::cache_in_memory_gzip;
PHPExcel_CachedObjectStorageFactory::cache_to_discISAM;
PHPExcel_CachedObjectStorageFactory::cache_to_phpTemp;
PHPExcel_CachedObjectStorageFactory::cache_to_apc;
PHPExcel_CachedObjectStorageFactory::cache_to_memcache
PHPExcel_CachedObjectStorageFactory::cache_to_wincache;
PHPExcel_CachedObjectStorageFactory::cache_to_sqlite;
PHPExcel_CachedObjectStorageFactory::cache_to_sqlite3;

			*/
			
			PHPExcel_Shared_File::setUseUploadTempDirectory(true);
			
			$cacheMethod = PHPExcel_CachedObjectStorageFactory:: cache_to_discISAM; //PHPExcel_CachedObjectStorageFactory::cache_to_discISAM ; //
			$cacheSettings = array( 'memoryCacheSize' => '32MB');
			if (!PHPExcel_Settings::setCacheStorageMethod($cacheMethod, $cacheSettings)) {
				$this->log->write("Product Options Images PRO: PHPExcel cache error");
			}
			
			$objPHPExcel = new PHPExcel();
			$objPHPExcel->setActiveSheetIndex(0);
			
			/*
			$column = 0;
			foreach ($data as $data_key => $data_val) {
				$objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow($column, 1, $data_key);
				$column++;
			}
			*/
			
			$objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(0, 1, 'product_id');
			$objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(1, 1, 'option_value_id');
			$objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(2, 1, 'image');
			
			
			$objPHPExcel->getActiveSheet()->fromArray($data,null,'A2');
			unset($data);

			
			//$objPHPExcel->getActiveSheet()->fromArray($current_data, null, 'A2');
			//$objPHPExcel->getActiveSheet()->fromArray($data,null,'A2');
			
			
			$objWriter = new PHPExcel_Writer_Excel5($objPHPExcel);
			
			
			$file = DIR_CACHE."/poip_export.xls";
			
			$objWriter->save($file);
			
			header('Content-Description: File Transfer');
			header('Content-Type: application/octet-stream');
			header('Content-Disposition: attachment; filename=' . basename($file));
			header('Content-Transfer-Encoding: binary');
			header('Expires: 0');
			header('Cache-Control: must-revalidate');
			header('Pragma: public');
			header('Content-Length: ' . filesize($file));
			// read file and send to user
			readfile($file);
			exit;
			
		}
	}
	
	
	public function install() {
		
    $this->load->model('module/product_option_image_pro');
    $this->model_module_product_option_image_pro->install();
  }
  
  public function uninstall() {
		
		$this->load->model('module/product_option_image_pro');
		$this->model_module_product_option_image_pro->uninstall();
		
  }
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/product_option_image_pro')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>