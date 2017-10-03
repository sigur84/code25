<?php
class ControllerModuleSolatestblog extends Controller {
	private $error = array();
	public $data = array();
	public function index() {
		$url = $this->request->get['route'];
		$this->load->language('module/so_latest_blog');
		$this->load->model('extension/module');
		if($this->checkDatabase()) {
			$this->document->setTitle($this->language->get('error_database'));
			
			$data['text_install_message'] = $this->language->get('text_install_message');
			
			$data['text_upgread'] = $this->language->get('text_upgread');
			
			$data['error_database'] = $this->language->get('error_database');
			
			$data['breadcrumbs'] = array();

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false
			);
			
			$data['header'] = $this->load->controller('common/header');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['footer'] = $this->load->controller('common/footer');
	
			$this->response->setOutput($this->load->view('module/so_latest_blog/notification.tpl', $data));
			
		} else {
			$this->getData();
		}	
	}
	public function checkDatabase() {
            $database_not_found = $this->validateTable();
            
            if(!$database_not_found) {
                return true;
            } 
            
            return false;
        }
	public function validateTable() {
		$table_name = $this->db->escape('simple_blog_article');
		
		$table = DB_PREFIX . $table_name;
		
		$query = $this->db->query("SHOW TABLES LIKE '{$table}'");
		   
		return $query->num_rows;      
	}
	
	protected function getdata(){
		

		$this->document->setTitle($this->language->get('heading_title'));

		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('so_latest_blog', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}
			
			$action = isset($this->request->post["action"]) ? $this->request->post["action"] : "";
			unset($this->request->post['action']);
		 	$data = $this->request->post;
			
			$this->session->data['success'] = $this->language->get('text_success');
			if($action != "") {
				$this->response->redirect($this->url->link('module/so_latest_blog', 'module_id='.$this->request->post['moduleid'].'&token=' . $this->session->data['token'], 'SSL'));
			}else{
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}
		// Load language
		$data = $this->_languege();
		
		// Load breadcrumbs
		$data = $this->_breadcrumbs();
		// Validation -----------------------------------------
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();
		foreach($data['languages'] as $language){
			$name = 'module_description['.$language['language_id']."]['head_name']";
			if (isset($this->error[$name])) {
				$data['error_head_name'] = $this->error[$name];
				break;
			} else {
				$data['error_head_name'] = '';
			}
		}

		if (isset($this->error['limit'])) {
			$data['error_limit'] = $this->error['limit'];
		} else {
			$data['error_limit'] = '';
		}
		
		if (isset($this->error['title_maxlength'])) {
			$data['error_title_maxlength'] = $this->error['title_maxlength'];
		} else {
			$data['error_title_maxlength'] = '';
		}
		
		if (isset($this->error['description_maxlength'])) {
			$data['error_description_maxlength'] = $this->error['description_maxlength'];
		} else {
			$data['error_description_maxlength'] = '';
		}
		
		if (isset($this->error['readmore_text'])) {
			$data['error_readmore_text'] = $this->error['readmore_text'];
		} else {
			$data['error_readmore_text'] = '';
		}
		
		if (isset($this->error['width'])) {
			$data['error_width'] = $this->error['width'];
		} else {
			$data['error_width'] = '';
		}
		
		if (isset($this->error['height'])) {
			$data['error_height'] = $this->error['height'];
		} else {
			$data['error_height'] = '';
		}
		if (isset($this->error['margin'])) {
			$data['error_margin'] = $this->error['margin'];
		} else {
			$data['error_margin'] = '';
		}

		if (isset($this->error['slideBy'])) {
			$data['error_slideBy'] = $this->error['slideBy'];
		} else {
			$data['error_slideBy'] = '';
		}

		if (isset($this->error['autoplay_timeout'])) {
			$data['error_autoplay_timeout'] = $this->error['autoplay_timeout'];
		} else {
			$data['error_autoplay_timeout'] = '';
		}

		if (isset($this->error['autoplaySpeed'])) {
			$data['error_autoplaySpeed'] = $this->error['autoplaySpeed'];
		} else {
			$data['error_autoplaySpeed'] = '';
		}

		if (isset($this->error['smartSpeed'])) {
			$data['error_smartSpeed'] = $this->error['smartSpeed'];
		} else {
			$data['error_smartSpeed'] = '';
		}

		if (isset($this->error['startPosition'])) {
			$data['error_startPosition'] = $this->error['startPosition'];
		} else {
			$data['error_startPosition'] = '';
		}
		if (isset($this->error['dotsSpeed'])) {
			$data['error_dotsSpeed'] = $this->error['dotsSpeed'];
		} else {
			$data['error_dotsSpeed'] = '';
		}
		if (isset($this->error['navSpeed'])) {
			$data['error_navSpeed'] = $this->error['navSpeed'];
		} else {
			$data['error_navSpeed'] = '';
		}

		if (isset($this->error['duration'])) {
			$data['error_duration'] = $this->error['duration'];
		} else {
			$data['error_duration'] = '';
		}

		if (isset($this->error['delay'])) {
			$data['error_delay'] = $this->error['delay'];
		} else {
			$data['error_delay'] = '';
		}
		//---------------------------------------------------------------------------------
		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('module/so_latest_blog', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/so_latest_blog', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}
		

		$data['token'] = $this->session->data['token'];
	
	// Save and Stay
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		
		$data['text_layout'] = sprintf($this->language->get('text_layout'), $this->url->link('design/layout', 'token=' . $this->session->data['token'], 'SSL'));
	// -----------------------------Top config ----------------------------------------------------
		// Name
		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info) && isset($module_info['name'])) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}
		$this->load->model('module/so_latest_blog');
		$moduleid_new= $this->model_module_so_latest_blog->getModuleId();
		//Module id
		if (isset($this->request->get['module_id'])) {
			$data['moduleid'] = $this->request->get['module_id'];
		} elseif (!empty($module_info) && isset($module_info['moduleid'])) {
			$data['moduleid'] = $module_info['moduleid'];
		} else {
			$data['moduleid'] = $moduleid_new[0]['Auto_increment'];
		}
		
		// Description
		if (isset($this->request->post['module_description'])) {
			$data['module_description'] = $this->request->post['module_description'];
		} elseif (!empty($module_info) && isset($module_info['module_description'])) {
			$data['module_description'] = $module_info['module_description'];
		} else {
			$data['module_description'] = array();
		}
		
		// header title
		if (isset($this->request->post['head_name'])) {
			$data['head_name'] = $this->request->post['head_name'];
		} elseif (!empty($module_info) && isset($module_info['head_name'])) {
			$data['head_name'] = $module_info['head_name'];
		} else {
			$data['head_name'] = '';
		}
		
		// Display title module
		if (isset($this->request->post['disp_title_module'])) {
			$data['disp_title_module'] = $this->request->post['disp_title_module'];
		} elseif (!empty($module_info) && isset($module_info['disp_title_module'])) {
			$data['disp_title_module'] = $module_info['disp_title_module'];
		} else {
			$data['disp_title_module'] = '1';
		}
		
		// Status
		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info) && isset($module_info['status'])) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '1';
		}
		
	//------------------------------------General Option---------------------------------------- 
		// Class Suffix
		if (isset($this->request->post['class_suffix'])) {
			$data['class_suffix'] = $this->request->post['class_suffix'];
		} elseif (!empty($module_info) && isset($module_info['class_suffix'])) {
			$data['class_suffix'] = $module_info['class_suffix'];
		} else {
			$data['class_suffix'] = '';
		}
		
		//  Link Target
		if (isset($this->request->post['item_link_target'])) {
			$data['item_link_target'] = $this->request->post['item_link_target'];
		} elseif (!empty($module_info) && isset($module_info['item_link_target'])) {
			$data['item_link_target'] = $module_info['item_link_target'];
		} else {
			$data['item_link_target'] = '';
		}
		$data['item_link_targets'] = array(
			'_blank' => $this->language->get('value_blank'),
			'_self'  => $this->language->get('value_self'),
		);
		
		//Limit
		if (isset($this->request->post['limit'])) {
			$data['limit'] = $this->request->post['limit'];
		} elseif (!empty($module_info) && isset($module_info['limit'])) {
			$data['limit'] = $module_info['limit'];
		} else {
			$data['limit'] = '4';
		}
		// config button page
		if (isset($this->request->post['button_page'])) {
			$data['button_page'] = $this->request->post['button_page'];
		} elseif (!empty($module_info) && isset($module_info['button_page'])) {
			$data['button_page'] = $module_info['button_page'];
		} else {
			$data['button_page'] = '';
		}
		$data['button_pages'] = array(
			'top' => 'Top',
			'under'  => 'Under',
		);

		$data['nb_columns'] = array(
			'1'   => '1',
			'2'   => '2',
			'3'   => '3',
			'4'   => '4',
			'5'   => '5',
			'6'   => '6',
		);

		if (isset($this->request->post['nb_column0'])) {
			$data['nb_column0'] = $this->request->post['nb_column0'];
		} elseif (!empty($module_info) && isset($module_info['nb_column0'])) {
			$data['nb_column0'] = $module_info['nb_column0'];
		} else {
			$data['nb_column0'] = 6;
		}

		if (isset($this->request->post['nb_column1'])) {
			$data['nb_column1'] = $this->request->post['nb_column1'];
		} elseif (!empty($module_info) && isset($module_info['nb_column1'])) {
			$data['nb_column1'] = $module_info['nb_column1'];
		} else {
			$data['nb_column1'] = 4;
		}

		if (isset($this->request->post['nb_column2'])) {
			$data['nb_column2'] = $this->request->post['nb_column2'];
		} elseif (!empty($module_info) && isset($module_info['nb_column2'])) {
			$data['nb_column2'] = $module_info['nb_column2'];
		} else {
			$data['nb_column2'] = 3;
		}

		if (isset($this->request->post['nb_column3'])) {
			$data['nb_column3'] = $this->request->post['nb_column3'];
		} elseif (!empty($module_info) && isset($module_info['nb_column3'])) {
			$data['nb_column3'] = $module_info['nb_column3'];
		} else {
			$data['nb_column3'] = 2;
		}

		if (isset($this->request->post['nb_column4'])) {
			$data['nb_column4'] = $this->request->post['nb_column4'];
		} elseif (!empty($module_info) && isset($module_info['nb_column4'])) {
			$data['nb_column4'] = $module_info['nb_column4'];
		} else {
			$data['nb_column4'] = 1;
		}
		// Type show
		$data['type_shows']  = array(
			'simple' => $this->language->get('type_show_simple'),
			'slider' => $this->language->get('type_show_slider')
		);
		if (isset($this->request->post['type_show'])) {
			$data['type_show'] = $this->request->post['type_show'];
		} elseif (!empty($module_info) && isset($module_info['type_show'])) {
			$data['type_show'] = $module_info['type_show'];
		} else {
			$data['type_show'] = 'simple';
		}
		$data['nb_rows'] = array(
			'1'   => '1',
			'2'   => '2',
			'3'   => '3',
			'4'   => '4',
			'5'   => '5',
			'6'   => '6',
		);
		if (isset($this->request->post['nb_row'])) {
			$data['nb_row'] = $this->request->post['nb_row'];
		} elseif (!empty($module_info) && isset($module_info['nb_row'])) {
			$data['nb_row'] = $module_info['nb_row'];
		} else {
			$data['nb_row'] = 1;
		}

		//----------------------------------Blog Option----------------------------------------
		// Display Title
		if (isset($this->request->post['display_title'])) {
			$data['display_title'] = $this->request->post['display_title'];
		} elseif (!empty($module_info) && isset($module_info['display_title'])) {
			$data['display_title'] = $module_info['display_title'];
		} else {
			$data['display_title'] = '1';
		}
		
		// Title Maxlength
		if (isset($this->request->post['title_maxlength'])) {
			$data['title_maxlength'] = $this->request->post['title_maxlength'];
		} elseif (!empty($module_info) && isset($module_info['title_maxlength'])) {
			$data['title_maxlength'] = $module_info['title_maxlength'];
		} else {
			$data['title_maxlength'] = '20';
		}
		
		//Display Description
		if (isset($this->request->post['display_description'])) {
			$data['display_description'] = $this->request->post['display_description'];
		} elseif (!empty($module_info) && isset($module_info['display_description'])) {
			$data['display_description'] = $module_info['display_description'];
		} else {
			$data['display_description'] = '1';
		}
		
		//Description Maxlength
		if (isset($this->request->post['description_maxlength'])) {
			$data['description_maxlength'] = $this->request->post['description_maxlength'];
		} elseif (!empty($module_info) && isset($module_info['description_maxlength'])) {
			$data['description_maxlength'] = $module_info['description_maxlength'];
		} else {
			$data['description_maxlength'] = '50';
		}
		
		//Display author
		if (isset($this->request->post['display_author'])) {
			$data['display_author'] = $this->request->post['display_author'];
		} elseif (!empty($module_info) && isset($module_info['display_author'])) {
			$data['display_author'] = $module_info['display_author'];
		} else {
			$data['display_author'] = '1';
		}
		
		//Display comment
		if (isset($this->request->post['display_comment'])) {
			$data['display_comment'] = $this->request->post['display_comment'];
		} elseif (!empty($module_info) && isset($module_info['display_comment'])) {
			$data['display_comment'] = $module_info['display_comment'];
		} else {
			$data['display_comment'] = '1';
		}
		
		//Display view
		if (isset($this->request->post['display_view'])) {
			$data['display_view'] = $this->request->post['display_view'];
		} elseif (!empty($module_info) && isset($module_info['display_view'])) {
			$data['display_view'] = $module_info['display_view'];
		} else {
			$data['display_view'] = '1';
		}
		
		//Display date added
		if (isset($this->request->post['display_date_added'])) {
			$data['display_date_added'] = $this->request->post['display_date_added'];
		} elseif (!empty($module_info) && isset($module_info['display_date_added'])) {
			$data['display_date_added'] = $module_info['display_date_added'];
		} else {
			$data['display_date_added'] = '1';
		}
		
		//Display Readmore
		if (isset($this->request->post['display_readmore'])) {
			$data['display_readmore'] = $this->request->post['display_readmore'];
		} elseif (!empty($module_info) && isset($module_info['display_readmore'])) {
			$data['display_readmore'] = $module_info['display_readmore'];
		} else {
			$data['display_readmore'] = '1';
		}
		
		//Reamdmore text
		if (isset($this->request->post['readmore_text'])) {
			$data['readmore_text'] = $this->request->post['readmore_text'];
		} elseif (!empty($module_info) && isset($module_info['readmore_text'])) {
			$data['readmore_text'] = $module_info['readmore_text'];
		} else {
			$data['readmore_text'] = 'Read more';
		}
	// Image Option----------------------------------------
		// blog Image
		if (isset($this->request->post['blog_image'])) {
			$data['blog_image'] = $this->request->post['blog_image'];
		} elseif (!empty($module_info) && isset($module_info['blog_image'])) {
			$data['blog_image'] = $module_info['blog_image'];
		} else {
			$data['blog_image'] = '1';
		}
		
		// blog Get Featured image
		if (isset($this->request->post['blog_get_featured_image'])) {
			$data['blog_get_featured_image'] = $this->request->post['blog_get_featured_image'];
		} elseif (!empty($module_info) && isset($module_info['blog_get_featured_image'])) {
			$data['blog_get_featured_image'] = $module_info['blog_get_featured_image'];
		} else {
			$data['blog_get_featured_image'] = '1';
		}
		
		// blog Width
		if (isset($this->request->post['width'])) {
			$data['width'] = $this->request->post['width'];
		} elseif (!empty($module_info) && isset($module_info['width'])) {
			$data['width'] = $module_info['width'];
		} else {
			$data['width'] = '100';
		}
		
		// blog Height
		if (isset($this->request->post['height'])) {
			$data['height'] = $this->request->post['height'];
		} elseif (!empty($module_info) && isset($module_info['height'])) {
			$data['height'] = $module_info['height'];
		} else {
			$data['height'] = '75';
		}
		
		// blog Placeholder Path
		if (isset($this->request->post['blog_placeholder_path'])) {
			$data['blog_placeholder_path'] = $this->request->post['blog_placeholder_path'];
		} elseif (!empty($module_info) && isset($module_info['blog_placeholder_path'])) {
			$data['blog_placeholder_path'] = $module_info['blog_placeholder_path'];
		} else {
			$data['blog_placeholder_path'] = 'nophoto.png';
		}
		// config effect options
		//Margin
		if (isset($this->request->post['margin'])) {
			$data['margin'] = $this->request->post['margin'];
		} elseif (!empty($module_info) && isset($module_info['margin'])) {
			$data['margin'] = $module_info['margin'];
		} else {
			$data['margin'] = '5';
		}

		//SlideBy Item
		if (isset($this->request->post['slideBy'])) {
			$data['slideBy'] = $this->request->post['slideBy'];
		} elseif (!empty($module_info) && isset($module_info['slideBy'])) {
			$data['slideBy'] = $module_info['slideBy'];
		} else {
			$data['slideBy'] = '1';
		}

		if (isset($this->request->post['autoplay'])) {
			$data['autoplay'] = $this->request->post['autoplay'];
		} elseif (!empty($module_info) && isset($module_info['autoplay'])) {
			$data['autoplay'] = $module_info['autoplay'];
		} else {
			$data['autoplay'] = '1';
		}
		//Auto Play Speed
		if (isset($this->request->post['autoplaySpeed'])) {
			$data['autoplaySpeed'] = $this->request->post['autoplaySpeed'];
		} elseif (!empty($module_info) && isset($module_info['autoplaySpeed'])) {
			$data['autoplaySpeed'] = $module_info['autoplaySpeed'];
		} else {
			$data['autoplaySpeed'] = '1000';
		}

		//Smart Speed
		if (isset($this->request->post['smartSpeed'])) {
			$data['smartSpeed'] = $this->request->post['smartSpeed'];
		} elseif (!empty($module_info) && isset($module_info['smartSpeed'])) {
			$data['smartSpeed'] = $module_info['smartSpeed'];
		} else {
			$data['smartSpeed'] = '1000';
		}

		//Start Position Item
		if (isset($this->request->post['startPosition'])) {
			$data['startPosition'] = $this->request->post['startPosition'];
		} elseif (!empty($module_info) && isset($module_info['startPosition'])) {
			$data['startPosition'] = $module_info['startPosition'];
		} else {
			$data['startPosition'] = '0';
		}

		//Mouse Drag
		if (isset($this->request->post['mouseDrag'])) {
			$data['mouseDrag'] = $this->request->post['mouseDrag'];
		} elseif (!empty($module_info) && isset($module_info['mouseDrag'])) {
			$data['mouseDrag'] = $module_info['mouseDrag'];
		} else {
			$data['mouseDrag'] = '1';
		}

		//Touch Drag
		if (isset($this->request->post['touchDrag'])) {
			$data['touchDrag'] = $this->request->post['touchDrag'];
		} elseif (!empty($module_info) && isset($module_info['touchDrag'])) {
			$data['touchDrag'] = $module_info['touchDrag'];
		} else {
			$data['touchDrag'] = '1';
		}

		//Effects
		$data['effects'] = array(
			'none' => 'None',
			'slideLeft'  => 'Slide Left',
			'slideRight' => 'Slide Right',
			'zoomOut' => 'Zoom Out',
			'zoomIn' =>'Zoom In',
			'flip'=>'Flip',
			'flipInX' => 'Flip in Horizontal',
			'flipInY' => 'Flip in Vertical',
			'starwars'=> 'Star war',
			'bounceIn' => 'Bounce In',
			'fadeIn' => 'Fade In',
			'pageTop'=> 'Page Top',
		);
		if (isset($this->request->post['effects'])) {
			$data['effect'] = $this->request->post['effect'];
		} elseif (!empty($module_info) && isset($module_info['effect'])) {
			$data['effect'] = $module_info['effect'];
		} else {
			$data['effect'] = 'starwars';
		}
		//Show Pagination
		if (isset($this->request->post['dots'])) {
			$data['dots'] = $this->request->post['dots'];
		} elseif (!empty($module_info) && isset($module_info['dots'])) {
			$data['dots'] = $module_info['dots'];
		} else {
			$data['dots'] = '1';
		}

		//Pagination Speed
		if (isset($this->request->post['dotsSpeed'])) {
			$data['dotsSpeed'] = $this->request->post['dotsSpeed'];
		} elseif (!empty($module_info) && isset($module_info['dotsSpeed'])) {
			$data['dotsSpeed'] = $module_info['dotsSpeed'];
		} else {
			$data['dotsSpeed'] = '500';
		}
		//Show Navigation
		if (isset($this->request->post['navs'])) {
			$data['navs'] = $this->request->post['navs'];
		} elseif (!empty($module_info) && isset($module_info['navs'])) {
			$data['navs'] = $module_info['navs'];
		} else {
			$data['navs'] = '1';
		}
		//Navigation Speed
		if (isset($this->request->post['navSpeed'])) {
			$data['navSpeed'] = $this->request->post['navSpeed'];
		} elseif (!empty($module_info) && isset($module_info['navSpeed'])) {
			$data['navSpeed'] = $module_info['navSpeed'];
		} else {
			$data['navSpeed'] = '500';
		}

		// Duration
		if (isset($this->request->post['duration'])) {
			$data['duration'] = $this->request->post['duration'];
		} elseif (!empty($module_info) && isset($module_info['duration'])) {
			$data['duration'] = $module_info['duration'];
		} else {
			$data['duration'] = '600';
		}

		// Delay
		if (isset($this->request->post['delay'])) {
			$data['delay'] = $this->request->post['delay'];
		} elseif (!empty($module_info) && isset($module_info['delay'])) {
			$data['delay'] = $module_info['delay'];
		} else {
			$data['delay'] = '300';
		}

		if (isset($this->request->post['pausehover'])) {
			$data['pausehover'] = $this->request->post['pausehover'];
		} elseif (!empty($module_info) && isset($module_info['pausehover'])) {
			$data['pausehover'] = $module_info['pausehover'];
		} else {
			$data['pausehover'] = '1';
		}

		if (isset($this->request->post['autoplay_timeout'])) {
			$data['autoplay_timeout'] = $this->request->post['autoplay_timeout'];
		} elseif (!empty($module_info) && isset($module_info['autoplay_timeout'])) {
			$data['autoplay_timeout'] = $module_info['autoplay_timeout'];
		} else {
			$data['autoplay_timeout'] = '5000';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('module/so_latest_blog/so_latest_blog.tpl', $data));
	}
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/so_latest_blog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();

		foreach($languages as $language){
			$module_description = $this->request->post['module_description'];
			if ((utf8_strlen($module_description[$language['language_id']]['head_name']) < 3) || (utf8_strlen($module_description[$language['language_id']]['head_name']) > 64)) {
				$this->error['module_description['.$language['language_id']."]['head_name']"] = $this->language->get('error_head_name');
			}
		}

		if ($this->request->post['limit'] != '0' && !filter_var($this->request->post['limit'],FILTER_VALIDATE_FLOAT) || $this->request->post['limit'] < 0) {
			$this->error['limit'] = $this->language->get('error_limit');
		}
		
		if ($this->request->post['title_maxlength'] != '0' && !filter_var($this->request->post['title_maxlength'],FILTER_VALIDATE_FLOAT) || $this->request->post['title_maxlength'] < 0) {
			
			$this->error['title_maxlength'] = $this->language->get('error_title_maxlength');
		}
		
		if ($this->request->post['description_maxlength'] != '0' && !filter_var($this->request->post['description_maxlength'],FILTER_VALIDATE_FLOAT) || $this->request->post['description_maxlength'] < 0) {
			$this->error['description_maxlength'] = $this->language->get('error_description_maxlength');
		}
		
		if ((utf8_strlen($this->request->post['readmore_text']) < 1) ) {
			$this->error['readmore_text'] = $this->language->get('error_readmore_text');
		}
		
		if (!filter_var($this->request->post['width'],FILTER_VALIDATE_FLOAT) || $this->request->post['width'] < 0) {
			$this->error['width'] = $this->language->get('error_width');
		}
		if (!filter_var($this->request->post['height'],FILTER_VALIDATE_FLOAT) || $this->request->post['height'] < 0) {
			$this->error['height'] = $this->language->get('error_height');
		}
		if ($this->request->post['autoplay_timeout'] != '0' && !filter_var($this->request->post['autoplay_timeout'],FILTER_VALIDATE_INT) || $this->request->post['autoplay_timeout'] < 0) {
			$this->error['autoplay_timeout'] = $this->language->get('error_autoplay_timeout');
		}

		if (!filter_var($this->request->post['navSpeed'],FILTER_VALIDATE_INT) || $this->request->post['navSpeed'] < 0) {
			$this->error['navSpeed'] = $this->language->get('error_navSpeed');
		}

		if ($this->request->post['duration'] != '0' && !filter_var($this->request->post['duration'],FILTER_VALIDATE_INT) || $this->request->post['duration'] < 0) {
			$this->error['duration'] = $this->language->get('error_duration');
		}

		if ($this->request->post['delay'] != '0' && !filter_var($this->request->post['delay'],FILTER_VALIDATE_INT) || $this->request->post['delay'] < 0) {
			$this->error['delay'] = $this->language->get('error_delay');
		}
		if (!filter_var($this->request->post['margin'],FILTER_VALIDATE_INT) || $this->request->post['margin'] < 0) {
			$this->error['margin'] = $this->language->get('error_margin');
		}

		if (!filter_var($this->request->post['slideBy'],FILTER_VALIDATE_INT) || $this->request->post['slideBy'] < 0) {
			$this->error['slideBy'] = $this->language->get('error_slideBy');
		}
		if (!filter_var($this->request->post['autoplaySpeed'],FILTER_VALIDATE_INT) || $this->request->post['autoplaySpeed'] < 0) {
			$this->error['autoplaySpeed'] = $this->language->get('error_autoplaySpeed');
		}

		if (!filter_var($this->request->post['smartSpeed'],FILTER_VALIDATE_INT) || $this->request->post['smartSpeed'] < 0) {
			$this->error['smartSpeed'] = $this->language->get('error_smartSpeed');
		}

		if ($this->request->post['startPosition'] != '0' && !filter_var($this->request->post['startPosition'],FILTER_VALIDATE_INT) || $this->request->post['startPosition'] < 0) {
			$this->error['startPosition'] = $this->language->get('error_startPosition');
		}
		if (!filter_var($this->request->post['dotsSpeed'],FILTER_VALIDATE_INT) || $this->request->post['dotsSpeed'] < 0) {
			$this->error['dotsSpeed'] = $this->language->get('error_dotsSpeed');
		}
		return !$this->error;
	}
	public function _languege(){
		$this->data['heading_title'] 		= $this->language->get('heading_title');
		// Chung
		$this->data['help_blog'] 			= $this->language->get('help_blog');
		$this->data['text_edit'] 			= $this->language->get('text_edit');
		$this->data['text_enabled'] 		= $this->language->get('text_enabled');
		$this->data['text_disabled'] 		= $this->language->get('text_disabled');
		$this->data['text_yes'] 			= $this->language->get('text_yes');
		$this->data['text_no'] 				= $this->language->get('text_no');
	// Button
		$this->data['entry_button_save'] 			= $this->language->get('entry_button_save');
		$this->data['entry_button_save_and_stay'] 	= $this->language->get('entry_button_save_and_stay');
		$this->data['entry_button_cancel'] 			= $this->language->get('entry_button_cancel');
	// Top config
		$this->data['entry_head_name'] 				= $this->language->get('entry_head_name');
		$this->data['entry_head_name_desc'] 			= $this->language->get('entry_head_name_desc');
		$this->data['entry_name'] 					= $this->language->get('entry_name');
		$this->data['entry_name_desc'] 				= $this->language->get('entry_name_desc');
		$this->data['entry_module'] 					= $this->language->get('entry_module');
		$this->data['entry_display_title_module']     = $this->language->get('entry_display_title_module');
		$this->data['entry_display_title_module_desc']= $this->language->get('entry_display_title_module_desc');
		$this->data['entry_status'] 					= $this->language->get('entry_status');
		$this->data['entry_status_desc']				= $this->language->get('entry_status_desc');
	
	// General Option----------------------------------------
		$this->data['entry_source_option'] 			= $this->language->get('entry_source_option');
		$this->data['entry_class_suffix']				= $this->language->get('entry_class_suffix');
		$this->data['entry_class_suffix_desc']		= $this->language->get('entry_class_suffix_desc');
		$this->data['entry_open_link'] 				= $this->language->get('entry_open_link');
		$this->data['entry_open_link_desc'] 			= $this->language->get('entry_open_link_desc');
		$this->data['entry_limit'] 				= $this->language->get('entry_limit');
		$this->data['entry_limit_desc'] 			= $this->language->get('entry_limit_desc');
		$this->data['entry_button_page'] 				= $this->language->get('entry_button_page');
		$this->data['entry_button_page_desc'] 		= $this->language->get('entry_button_page_desc');
		$this->data['entry_column'] 					= $this->language->get('entry_column');
		$this->data['entry_nb_column0_desc'] 			= $this->language->get('entry_nb_column0_desc');
		$this->data['entry_nb_column1_desc'] 			= $this->language->get('entry_nb_column1_desc');
		$this->data['entry_nb_column2_desc'] 			= $this->language->get('entry_nb_column2_desc');
		$this->data['entry_nb_column3_desc'] 			= $this->language->get('entry_nb_column3_desc');
		$this->data['entry_nb_column4_desc'] 			= $this->language->get('entry_nb_column4_desc');
		$this->data['entry_type_show'] 			= $this->language->get('entry_type_show');
		$this->data['entry_type_show_desc'] 	= $this->language->get('entry_type_show_desc');
		$this->data['entry_nb_row'] 					= $this->language->get('entry_nb_row');
		$this->data['entry_nb_row_desc'] 				= $this->language->get('entry_nb_row_desc');

		// 	blog Option----------------------------------------
		$this->data['entry_blog_option'] 				= $this->language->get('entry_blog_option');
		$this->data['entry_display_title'] 				= $this->language->get('entry_display_title');
		$this->data['entry_display_title_desc'] 		= $this->language->get('entry_display_title_desc');
		$this->data['entry_title_maxlength'] 			= $this->language->get('entry_title_maxlength');
		$this->data['entry_title_maxlength_desc'] 		= $this->language->get('entry_title_maxlength_desc');
		$this->data['entry_display_description'] 		= $this->language->get('entry_display_description');
		$this->data['entry_display_description_desc'] 	= $this->language->get('entry_display_description_desc');
		$this->data['entry_display_author'] 			= $this->language->get('entry_display_author');
		$this->data['entry_display_author_desc'] 		= $this->language->get('entry_display_author_desc');
		$this->data['entry_display_comment'] 			= $this->language->get('entry_display_comment');
		$this->data['entry_display_comment_desc'] 		= $this->language->get('entry_display_comment_desc');
		$this->data['entry_display_view'] 				= $this->language->get('entry_display_view');
		$this->data['entry_display_view_desc'] 			= $this->language->get('entry_display_view_desc');
		$this->data['entry_display_date_added'] 		= $this->language->get('entry_display_date_added');
		$this->data['entry_display_date_added_desc'] 	= $this->language->get('entry_display_date_added_desc');
		$this->data['entry_description_maxlength'] 		= $this->language->get('entry_description_maxlength');
		$this->data['entry_description_maxlength_desc']	= $this->language->get('entry_description_maxlength_desc');
		$this->data['entry_display_readmore'] 			= $this->language->get('entry_display_readmore');
		$this->data['entry_display_readmore_desc'] 		= $this->language->get('entry_display_readmore_desc');
		$this->data['entry_readmore_text'] 				= $this->language->get('entry_readmore_text');
		$this->data['entry_readmore_text_desc']			= $this->language->get('entry_readmore_text_desc');
	
	// Image Option----------------------------------------
		$this->data['entry_image_option'] 			= $this->language->get('entry_image_option');
		$this->data['entry_blog_image'] 			= $this->language->get('entry_blog_image');
		$this->data['entry_blog_image_desc'] 		= $this->language->get('entry_blog_image_desc');
		$this->data['entry_blog_get_image'] 	= $this->language->get('entry_blog_get_image');
		$this->data['entry_blog_get_image_desc'] = $this->language->get('entry_blog_get_image_desc');
		$this->data['entry_blog_get_featured_image'] 	= $this->language->get('entry_blog_get_featured_image');
		$this->data['entry_blog_get_featured_image_desc'] = $this->language->get('entry_blog_get_featured_image_desc');
		$this->data['entry_width'] 					= $this->language->get('entry_width');
		$this->data['entry_width_desc'] 				= $this->language->get('entry_width_desc');
		$this->data['entry_height'] 					= $this->language->get('entry_height');
		$this->data['entry_height_desc'] 				= $this->language->get('entry_height_desc');
		$this->data['entry_blog_placeholder_path'] 	= $this->language->get('entry_blog_placeholder_path');
		$this->data['entry_blog_placeholder_path_desc'] = $this->language->get('entry_blog_placeholder_path_desc');
	// Effect Options
		$this->data['entry_effect_option'] 			= $this->language->get('entry_effect_option');
		$this->data['entry_margin'] 				= $this->language->get('entry_margin');
		$this->data['entry_margin_desc'] 			= $this->language->get('entry_margin_desc');
		$this->data['entry_slideBy'] 				= $this->language->get('entry_slideBy');
		$this->data['entry_slideBy_desc'] 		= $this->language->get('entry_slideBy_desc');
		$this->data['entry_autoplay']					= $this->language->get('entry_autoplay');
		$this->data['entry_effect']					= $this->language->get('entry_effect');
		$this->data['entry_duration'] 				= $this->language->get('entry_duration');
		$this->data['entry_duration_desc'] 			= $this->language->get('entry_duration_desc');
		$this->data['entry_delay'] 					= $this->language->get('entry_delay');
		$this->data['entry_delay_desc'] 				= $this->language->get('entry_delay_desc');
		$this->data['entry_pausehover'] 				= $this->language->get('entry_pausehover');
		$this->data['entry_pausehover_desc'] 			= $this->language->get('entry_pausehover_desc');
		$this->data['entry_autoplay_timeout'] 		= $this->language->get('entry_autoplay_timeout');
		$this->data['entry_autoplay_timeout_desc'] 	= $this->language->get('entry_autoplay_timeout_desc');
		$this->data['entry_autoplaySpeed'] 		= $this->language->get('entry_autoplaySpeed');
		$this->data['entry_autoplaySpeed_desc'] 	= $this->language->get('entry_autoplaySpeed_desc');
		$this->data['entry_smartSpeed'] 			= $this->language->get('entry_smartSpeed');
		$this->data['entry_smartSpeed_desc'] 		= $this->language->get('entry_smartSpeed_desc');
		$this->data['entry_startPosition'] 		= $this->language->get('entry_startPosition');
		$this->data['entry_startPosition_desc'] 	= $this->language->get('entry_startPosition_desc');
		$this->data['entry_mouseDrag'] 			= $this->language->get('entry_mouseDrag');
		$this->data['entry_mouseDrag_desc'] 		= $this->language->get('entry_mouseDrag_desc');
		$this->data['entry_touchDrag'] 			= $this->language->get('entry_touchDrag');
		$this->data['entry_touchDrag_desc'] 		= $this->language->get('entry_touchDrag_desc');
		$this->data['entry_dots'] 				= $this->language->get('entry_dots');
		$this->data['entry_dots_desc'] 			= $this->language->get('entry_dots_desc');
		$this->data['entry_dotsSpeed'] 			= $this->language->get('entry_dotsSpeed');
		$this->data['entry_dotsSpeed_desc'] 		= $this->language->get('entry_dotsSpeed_desc');
		$this->data['entry_navs'] 				= $this->language->get('entry_navs');
		$this->data['entry_navs_desc'] 			= $this->language->get('entry_navs_desc');
		$this->data['entry_navspeed'] 			= $this->language->get('entry_navspeed');
		$this->data['entry_navspeed_desc'] 		= $this->language->get('entry_navspeed_desc');
		return $this->data;
	}
	public function _breadcrumbs(){
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		if (!isset($this->request->get['module_id'])) {
			$this->data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('module/so_latest_blog', 'token=' . $this->session->data['token'], 'SSL')
			);
		} else {
			$this->data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('module/so_latest_blog', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
			);
		}
		return $this->data;
	}
	
}
