<?php
class ControllerCommonHeader extends Controller {
	public function index() {

      // Product Option Image PRO module <<
			
      $this->load->model('module/product_option_image_pro');
      $data['poip_installed'] = $this->model_module_product_option_image_pro->installed();
			$data['poip_theme_name'] = $this->model_module_product_option_image_pro->getThemeName();
			
      // >> Product Option Image PRO module
      

        // start: OCdevWizard SMOPC
        $smopc_form_data         = (array)$this->config->get('ocdev_smart_one_page_checkout_form_data');
        $smopc_customer_groups   = isset($smopc_form_data['customer_groups']) ? $smopc_form_data['customer_groups'] : array();
        $smopc_customer_group_id = ($this->customer->isLogged()) ? (int)$this->customer->getGroupId() : (int)$this->config->get('config_customer_group_id');
        $smopc_stores            = isset($smopc_form_data['stores']) ? $smopc_form_data['stores'] : array();
        $smopc_store_id          = (int)$this->config->get('config_store_id');

        if (isset($smopc_form_data['activate']) && $smopc_form_data['activate'] && !in_array($smopc_customer_group_id, $smopc_customer_groups) && !in_array($smopc_store_id, $smopc_stores)) {
          $data['google_analytics_script'] = html_entity_decode($smopc_form_data['google_analytics_script']);
        }
        // end: OCdevWizard SMOPC
      
		// Analytics
		$this->load->model('extension/extension');
		$data['ulogin_form_marker'] = $this->load->controller('module/ulogin');
		$data['analytics'] = array();

		$analytics = $this->model_extension_extension->getExtensions('analytics');

		foreach ($analytics as $analytic) {
			if ($this->config->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $this->load->controller('analytics/' . $analytic['code']);
			}
		}

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
		}

		$data['title'] = $this->document->getTitle();

				$this->document->addStyle('catalog/view/javascript/so_searchpro/css/so_searchpro.css'); 
				$this->document->addStyle('catalog/view/javascript/so_megamenu/so_megamenu.css');
				$this->document->addStyle('catalog/view/javascript/so_megamenu/wide-grid.css');
				$this->document->addScript('catalog/view/javascript/so_megamenu/so_megamenu.js');
			

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();
		$data['scripts'] = $this->document->getScripts();

    // OCFilter start
    $data['noindex'] = $this->document->isNoindex();
    // OCFilter end
      
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');

		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		// cosyone custom code start
			$this->load->language('common/soconfig');
			$data['text_contact'] = $this->language->get('text_contact');
			$data['text_more'] 	  = $this->language->get('text_more');
			$data['text_menu'] 	  = $this->language->get('text_menu');
			
			$data['content_search'] = $this->load->controller('common/content_search');
			$data['content_menu'] = $this->load->controller('common/content_menu');
			$data['content_block1'] = $this->load->controller('common/content_block1');
			// Cosyone ends
		
		$this->load->language('common/header');

		$data['text_home'] = $this->language->get('text_home');

		// Wishlist
		if ($this->customer->isLogged()) {
			$this->load->model('account/wishlist');

			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
			
		} else {
			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		}

		
		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['compare'] = $this->url->link('product/compare');
$this->language->load('product/compare');
$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');

		$data['home'] = $this->url->link('common/home');
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['register'] = $this->url->link('account/register', '', 'SSL');
		$data['login'] = $this->url->link('account/login', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$data['download'] = $this->url->link('account/download', '', 'SSL');
		$data['logout'] = $this->url->link('account/logout', '', 'SSL');
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');
		$data['contact'] = $this->url->link('information/contact');
		$data['telephone'] = $this->config->get('config_telephone');

		$status = true;

		if (isset($this->request->server['HTTP_USER_AGENT'])) {
			$robots = explode("\n", str_replace(array("\r\n", "\r"), "\n", trim($this->config->get('config_robots'))));

			foreach ($robots as $robot) {
				if ($robot && strpos($this->request->server['HTTP_USER_AGENT'], trim($robot)) !== false) {
					$status = false;

					break;
				}
			}
		}

		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		
				
				if(isset($this->request->get['route'])) {
					$route = $this->request->get['route'];
				} else {
					$route = 'common/home';
				}
				
				$route = explode("/", $route);
                
				if($this->config->get('simple_blog_status')) {
    				$this->load->model('simple_blog/article');
    				
    				$count = $this->model_simple_blog_article->getTotalCategories(0);
                }
    				
				if($route[0] == 'simple_blog' && $count && $this->config->get('simple_blog_display_category') && $this->config->get('simple_blog_status')) {
					
					$categories = $this->model_simple_blog_article->getCategories(0);
					
					foreach ($categories as $category) {
						if ($category['top']) {
							// Level 2
							$children_data = array();

							$children = $this->model_simple_blog_article->getCategories($category['simple_blog_category_id']);
							
							foreach ($children as $child) {
								
								$article_total = $this->model_simple_blog_article->getTotalArticles($child['simple_blog_category_id']);
			
								$children_data[] = array(
									'name'  => $child['name'],
									'href'  => $this->url->link('simple_blog/category', 'simple_blog_category_id=' . $category['simple_blog_category_id'] . '_' . $child['simple_blog_category_id'])
								);						
							}
							
							// Level 1
							$data['categories'][] = array(
								'name'     => $category['name'],
								'children' => $children_data,
								'column'   => $category['blog_category_column'] ? $category['blog_category_column'] : 1,
								'href'     => $this->url->link('simple_blog/category', 'simple_blog_category_id=' . $category['simple_blog_category_id'])
							);						
						}
					}
										
				} else {
					$categories = $this->model_catalog_category->getCategories(0);
					
					foreach ($categories as $category) {
						if ($category['top']) {
							// Level 2
							$children_data = array();
			
							$children = $this->model_catalog_category->getCategories($category['category_id']);
			
							foreach ($children as $child) {
								$filter_data = array(
									'filter_category_id'  => $child['category_id'],
									'filter_sub_category' => true
								);
			
								$product_total = $this->model_catalog_product->getTotalProducts($filter_data);
			
								$children_data[] = array(
									'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
									'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
								);						
							}
			
							// Level 1
							$data['categories'][] = array(
								'name'     => $category['name'],
								'children' => $children_data,
								'column'   => $category['column'] ? $category['column'] : 1,
								'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
							);
						}
					}
				}			
			






























		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} else {
				$class = '';
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/header.tpl', $data);
		} else {
			return $this->load->view('default/template/common/header.tpl', $data);
		}
	}
}
