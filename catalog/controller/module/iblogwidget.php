<?php
class ControllerModuleiBlogWidget extends Controller {
	
	private $moduleName = 'iBlog';
	private $moduleNameSmall = 'iblog';
	private $moduleData_module = 'iblog_module';
	private $moduleModel = 'model_module_iblog';
	
	public function index($setting) {
		$this->language->load('module/'.$this->moduleNameSmall);
		$this->load->model('module/'.$this->moduleNameSmall);
		$this->load->model('setting/setting');
    	$data['heading_title']				= $setting['name'];
		$data['no_featured']				= $this->language->get('no_featured');
		$data['no_posts']					= $this->language->get('no_posts');
		$data['iblog_button']				= $this->language->get('iblog_button');

		if(isset($setting['limit']))	{
			$limit = $setting['limit'];
		} else {
			$limit = '20';
		}
		
		$postData = array(
			'limit'              => $limit,
		);		
		
		$data['posts']						= array();
		$data['post_id']					= !empty($this->request->get['post_id']) ? $this->request->get['post_id'] : 0;
		$posts								= $this->{$this->moduleModel}->getPosts($postData);
		$data['featured_post']				= $this->{$this->moduleModel}->getFeaturedPost();
		$data['custom_css']					= $setting['custom_css'];
		$data['featured']					= $setting['featured'];
		
		foreach ($posts as $post) {
			$data['posts'][] = array(
				'post_id'	=> $post['iblog_post_id'],
				'title'		=> $post['title'],
				'image'		=> $post['image'],
				'excerpt'	=> $post['excerpt'],
				'href'		=> $this->url->link('module/'.$this->moduleNameSmall.'/post', 'post_id=' . $post['iblog_post_id'])
			);	
		}

		if ($data['featured_post'] !== false) {
			$this->load->model('tool/image');
	
			if (file_exists(DIR_IMAGE . $data['featured_post']['image'])) {
				$data['featured_post']['image'] = $this->model_tool_image->resize($data['featured_post']['image'], $setting['width'], $setting['height']);
			} else {
				$data['featured_post']['image'] = '';
			}
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/'.$this->moduleNameSmall.'-widget.tpl')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/'.$this->moduleNameSmall.'.css');
			return $this->load->view($this->config->get('config_template').'/template/module/'.$this->moduleNameSmall.'-widget.tpl', $data);
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/'.$this->moduleNameSmall.'.css');
			return $this->load->view('default/template/module/'.$this->moduleNameSmall.'-widget.tpl', $data);
		}  
  	}
}
?>