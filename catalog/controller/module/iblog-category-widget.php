<?php
class ControllerModuleiBlogCategoryWidget extends Controller {
	public function index($setting) {
		$this->load->language('module/iblog');
	
    	$data['heading_title'] = !empty($setting['name']) ? $setting['name'] : $this->language->get('heading_title');

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		if (isset($parts[0])) {
			$data['category_id'] = $parts[0];
		} else {
			$data['category_id'] = 0;
		}

		if (isset($parts[1])) {
			$data['child_id'] = $parts[1];
		} else {
			$data['child_id'] = 0;
		}

		$this->load->model('module/iblog');

		$data['categories'] = array();

		$categories = $this->model_module_iblog->getCategories(0);
	
		foreach ($categories as $category) {
			$children_data = array();

			if ($category['category_id'] == $data['category_id']) {
				$children = $this->model_module_iblog->getCategories($category['category_id']);

				foreach($children as $child) {
					$filter_data = array('filter_category_id' => $child['category_id'], 'filter_sub_category' => true);

					$children_data[] = array(
						'category_id' => $child['category_id'],
						'name' => $child['name'],
						'href' => $this->url->link('module/iblog/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);

				}
			}

			$filter_data = array(
				'filter_category_id'  => $category['category_id'],
				'filter_sub_category' => true
			);

			$data['categories'][] = array(
				'category_id' => $category['category_id'],
				'name'        => $category['name'],
				'children'    => $children_data,
				'href'        => $this->url->link('module/iblog/category', 'path=' . $category['category_id'])
			);
		}
				
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/iblog-category-widget.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/iblog-category-widget.tpl', $data);
		} else {
			return $this->load->view('default/template/module/iblog-category-widget.tpl', $data);
		}
	}
}