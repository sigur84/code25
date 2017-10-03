<?php

// @category  : OpenCart
// @module    : Smart One Page Checkout
// @author    : OCdevWizard <ocdevwizard@gmail.com>
// @copyright : Copyright (c) 2015, OCdevWizard
// @license   : http://license.ocdevwizard.com/Licensing_Policy.pdf

class ControllerModuleOCdevSmartOnePageCheckout extends Controller {

	private $error           = array();
	static  $_module_version = '1.0.3';
	static  $_module_name    = 'ocdev_smart_one_page_checkout';

	public function index() {
		$data = array();

		// connect models array
		$models = array('setting/store', 'setting/setting', 'extension/extension', 'catalog/information', 'catalog/category', 'catalog/manufacturer', 'catalog/product', (version_compare(VERSION, '2.1.0.1') < 0) ? 'sale/customer_group' : 'customer/customer_group', 'localisation/language', 'localisation/order_status', 'localisation/country', 'catalog/option', 'marketing/coupon', 'module/'.self::$_module_name);
		foreach ($models as $model) {
			$this->load->model($model);
		}

		$data = array_merge($data, $this->language->load('module/'.self::$_module_name));
		$this->document->setTitle($this->language->get('heading_name'));

		$scripts = array('jquery-ui.min.js');
		foreach ($scripts as $script) {
			$this->document->addScript('view/javascript/'.self::$_module_name.'/'.$script);
		}

		$styles = array('stylesheet.css');
		foreach ($styles as $style) {
				$this->document->addStyle('view/stylesheet/'.self::$_module_name.'/'.$style);
		}

		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
			if (is_uploaded_file($this->request->files['import']['tmp_name'])) {
				$content = file_get_contents($this->request->files['import']['tmp_name']);
			}

			if (isset($content)) {
      	$this->session->data['success'] = $this->language->get('text_success');
      	$this->model_setting_setting->editSetting(self::$_module_name, unserialize($content));
      	$this->response->redirect($this->url->link('extension/module', 'token='.$this->session->data['token'], 'SSL'));
			} else {
				$this->session->data['success'] = $this->language->get('text_success');
      	$this->model_setting_setting->editSetting(self::$_module_name, $this->request->post);
      	$this->response->redirect($this->url->link('extension/module', 'token='.$this->session->data['token'], 'SSL'));
			}
    }

		$data['error_warning'] = (isset($this->error['warning'])) ? $this->error['warning'] : '';
		$data['error_text'] = (isset($this->error['text'])) ? $this->error['text'] : array();
		$data['error_data_fields'] = (isset($this->error['data_fields'])) ? $this->error['data_fields'] : array();
		$data['error_heading'] = (isset($this->error['heading'])) ? $this->error['heading'] : '';
		$data['error_checkout_button'] = (isset($this->error['checkout_button'])) ? $this->error['checkout_button'] : '';
		$data['error_continue_button'] = (isset($this->error['continue_button'])) ? $this->error['continue_button'] : '';
		$data['error_main_image_width'] = (isset($this->error['main_image_width'])) ? $this->error['main_image_width'] : '';
		$data['error_main_image_height'] = (isset($this->error['main_image_height'])) ? $this->error['main_image_height'] : '';
		$data['error_sp_heading'] = (isset($this->error['sp_heading'])) ? $this->error['sp_heading'] : '';
		$data['error_sp_recommended_products_heading'] = (isset($this->error['sp_recommended_products_heading'])) ? $this->error['sp_recommended_products_heading'] : '';
		$data['error_sp_success_text'] = (isset($this->error['sp_success_text'])) ? $this->error['sp_success_text'] : '';
		$data['error_sp_limit_recommended'] = (isset($this->error['sp_limit_recommended'])) ? $this->error['sp_limit_recommended'] : '';

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['breadcrumbs'] = array(
			0 => array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token='.$this->session->data['token'], 'SSL'),
				'separator' => false
			),
			1 => array(
				'text'      => $this->language->get('text_module'),
				'href'      => $this->url->link('extension/module', 'token='.$this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			),
			2 => array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('module/'.self::$_module_name, 'token='.$this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			)
		);

