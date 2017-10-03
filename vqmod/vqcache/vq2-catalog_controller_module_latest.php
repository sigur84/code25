<?php
class ControllerModuleLatest extends Controller {
	public function index($setting) {
		$this->load->language('module/latest');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');


      // Product Option Image PRO module <<
      $this->load->model('module/product_option_image_pro');
      $data['poip_installed'] = $this->model_module_product_option_image_pro->installed();
      $data['current_class'] = str_replace("Controller", "", get_class($this));
			$data['poip_theme_name'] = $this->model_module_product_option_image_pro->getThemeName();
			$data['poip_cosyone_rollover_effect'] = $this->config->get('cosyone_rollover_effect');
			$data['isAvaStore'] = $this->model_module_product_option_image_pro->isAvaStore();
      
			
      // >> Product Option Image PRO module
      
		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['products'] = array();

		$filter_data = array(
			'sort'  => 'p.date_added',
			'order' => 'DESC',
			'start' => 0,
			'limit' => $setting['limit']
		);

		$results = $this->model_catalog_product->getProducts($filter_data);

		if ($results) {
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}

				$data['products'][] = array(

      // Product Option Image PRO module <<
      
      'option_images'  => $this->model_module_product_option_image_pro->getCategoryImages( isset($result['product_id']) ? $result['product_id'] : $product_info['product_id'],
        (isset($data['current_class']) && $data['current_class']!= 'ProductCategory' && isset($setting))?($setting):(false)  ),
      // >> Product Option Image PRO module
      
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}


         $x = count($data['products']);
         if ($x) {
            $sc_products = array();
            for ($i=0; $i < $x; $i++) {
               $sc_products[$i] = $data['products'][$i];
               $sc_products[$i]['description'] = $this->shortcodes->do_shortcode($data['products'][$i]['description']);
            }
            $data['products'] = $sc_products;
         }
         
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/latest.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/latest.tpl', $data);
			} else {
				return $this->load->view('default/template/module/latest.tpl', $data);
			}
		}
	}
}
