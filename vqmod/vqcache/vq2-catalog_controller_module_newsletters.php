<?php
class ControllerModuleNewsletters extends Controller {
	public function index() {
		// cosyone custom code start
			$this->load->language('common/soconfig');
			$data['heading_title1'] = $this->language->get('heading_title1');
			$data['description1'] = $this->language->get('description1');
			$data['Subscribe_text'] = $this->language->get('Subscribe_text');
			$data['email_text'] = $this->language->get('email_text');
		
		$this->load->language('module/newsletter');
		$this->load->model('module/newsletters');
		
		$this->model_module_newsletters->createNewsletter();

		$data['heading_title'] = $this->language->get('heading_title');
		$data['description'] = $this->language->get('description');
		
		$data['text_brands'] = $this->language->get('text_brands');
		$data['text_index'] = $this->language->get('text_index');
		$data['Subscribe_text'] = $this->language->get('Subscribe_text');
		$data['brands'] = array();
		
		
		
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/newsletters.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/newsletters.tpl', $data);
		} else {
			return $this->load->view('default/template/module/newsletters.tpl', $data);
		}
	}
	public function news()
	{
		$this->load->model('module/newsletters');
		
		$json = array();
		$json['message'] = $this->model_module_newsletters->subscribes($this->request->post);
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}
	
}