		$data['action'] 				 = $this->url->link('module/'.self::$_module_name, 'token='.$this->session->data['token'], 'SSL');
		$data['action_plus']     = $this->url->link('module/'.self::$_module_name.'/edit_and_stay', 'token='.$this->session->data['token'], 'SSL');
		$data['cancel'] 				 = $this->url->link('extension/module', 'token='.$this->session->data['token'], 'SSL');
		$data['export_settings_button'] = $this->url->link( 'module/'.self::$_module_name.'/export_settings', 'token='.$this->session->data['token'], 'SSL' );
		$data['import_settings_button'] = $this->url->link( 'module/'.self::$_module_name.'/import_settings', 'token='.$this->session->data['token'], 'SSL' );
		$data['admin_language']  = $this->config->get('config_admin_language');
		$data['_module_name']    = (string)self::$_module_name;
		$data['_module_version'] = (string)self::$_module_version;
		$data['token']    			 = $this->session->data['token'];
		$data['opencart_custom_fields_link'] = $this->url->link('sale/custom_field', 'token='.$this->session->data['token'], 'SSL');
		$data['text_data'] 			 = isset($this->request->post[self::$_module_name.'_text_data']) ? $this->request->post[self::$_module_name.'_text_data'] : $this->config->get(self::$_module_name.'_text_data');
		$data['form_data'] 			 = isset($this->request->post[self::$_module_name.'_form_data']) ? $this->request->post[self::$_module_name.'_form_data'] : $this->config->get(self::$_module_name.'_form_data');
		$data['sp_text_data'] 	 = isset($this->request->post[self::$_module_name.'_sp_text_data']) ? $this->request->post[self::$_module_name.'_sp_text_data'] : $this->config->get(self::$_module_name.'_sp_text_data');
		$data['sp_form_data'] 	 = isset($this->request->post[self::$_module_name.'_sp_form_data']) ? $this->request->post[self::$_module_name.'_sp_form_data'] : $this->config->get(self::$_module_name.'_sp_form_data');

		$form_data = $data['form_data'];
		$sp_form_data = $data['sp_form_data'];

		if (isset($this->request->post[self::$_module_name.'_field_data'])) {
			$field_datas = $this->request->post[self::$_module_name.'_field_data'];
		} elseif ($this->config->get(self::$_module_name.'_field_data')) {
			$field_datas = $this->config->get(self::$_module_name.'_field_data');
		} else {
			$field_datas = array(0);
		}

		$data['field_view_data'] = array(
			'email'       => $this->language->get('text_field_email'),
			'firstname'   => $this->language->get('text_field_firstname'),
			'lastname'    => $this->language->get('text_field_lastname'),
			'telephone'   => $this->language->get('text_field_telephone'),
			'fax'         => $this->language->get('text_field_fax'),
			'company'     => $this->language->get('text_field_company'),
			'company_id'  => $this->language->get('text_field_company_id'),
			'address_1'   => $this->language->get('text_field_address_1'),
			'address_2'   => $this->language->get('text_field_address_2'),
			'city'        => $this->language->get('text_field_city'),
			'postcode'    => $this->language->get('text_field_postcode'),
			'country_id'  => $this->language->get('text_field_country_id'),
			'zone_id'     => $this->language->get('text_field_zone_id'),
			'comment'     => $this->language->get('text_field_comment')
		);

		$data['field_data'] = array();

		foreach ($field_datas as $field) {
			$data['field_data'][] = array(
				'sort_order'        => $field['sort_order'],
				'name'              => $field['name'],
				'activate'          => $field['activate'],
				'title'             => $field['title'],
				'view'              => $field['view'],
				'mask'   	   			  => $field['mask'],
				'customer_groups'   => isset($field['customer_groups']) ? $field['customer_groups'] : array(),
				'address_blocks'		=> isset($field['address_blocks']) ? $field['address_blocks'] : array(),
				'check'             => $field['check'],
				'check_rule'        => $field['check_rule'],
				'check_min'         => $field['check_min'],
				'check_max'         => $field['check_max'],
				'error_text'        => $field['error_text'],
				'placeholder_text'  => $field['placeholder_text'],
				'css_id'            => $field['css_id'],
				'css_class'         => $field['css_class'],
				'position'          => $field['position']
			);
		}

		$default_store = array(0 => array('store_id' => 0, 'name' => $this->config->get('config_name').' (Default)'));

		$all_stores = array_merge($this->model_setting_store->getStores(), $default_store);

		$data['all_stores'] = array();

		foreach ($all_stores as $store) {
			$data['all_stores'][] = array(
				'store_id' => $store['store_id'],
				'name'     => $store['name']
			);
		}

		$data['all_customer_groups'] = array();

		foreach ($this->{'model_'.((version_compare(VERSION, '2.1.0.1') < 0) ? 'sale' : 'customer').'_customer_group'}->getCustomerGroups() as $customer_group) {
			$data['all_customer_groups'][] = array(
				'customer_group_id' => $customer_group['customer_group_id'],
				'name'              => $customer_group['name']
			);
		}

		$payments = $this->model_extension_extension->getInstalled('payment');

		$data['payments'] = array();

		foreach ($payments as $payment) {
			if ($payment) {
				$this->load->language('payment/'.$payment);
				$data['payments'][] = array(
					'code' => $payment,
					'name' => $this->language->get('heading_title')
				);
			}
		}

		$shippings = $this->model_extension_extension->getInstalled('shipping');

		$data['shippings'] = array();

		foreach ($shippings as $shipping) {
			if ($shipping) {
				$this->load->language('shipping/'.$shipping);
				$data['shippings'][] = array(
					'code' => $shipping,
					'name' => $this->language->get('heading_title')
				);
			}
		}

		$data['order_statuses'] = array();

		foreach ($this->model_localisation_order_status->getOrderStatuses() as $status) {
			$data['order_statuses'][] = array(
				'status_id' => $status['order_status_id'],
				'name'      => $status['name']
			);
		}

		$data['countries_data'] = array();

		foreach ($this->model_localisation_country->getCountries() as $country) {
			$data['countries_data'][] = array(
				'country_id' => $country['country_id'],
				'name'       => $country['name'].(($country['country_id'] == $this->config->get('config_country_id')) ? $this->language->get('text_default') : null)
			);
		}

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $information) {
			$data['informations'][] = array(
				'information_id' => $information['information_id'],
				'title'          => $information['title']
			);
		}

		$data['all_coupons'] = array();

		foreach ($this->model_marketing_coupon->getCoupons() as $coupon) {
			$data['all_coupons'][] = array(
				'coupon_id'  => $coupon['coupon_id'],
				'name'       => $coupon['name'],
			);
		}

	  $data['checkout_blocks'] = array();

    $blocks = array(
      array('name'=> $this->language->get('text_cart_block'), 'value' => 'cart'),
      array('name'=> $this->language->get('text_shipping_block'), 'value' => 'shipping'),
      array('name'=> $this->language->get('text_payment_block'), 'value' => 'payment'),
      array('name'=> $this->language->get('text_login_block'), 'value' => 'login'),
      array('name'=> $this->language->get('text_coupon_block'), 'value' => 'coupon'),
      array('name'=> $this->language->get('text_voucher_block'), 'value' => 'voucher'),
      array('name'=> $this->language->get('text_reward_block'), 'value' => 'reward')
    );

    foreach ($blocks as $block) {
      $data['checkout_blocks'][] = array(
      	'name'  => $block['name'],
        'value'  => $block['value']
      );
    }

    // recommended by products
    $data['sp_all_products'] = array();

    if (isset($this->request->post['sp_product'])) {
      $sp_products = $this->request->post['sp_product'];
    } elseif (!empty($sp_form_data['recommended_products'])) {
      $sp_products = $sp_form_data['recommended_products'];
    } else {
      $sp_products = array();
    }

    if ($sp_products) {
      foreach ($sp_products as $sp_product_id) {
        $sp_product_info = $this->model_catalog_product->getProduct($sp_product_id);
        if ($sp_product_info) {
          $data['sp_all_products'][] = array(
            'product_id' => $sp_product_info['product_id'],
            'name'       => $sp_product_info['name']
         );
        }
      }
    }

    // recommended by categories
    $data['sp_all_categories'] = array();

    if (isset($this->request->post['sp_category'])) {
      $sp_categories = $this->request->post['sp_category'];
    } elseif (!empty($sp_form_data['recommended_categories'])) {
      $sp_categories = $sp_form_data['recommended_categories'];
    } else {
      $sp_categories = array();
    }

    if ($sp_categories) {
      foreach ($sp_categories as $sp_category_id) {
        $sp_category_info = $this->model_catalog_category->getCategory($sp_category_id);
        if ($sp_category_info) {
          $data['sp_all_categories'][] = array(
            'category_id' => $sp_category_info['category_id'],
            'name'        => $sp_category_info['name']
         );
        }
      }
    }

    // recommended by manufacturers
    $data['sp_all_manufacturers'] = array();

    if (isset($this->request->post['sp_manufacturer'])) {
      $sp_manufacturers = $this->request->post['sp_manufacturer'];
    } elseif (!empty($sp_form_data['recommended_manufacturers'])) {
      $sp_manufacturers = $sp_form_data['recommended_manufacturers'];
    } else {
      $sp_manufacturers = array();
    }

    if ($sp_manufacturers) {
      foreach ($sp_manufacturers as $sp_manufacturer_id) {
        $sp_manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($sp_manufacturer_id);
        if ($sp_manufacturer_info) {
          $data['sp_all_manufacturers'][] = array(
            'manufacturer_id' => $sp_manufacturer_info['manufacturer_id'],
            'name'            => $sp_manufacturer_info['name']
         );
        }
      }
    }

		// ocdev products
		$data['ocdev_products'] = $this->{'model_module_'.self::$_module_name}->getOCdevCatalog();

		$data['languages'] = $this->model_localisation_language->getLanguages();
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/'.self::$_module_name.'.tpl', $data));
	}

	public function edit_and_stay() {

    $data = array();

    // connect models array
    $models = array('setting/setting');
    foreach ($models as $model) {
      $this->load->model($model);
    }

    $data = array_merge($data, $this->language->load('module/'.self::$_module_name));
    $this->document->setTitle($this->language->get('heading_title'));

    if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {

    	if (is_uploaded_file($this->request->files['import']['tmp_name'])) {
				$content = file_get_contents($this->request->files['import']['tmp_name']);
			}

			if (isset($content)) {
      	$this->session->data['success'] = $this->language->get('text_success');
      	$this->model_setting_setting->editSetting(self::$_module_name, unserialize($content));
      	$this->response->redirect($this->url->link('module/'.self::$_module_name, 'token='.$this->session->data['token'], 'SSL'));
			} else {
				$this->session->data['success'] = $this->language->get('text_success');
      	$this->model_setting_setting->editSetting(self::$_module_name, $this->request->post);
      	$this->response->redirect($this->url->link('module/'.self::$_module_name, 'token='.$this->session->data['token'], 'SSL'));
			}

    } else {
      $this->index();
    }
  }

	public function install() {

		// connect language data
		$text_form = $this->language->load('module/'.self::$_module_name);

		// connect model data
		$models = array('setting/setting', 'extension/extension');
		foreach ($models as $model) {
			$this->load->model($model);
		}

		// add permission
		$modules = array('module/'.self::$_module_name);
		foreach ($modules as $module) {
			$this->model_user_user_group->addPermission($this->user->getId(), 'access', $module);
			$this->model_user_user_group->addPermission($this->user->getId(), 'modify', $module);
		}

		// set default data
		$this->model_setting_setting->editSetting(self::$_module_name, array(
			self::$_module_name.'_text_data' => array(
				$this->config->get('config_admin_language') => array(
					'heading'          						=> $this->language->get('default_heading'),
					'checkout_button'  						=> $this->language->get('default_checkout_button'),
					'continue_button'  						=> $this->language->get('default_continue_button'),
					'empty_text'       						=> $this->language->get('default_empty_text'),
					'additional'									=> ''
				),
			),
			self::$_module_name.'_sp_text_data' => array(
        $this->config->get('config_admin_language') => array(
          'heading'       	 							=> $this->language->get('default_sp_heading'),
					'recommended_products_heading'	=> $this->language->get('default_sp_recomended_products_heading'),
          'success_text'  	 							=> $this->language->get('default_sp_success_text')
        ),
      ),
			self::$_module_name.'_form_data' => array(
				'activate'                      => '1',
				'alternative_email'             => (string)$this->config->get('config_email'),
				'prefix_order'                  => 'SMOPC: ',
				'order_status_id'               => (int)$this->config->get('config_order_status_id'),
				'hide_main_img'                 => '1',
				'main_image_width'              => '50',
				'main_image_height'             => '50',
				'discount_status'               => '1',
				'hide_shipping_title'           => '0',
				'allow_google_analytics'        => '0',
				'allow_google_event'            => '0',
				'google_event_category'         => 'One Page Checkout',
				'google_event_action'           => 'Success',
				'google_analytics_script'       => '',
				'stores'                        => array(),
				'customer_groups'               => array(),
				'countries'                     => array(),
				'gift_coupon'                   => '',
				'require_payment_terms'         => '',
				'require_shipping_terms'        => '',
				'require_checkout_terms'        => '',
				'redirect_to_success_page'      => '1',
				'checkout_blocks'								=> array('cart', 'shipping', 'payment', 'login', 'coupon', 'voucher', 'reward'),
				'cancel_button'									=> '2',
				'checkout_button'								=> '1',
				'show_additional_text'					=> '0',
				'min_order_total'								=> '',
				'max_order_total'								=> '',
        'display_shipping_type'					=> '1',
        'display_payment_type'					=> '1',
        'show_weight_cart'							=> '1',
        'customer_group'								=> array($this->config->get('config_customer_group_id') => array('min_order_total' => '', 'max_order_total' => '', 'min_weight_total' => '', 'max_weight_total' => '', 'min_quantity_total' => '', 'max_quantity_total' => '',)),
        'allow_guest_order'							=> '0',
        'allow_login'										=> '0',
        'allow_newsletter_subscribe'    => '1',
        'allow_register'								=> '0',
        'display_shipping_heading'			=> '1',
        'redirect_from_cart'						=> '1',
        'stock_checkout'								=> '0',
				'display_customer_groups_type'	=> '1',
				'customer_group_id_array'				=> array(),
				'allow_second_address'					=> '1',
				'allow_custom_fields'						=> '1',
				'front_module_name'             => str_replace(array('<b>','</b>'), "", $text_form['heading_title']),
				'front_module_version'          => (string)self::$_module_version
			),
			self::$_module_name.'_sp_form_data' => array(
				'hide_table_img'					 		=> '1',
        'table_image_width'					 	=> '80',
        'table_image_height'					=> '80',
				'check'                      	=> '0',
				'recommended_categories'     	=> array(),
        'recommended_manufacturers'  	=> array(),
        'recommended_products'       	=> array(),
        'limit_recommended' 			   	=> '4',
     		'hide_sub_img'                => '1',
        'sub_images_width'            => '200',
        'sub_images_height'           => '200',
				'show_button_print'           => '1',
        'show_button_continue'        => '1',
        'show_comment'								=> '1',
        'show_table_order_details'    => '1',
        'show_table_payment_address'  => '1',
        'show_table_shipping_address' => '1',
        'show_table_products'         => '1',
        'custom_css'                  => ''
			),
			self::$_module_name.'_field_data' => array(
				0 => array(
					'sort_order' 			  => '1',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_firstname')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_firstname')),
					'view'       			  => 'firstname',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '1',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_firstname')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '1',
					'mask' 							=> ''
				),
				1 => array(
					'sort_order' 			  => '2',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_lastname')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_lastname')),
					'view'       			  => 'lastname',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '1',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message')),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_lastname')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '2',
					'mask' 							=> ''
				),
				2 => array(
					'sort_order' 			  => '3',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_email')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_email')),
					'view'       			  => 'email',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '1',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_email')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '1',
					'mask' 							=> ''
				),
				3 => array(
					'sort_order' 			  => '4',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_telephone')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_telephone')),
					'view'       			  => 'telephone',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '1',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_telephone')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '2',
					'mask' 							=> ''
				),
				4 => array(
					'sort_order' 			  => '5',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_fax')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_fax')),
					'view'       			  => 'fax',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '0',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_fax')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '1',
					'mask' 							=> ''
				),
				5 => array(
					'sort_order' 			  => '6',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_company')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_company')),
					'view'       			  => 'company',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '0',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_company')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '2',
					'mask' 							=> ''
				),
				6 => array(
					'sort_order' 			  => '7',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_address_1')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_address_1')),
					'view'       			  => 'address_1',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '1',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_address_1')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '1',
					'mask' 							=> ''
				),
				7 => array(
					'sort_order' 			  => '8',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_address_2')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_address_2')),
					'view'       			  => 'address_2',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '0',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_address_2')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '2',
					'mask' 							=> ''
				),
				8 => array(
					'sort_order' 			  => '9',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_city')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_city')),
					'view'       			  => 'city',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '1',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_city')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '1',
					'mask' 							=> ''
				),
				9 => array(
					'sort_order' 			  => '10',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_postcode')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_postcode')),
					'view'       			  => 'postcode',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '1',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_postcode')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '2',
					'mask' 							=> ''
				),
				10 => array(
					'sort_order' 			  => '11',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_country_id')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_country_id')),
					'view'       			  => 'country_id',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '1',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_country_id')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '1',
					'mask' 							=> ''
				),
				11 => array(
					'sort_order' 			  => '12',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_zone_id')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_zone_id')),
					'view'       			  => 'zone_id',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment', 'shipping'),
					'check'      			  => '1',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_zone_id')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '2',
					'mask' 							=> ''
				),
				12 => array(
					'sort_order' 			  => '13',
					'name'       			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_comment')),
					'activate'   			  => '1',
					'title'      			  => array($this->config->get('config_admin_language') => $this->language->get('text_field_comment')),
					'view'       			  => 'comment',
					'customer_groups'   => array($this->config->get('config_customer_group_id')),
					'address_blocks'    => array('payment'),
					'check'      			  => '0',
					'check_rule' 			  => '',
					'check_min'  			  => '',
					'check_max'  			  => '',
					'error_text' 			  => array($this->config->get('config_admin_language') => $this->language->get('text_default_error_message') ),
					'placeholder_text'  => array($this->config->get('config_admin_language') => $this->language->get('text_field_comment')),
					'css_id'     			  => '',
					'css_class'  			  => '',
					'position'   			  => '3',
					'mask' 							=> ''
				),
			)
		));

		if (!in_array(self::$_module_name, $this->model_extension_extension->getInstalled('module'))) {
			$this->model_extension_extension->install('module', self::$_module_name);
		}

		$this->session->data['success'] = $text_form['text_success_install'];

		$this->response->redirect($this->url->link('module/'.self::$_module_name, 'token='.$this->session->data['token'], 'SSL'));
	}

	public function uninstall() {

		// connect model data
		$models = array('setting/setting', 'extension/extension');
		foreach ($models as $model) {
				$this->load->model($model);
		}

		$this->model_extension_extension->uninstall('module', self::$_module_name);
		$this->model_setting_setting->deleteSetting(self::$_module_name);
	}

	private function validate() {

		// connect models array
		$models = array('localisation/language');
		foreach ($models as $model) {
			$this->load->model($model);
		}

		$text_form = $this->language->load('module/'.self::$_module_name);

		if (!$this->user->hasPermission('modify', 'module/'.self::$_module_name)) {
			$this->error['warning'] = $text_form['error_permission'];
		}

		foreach ($this->request->post[self::$_module_name.'_text_data'] as $language_code => $value) {
			if ((utf8_strlen($value['heading']) < 1) || (utf8_strlen($value['heading']) > 255)) {
				$this->error['heading'][$language_code] = $this->language->get('error_for_all_field');
			}
			if ((utf8_strlen($value['checkout_button']) < 1) || (utf8_strlen($value['checkout_button']) > 255)) {
				$this->error['checkout_button'][$language_code] = $this->language->get('error_for_all_field');
			}
			if ((utf8_strlen($value['continue_button']) < 1) || (utf8_strlen($value['continue_button']) > 255)) {
				$this->error['continue_button'][$language_code] = $this->language->get('error_for_all_field');
			}
		}

		foreach ($this->request->post[self::$_module_name.'_sp_text_data'] as $language_code => $value) {
			if ((utf8_strlen($value['heading']) < 1) || (utf8_strlen($value['heading']) > 255)) {
				$this->error['sp_heading'][$language_code] = $this->language->get('error_for_all_field');
			}
			if ((utf8_strlen($value['recommended_products_heading']) < 1) || (utf8_strlen($value['recommended_products_heading']) > 255)) {
				$this->error['sp_recommended_products_heading'][$language_code] = $this->language->get('error_for_all_field');
			}
			if ((utf8_strlen($value['success_text']) < 1) || (utf8_strlen($value['success_text']) > 255)) {
				$this->error['sp_success_text'][$language_code] = $this->language->get('error_for_all_field');
			}
		}

		if (isset($this->request->post[self::$_module_name.'_field_data'])) {
			foreach ($this->request->post[self::$_module_name.'_field_data'] as $main_key => $field) {
				foreach ($field as $key => $value) {
					if (empty($value) && $key == "view") {
						$this->error['data_fields'][$main_key][$key] = $this->language->get('error_view');
						$this->error['warning'] = $this->language->get('error_warning');
					}

					foreach ($this->model_localisation_language->getLanguages() as $language) {
						if (empty($value[$language['code']]) && $key == "title") {
							$this->error['data_fields'][$main_key][$key][$language['code']] = $this->language->get('error_field_title');
							$this->error['warning'] = $this->language->get('error_warning');
						}

						if (empty($value[$language['code']]) && $key == "error_text") {
							$this->error['data_fields'][$main_key][$key][$language['code']] = $this->language->get('error_error_text');
							$this->error['warning'] = $this->language->get('error_warning');
						}
					}
				}
			}
		}

		foreach ($this->request->post[self::$_module_name.'_form_data'] as $main_key => $field) {
      if (empty($field) && $main_key == "main_image_width") {
        $this->error['main_image_width'] = $this->language->get('error_for_all_field');
      }
      if (empty($field) && $main_key == "main_image_height") {
        $this->error['main_image_height'] = $this->language->get('error_for_all_field');
      }
		}

		foreach ($this->request->post[self::$_module_name.'_sp_form_data'] as $main_key => $field) {
      if (empty($field) && $main_key == "limit_recommended") {
        $this->error['limit_recommended'] = $this->language->get('error_for_all_field');
      }
      if (empty($field) && $main_key == "main_image_width") {
        $this->error['main_image_width'] = $this->language->get('error_for_all_field');
      }
      if (empty($field) && $main_key == "main_image_height") {
        $this->error['main_image_height'] = $this->language->get('error_for_all_field');
      }
		}

		return (!$this->error) ? TRUE : FALSE;
	}

  public function export_settings() {
  	// connect models array
		$models = array('setting/setting', 'setting/store');
		foreach ($models as $model) {
			$this->load->model($model);
		}

    $module_settings = $this->model_setting_setting->getSetting(self::$_module_name);

    $this->response->addheader('Pragma: public');
    $this->response->addheader('Expires: 0');
    $this->response->addheader('Content-Description: File Transfer');
    $this->response->addheader('Content-Type: application/octet-stream');
    $this->response->addheader('Content-Disposition: attachment; filename='.self::$_module_name.'_'.date("Y-m-d H:i:s", time()).'.txt');
    $this->response->addheader('Content-Transfer-Encoding: binary');

    $this->response->setOutput(serialize($module_settings));
  }
}
?>
