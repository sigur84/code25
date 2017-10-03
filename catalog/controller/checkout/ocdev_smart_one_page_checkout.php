<?php

// @category  : OpenCart
// @module    : Smart One Page Checkout
// @author    : OCdevWizard <ocdevwizard@gmail.com>
// @copyright : Copyright (c) 2015, OCdevWizard
// @license   : http://license.ocdevwizard.com/Licensing_Policy.pdf

class ControllerCheckoutOCdevSmartOnePageCheckout extends Controller {

  static $_module_version = '1.0.3';
  static $_module_name    = 'ocdev_smart_one_page_checkout';

  public function index() {
    $data = array();

    // connect models array
    $models = array('extension/extension', 'tool/image', 'tool/upload', 'account/address', 'localisation/country', 'catalog/information', 'account/customer_group', 'account/customer');
    foreach ($models as $model) {
      $this->load->model($model);
    }

    $data['cart_status'] = $this->cart->hasProducts();

    $data = array_merge($data, $this->language->load('checkout/'.self::$_module_name), $this->config->get(self::$_module_name.'_text_data'), $this->config->get(self::$_module_name.'_form_data'));

    $text_data  = (array)$this->config->get(self::$_module_name.'_text_data');
    $form_data  = (array)$this->config->get(self::$_module_name.'_form_data');

    $language_code = $this->session->data['language'];

    if (isset($text_data[$language_code])) {
      $this->document->setTitle($text_data[$language_code]['heading']);
      $data['heading_title'] = $text_data[$language_code]['heading'];
      $data['additional_text'] = html_entity_decode($text_data[$language_code]['additional'], ENT_QUOTES, 'UTF-8');
      $data['button_checkout'] = $text_data[$language_code]['checkout_button'];
      $data['button_cancel'] = $text_data[$language_code]['continue_button'];
    }

    // enable only when template don't uses bootstrap library
    //$this->document->addScript('https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js');

    $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
    $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
    $this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

    // required by klarna
    if ($this->config->get('klarna_account') || $this->config->get('klarna_invoice')) {
      $this->document->addScript('http://cdn.klarna.com/public/kitt/toc/v1.0/js/klarna.terms.min.js');
    }

    $this->document->addScript('catalog/view/javascript/'.self::$_module_name.'/inputmask.js');
    $this->document->addScript('catalog/view/javascript/'.self::$_module_name.'/'.self::$_module_name.'.js');

    if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/stylesheet/'.self::$_module_name.'/stylesheet.css')) {
      $this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template').'/stylesheet/'.self::$_module_name.'/stylesheet.css');
    } else {
      $this->document->addStyle('catalog/view/theme/default/stylesheet/'.self::$_module_name.'/stylesheet.css');
    }

    $data['breadcrumbs'] = array();

    $data['breadcrumbs'][] = array(
      'text' => $this->language->get('text_home'),
      'href' => $this->url->link('common/home')
    );

    $data['breadcrumbs'][] = array(
      'text' => $this->language->get('heading_title'),
      'href' => $this->url->link('checkout/'.self::$_module_name, '', 'SSL')
    );

    if (isset($this->session->data['error'])) {
      $data['error_warning'] = $this->session->data['error'];
      unset($this->session->data['error']);
    } else {
      $data['error_warning'] = '';
    }

    $data['logged'] = $this->customer->isLogged();
    $data['checkout_guest'] = ($this->config->get('config_checkout_guest') && !$this->config->get('config_customer_price') && !$this->cart->hasDownload());
    $data['account'] = (isset($this->session->data['account'])) ? $this->session->data['account'] : 'register';
    $data['shipping_required'] = $this->cart->hasShipping();
    $data['shipping_address'] = (isset($this->request->request['shipping_address'])) ? false : true;
    $data['entry_newsletter'] = sprintf($this->language->get('entry_newsletter'), $this->config->get('config_name'));
    $data['success_page'] = $this->url->link('checkout/success', '', 'SSL');
    $data['button_registered_user'] = sprintf($this->language->get('text_logged'), $this->customer->getFirstName());

    $dafault_country_id = (isset($form_data['countries_default']) && $form_data['countries_default']) ? $form_data['countries_default'] : $this->config->get('config_country_id');

    // geuest info
    if (!isset($this->session->data['shipping_address'])) {
      $this->session->data['shipping_address'] = array('country_id' => $dafault_country_id, 'zone_id' => $this->config->get('config_zone_id'));
    }
    if (!isset($this->session->data['payment_address'])) {
      $this->session->data['payment_address']  = array('country_id' => $dafault_country_id, 'zone_id' => $this->config->get('config_zone_id'));
    }

    if (isset($this->request->get['country_id'])) {
      $this->session->data['shipping_address']['country_id'] = $this->request->get['country_id'];
    }

    if (isset($this->request->get['zone_id'])) {
      $this->session->data['shipping_address']['zone_id'] = $this->request->get['zone_id'];
    }

    $data['customer_groups'] = array();

    if (isset($form_data['customer_group_id_array'])) {
      $customer_groups = $this->model_account_customer_group->getCustomerGroups();
      foreach ($customer_groups as $customer_group) {
        if (in_array($customer_group['customer_group_id'], $form_data['customer_group_id_array'])) {
          $data['customer_groups'][] = $customer_group;
        }
      }
    }

    $data['country_id'] = isset($form_data['countries_default']) ? $form_data['countries_default'] : $dafault_country_id;

    $customer_info = ($this->customer->isLogged()) ? $this->model_account_customer->getCustomer($this->customer->getId()) : false;

    $customer_info_data = array('firstname', 'lastname', 'email', 'telephone', 'fax');

    $data['payment_address_fields'] = array();
    $data['shipping_address_fields'] = array();

    if (isset($this->request->request['customer_group_id'])) {
      $customer_group_id = $this->request->request['customer_group_id'];
    } else {
      $customer_group_id = ($this->customer->isLogged()) ? (int)$this->customer->getGroupId() : (int)$this->config->get('config_customer_group_id');
    }

    // PAYMENT ADDRESS - DEFAULT VALUES:
    // if !logged = firstname, lastname, email, telephone, fax, company, address_1, address_2, city, postcode, country_id, zone_id;
    // if logged = firstname, lastname, company, address_1, address_2, city, postcode, country_id, zone_id;

    foreach ($this->getActiveField($customer_group_id, 'payment') as $field) {
      switch ($field['position']) {
        case '1': $position = "smopc-col-sm-6 smopc-pull-left"; break;
        case '2': $position = "smopc-col-sm-6 smopc-pull-right"; break;
        case '3': $position = "smopc-col-sm-12"; break;
      }

      $data['payment_address_fields'][] = array(
        'activate'          => $field['activate'],
        'title'             => $field['title'][$language_code],
        'value'             => $this->replaceValue($field['view'], 1),
        'name'              => $this->replaceValue($field['view'], 2),
        'type'              => $this->replaceValue($field['view'], 1),
        'check'             => $field['check'],
        'error_text'        => $field['error_text'],
        'css_id'            => $field['css_id'],
        'css_class'         => $field['css_class'],
        'position'          => $position,
        'customer_groups'   => isset($field['customer_groups']) ? $field['customer_groups'] : array(),
        'address_blocks'    => isset($field['address_blocks']) ? $field['address_blocks'] : array(),
        'placeholder_text'  => $field['placeholder_text'][$language_code],
        'mask'              => $field['mask']
      );

      if (isset($this->request->post[ $this->replaceValue($field['view'], 2) ])) {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = $this->request->post[$this->replaceValue($field['view'], 2)];
      } elseif ($customer_info && in_array($this->replaceValue($field['view'], 2), $customer_info_data)) {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = $customer_info[$this->replaceValue($field['view'], 2)];
      } elseif (isset($this->session->data['guest'][$this->replaceValue($field['view'], 2)])) {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = $this->session->data['guest'][$this->replaceValue($field['view'], 2)];
      } elseif (isset($this->session->data['payment_address'][$this->replaceValue($field['view'], 2)])) {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = $this->session->data['payment_address'][$this->replaceValue($field['view'], 2)];
      } elseif (isset($this->session->data['shipping_address'][$this->replaceValue($field['view'], 2)])) {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = $this->session->data['shipping_address'][$this->replaceValue($field['view'], 2)];
      } else {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = '';
      }
    }

    // SHIPPING ADDRESS - DEFAULT VALUES:
    // if !logged = firstname, lastname, company, address_1, address_2, city, postcode, country_id, zone_id;
    // if logged = firstname, lastname, company, address_1, address_2, city, postcode, country_id, zone_id;

    foreach ($this->getActiveField($customer_group_id, 'shipping') as $field) {
      switch ($field['position']) {
        case '1': $position = "smopc-col-sm-6 smopc-pull-left"; break;
        case '2': $position = "smopc-col-sm-6 smopc-pull-right"; break;
        case '3': $position = "smopc-col-sm-12"; break;
      }

      $data['shipping_address_fields'][] = array(
        'activate'         => $field['activate'],
        'title'            => $field['title'][$language_code],
        'value'            => $this->replaceValue($field['view'], 1),
        'name'             => $this->replaceValue($field['view'], 2),
        'type'             => $this->replaceValue($field['view'], 1),
        'check'            => $field['check'],
        'error_text'       => $field['error_text'],
        'css_id'           => $field['css_id'],
        'css_class'        => $field['css_class'],
        'position'         => $position,
        'customer_groups'  => isset($field['customer_groups']) ? $field['customer_groups'] : array(),
        'address_blocks'   => isset($field['address_blocks']) ? $field['address_blocks'] : array(),
        'placeholder_text' => $field['placeholder_text'][$language_code],
        'mask'             => $field['mask']
      );

      if (isset($this->request->post[ $this->replaceValue($field['view'], 2) ])) {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = $this->request->post[$this->replaceValue($field['view'], 2)];
      } elseif ($customer_info && in_array($this->replaceValue($field['view'], 2), $customer_info_data)) {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = $customer_info[$this->replaceValue($field['view'], 2)];
      } elseif (isset($this->session->data['guest'][$this->replaceValue($field['view'], 2)])) {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = $this->session->data['guest'][$this->replaceValue($field['view'], 2)];
      } elseif (isset($this->session->data['payment_address'][$this->replaceValue($field['view'], 2)])) {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = $this->session->data['payment_address'][$this->replaceValue($field['view'], 2)];
      } elseif (isset($this->session->data['shipping_address'][$this->replaceValue($field['view'], 2)])) {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = $this->session->data['shipping_address'][$this->replaceValue($field['view'], 2)];
      } else {
        $data['input_value'][$this->replaceValue($field['view'], 2)] = '';
      }
    }

    if ($form_data['allow_custom_fields']) {
      // custom fields
      $this->load->model('account/custom_field');

      $data['custom_fields'] = $this->model_account_custom_field->getCustomFields($customer_group_id);

      if (isset($this->session->data['guest']['custom_field'])) {
        if (isset($this->session->data['guest']['custom_field'])) {
          $guest_custom_field = $this->session->data['guest']['custom_field'];
        } else {
          $guest_custom_field = array();
        }

        if (isset($this->session->data['payment_address']['custom_field'])) {
          $address_custom_field = $this->session->data['payment_address']['custom_field'];
        } else {
          $address_custom_field = array();
        }

        $data['guest_custom_field'] = $guest_custom_field + $address_custom_field;
      } else {
        $data['guest_custom_field'] = array();
      }
    }

    if(isset($this->request->request['customer_group_id'])) {
      $data['customer_group_id'] = $this->request->request['customer_group_id'];
    } elseif (isset($this->session->data['guest']['customer_group_id'])) {
      $data['customer_group_id'] = $this->session->data['guest']['customer_group_id'];
    } else {
      $data['customer_group_id'] = $this->config->get('config_customer_group_id');
    }

    if (isset($this->session->data['payment_address']['address_id'])) {
      $data['address_id'] = $this->session->data['payment_address']['address_id'];
    } else {
      $data['address_id'] = $this->customer->getAddressId();
    }

    $data['addresses'] = $this->model_account_address->getAddresses();

    $countries = (isset($form_data['countries'])) ? $form_data['countries'] : '';

    $data['countries'] = array();

    if ($countries) {
      foreach ($this->model_localisation_country->getCountries() as $country) {
        if (in_array($country['country_id'], $countries)) {
          $data['countries'][] = $this->model_localisation_country->getCountry($country['country_id']);
        }
      }
    }

    if (isset($form_data['require_checkout_terms'])) {
      $information_info = $this->model_catalog_information->getInformation($form_data['require_checkout_terms']);
      if ($information_info) {
        $data['text_agree_checkout'] = sprintf($this->language->get('text_agree_checkout'), $this->url->link('information/information/agree', 'information_id='.$form_data['require_checkout_terms'], 'SSL'), $information_info['title'], $information_info['title']);
      } else {
        $data['text_agree_checkout'] = '';
      }
    } else {
      $data['text_agree_checkout'] = '';
    }

    $data['continue'] = $this->url->link('common/home');
    $data['payment'] = '';

    // add blocks
    $data['column_left'] = $this->load->controller('common/column_left');
    $data['column_right'] = $this->load->controller('common/column_right');
    $data['content_top'] = $this->load->controller('common/content_top');
    $data['content_bottom'] = $this->load->controller('common/content_bottom');
    $data['footer'] = $this->load->controller('common/footer');
    $data['header'] = $this->load->controller('common/header');
    $data['coupon_voucher_reward'] = $this->load->controller('checkout/'.self::$_module_name.'/coupon_voucher_reward');
    $data['login_block'] = $this->load->controller('checkout/'.self::$_module_name.'/login');
    $data['cart_block'] = $this->load->controller('checkout/'.self::$_module_name.'/cart');
    $data['payment_block'] = $this->load->controller('checkout/'.self::$_module_name.'/payment_method');
    $data['shipping_block'] = $this->load->controller('checkout/'.self::$_module_name.'/shipping_method');

    if (!$this->cart->hasProducts()) {
      if (isset($text_data[$language_code])) {
        $data['heading_title'] = $text_data[$language_code]['heading'];
        $data['text_empty'] = $text_data[$language_code]['empty_text'];
      }

      $data['continue'] = $this->url->link('common/home');

      unset($this->session->data['success']);

      if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/empty.tpl')) {
        $this->response->setOutput($this->load->view($this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/empty.tpl', $data));
      } else {
        $this->response->setOutput($this->load->view('default/template/checkout/'.self::$_module_name.'/empty.tpl', $data));
      }
    } else {
      if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/index.tpl')) {
        $this->response->setOutput($this->load->view($this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/index.tpl', $data));
      } else {
        $this->response->setOutput($this->load->view('default/template/checkout/'.self::$_module_name.'/index.tpl', $data));
      }
    }
  }

  public function cart() {
    $data = array();
    $data = array_merge($data, $this->load->language('checkout/'.self::$_module_name), $this->config->get(self::$_module_name.'_form_data'));

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    if (isset($this->request->request['remove'])) {
      $this->cart->remove($this->request->request['remove']);
      unset($this->session->data['vouchers'][$this->request->request['remove']]);
    }

    if (isset($this->request->request['update'])) {
      $this->cart->update($this->request->request['update'], $this->request->request['quantity']);
    }

    if (isset($this->request->request['add'])) {
      $this->cart->add($this->request->request['add'], $this->request->request['quantity']);
    }

    if ($this->validate('cart')) {
      $data['error_warning_cart'] = $this->validate('cart');
    } else {
      unset($this->session->data['error']);
      $data['error_warning_cart'] = '';
    }

    $data['attention_cart'] = ($this->config->get('config_customer_price') && !$this->customer->isLogged()) ? sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register')) : '';

    $data['weight'] = ($form_data['show_weight_cart']) ? $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point')) : '';

    $data['products'] = array();

    $products = $this->cart->getProducts();

    foreach ($products as $product) {

      $image = ($product['image']) ? $this->model_tool_image->resize($product['image'], $form_data['main_image_width'], $form_data['main_image_height']) : $this->model_tool_image->resize("no_image.jpg", $form_data['main_image_width'], $form_data['main_image_height']);

      $option_data = array();

      foreach ($product['option'] as $option) {
        if ($option['type'] != 'file') {
          $value = $option['value'];
        } else {
          $upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

          if ($upload_info) {
            $value = $upload_info['name'];
          } else {
            $value = '';
          }
        }

        $option_data[] = array(
          'name'  => $option['name'],
          'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20).'..' : $value)
        );
      }

      // display prices
      $price = (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) ? $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'))) : false;

      // display total
      $total = (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) ? $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']) : false;

      $recurring = '';

      if ($product['recurring']) {
        $frequencies = array(
          'day'        => $this->language->get('text_day'),
          'week'       => $this->language->get('text_week'),
          'semi_month' => $this->language->get('text_semi_month'),
          'month'      => $this->language->get('text_month'),
          'year'       => $this->language->get('text_year'),
        );

        if ($product['recurring']['trial']) {
          $recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']).' ';
        }

        if ($product['recurring']['duration']) {
          $recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
        } else {
          $recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
        }
      }

      $data['products'][] = array(
        'key'       => (version_compare(VERSION, '2.1.0.1') < 0) ? $product['key'] : $product['cart_id'],
        'product_id'=> $product['product_id'],
        'thumb'     => $image,
        'name'      => $product['name'],
        'model'     => $product['model'],
        'option'    => $option_data,
        'recurring' => $recurring,
        'quantity'  => $product['quantity'],
        'stock'     => $product['stock'] ? true : !(!$form_data['stock_checkout']),
        'reward'    => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
        'price'     => $price,
        'total'     => $total,
        'href'      => $this->url->link('product/product', 'product_id='.$product['product_id'])
      );
    }

    // gift voucher
    $data['vouchers'] = array();

    if (!empty($this->session->data['vouchers'])) {
      foreach ($this->session->data['vouchers'] as $key => $voucher) {
        $data['vouchers'][] = array(
          'key'         => $key,
          'description' => $voucher['description'],
          'amount'      => $this->currency->format($voucher['amount']),
          'remove'      => $this->url->link('checkout/cart', 'remove='.$key)
        );
      }
    }

    // totals data
    $total_data = array();
    $total = 0;
    $taxes = $this->cart->getTaxes();

    $sort_order = array();

    $total_results = $this->model_extension_extension->getExtensions('total');

    foreach ($total_results as $key => $value) {
      $sort_order[$key] = $this->config->get($value['code'].'_sort_order');
    }

    array_multisort($sort_order, SORT_ASC, $total_results);

    foreach ($total_results as $result) {
      if ($this->config->get($result['code'].'_status')) {
        $this->load->model('total/'.$result['code']);
        $this->{'model_total_'.$result['code']}->getTotal($total_data, $total, $taxes);
      }
    }

    $data['totals'] = array();

    foreach ($total_data as $total) {
      $data['totals'][] = array(
        'title' => $total['title'],
        'text'  => $this->currency->format($total['value'])
      );
    }

    if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/cart.tpl')) {
      return $this->load->view($this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/cart.tpl', $data);
    } else {
      return $this->load->view('default/template/checkout/'.self::$_module_name.'/cart.tpl', $data);
    }
  }

  public function status_cart() {
    $json = array();

    $this->load->model('extension/extension');
    $this->load->language('checkout/'.self::$_module_name);

    if (!$this->cart->hasProducts()) {
      $json['redirect'] = $this->url->link('checkout/'.self::$_module_name);
    }

    // totals
    $total_data = array();
    $total = 0;
    $taxes = $this->cart->getTaxes();

    // display prices
    if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
      $sort_order = array();

      $results = $this->model_extension_extension->getExtensions('total');

      foreach ($results as $key => $value) {
        $sort_order[$key] = $this->config->get($value['code'].'_sort_order');
      }

      array_multisort($sort_order, SORT_ASC, $results);

      foreach ($results as $result) {
        if ($this->config->get($result['code'].'_status')) {
          $this->load->model('total/'.$result['code']);
          $this->{'model_total_'.$result['code']}->getTotal($total_data, $total, $taxes);
        }
      }

      $sort_order = array();

      foreach ($total_data as $key => $value) {
        $sort_order[$key] = $value['sort_order'];
      }

      array_multisort($sort_order, SORT_ASC, $total_data);
    }

    $json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function shipping_method() {
    $data = array();
    $data = array_merge($data, $this->load->language('checkout/'.self::$_module_name), $this->config->get(self::$_module_name.'_form_data'));

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    $shipping_method_data = array();

    $shipping_results = $this->model_extension_extension->getExtensions('shipping');

    foreach ($shipping_results as $result) {
      if ($this->config->get($result['code'].'_status')) {
        $this->load->model('shipping/'.$result['code']);

        $quote = $this->{'model_shipping_'.$result['code']}->getQuote($this->session->data['shipping_address']);

        if ($quote && isset($form_data['shipping_code_array']) && in_array($result['code'], $form_data['shipping_code_array'])) {
          $shipping_method_data[$result['code']] = array(
            'title'      => $quote['title'],
            'quote'      => $quote['quote'],
            'sort_order' => $quote['sort_order'],
            'error'      => $quote['error']
          );
        }
      }
    }

    $sort_order = array();

    foreach ($shipping_method_data as $key => $value) {
      $sort_order[$key] = $value['sort_order'];
    }

    array_multisort($sort_order, SORT_ASC, $shipping_method_data);

    $this->session->data['shipping_methods'] = $shipping_method_data;

    $data['error_warning_shipping'] = (empty($this->session->data['shipping_methods']) || !isset($form_data['shipping_code_array'])) ? sprintf($this->language->get('error_no_shipping'), $this->url->link('information/contact')) : '';
    $data['shipping_methods'] = (isset($this->session->data['shipping_methods'])) ? $this->session->data['shipping_methods'] : array();
    $data['code_s'] = (isset($this->session->data['shipping_method']['code'])) ? $this->session->data['shipping_method']['code'] : '';

    if (isset($form_data['require_shipping_terms'])) {
      $information_info = $this->model_catalog_information->getInformation($form_data['require_shipping_terms']);
      if ($information_info) {
        $data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/agree', 'information_id='.$form_data['require_shipping_terms'], 'SSL'), $information_info['title'], $information_info['title']);
      } else {
        $data['text_agree'] = '';
      }
    } else {
      $data['text_agree'] = '';
    }

    $data['shipping_agree'] = (isset($this->session->data['shipping_agree'])) ? $this->session->data['shipping_agree'] : '';

    if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/shipping_method.tpl')) {
      return $this->load->view($this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/shipping_method.tpl', $data);
    } else {
      return $this->load->view('default/template/checkout/'.self::$_module_name.'/shipping_method.tpl', $data);
    }
  }

  public function shipping_save() {
    $json = array();

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    $this->load->language('checkout/'.self::$_module_name);

    if (!isset($this->request->post['shipping_method'])) {
      $json['error']['warning'] = (!isset($form_data['shipping_code_array'])) ? sprintf($this->language->get('error_no_shipping'), $this->url->link('information/contact')) : $this->language->get('error_shipping');
    } else {
      $shipping = explode('.', $this->request->post['shipping_method']);
      if (!isset($shipping[0]) || !isset($shipping[1]) || !isset($this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]])) {
        $json['error']['warning'] = $this->language->get('error_shipping');
      }
    }

    if (!isset($this->request->post['skip_shipping_agree'])) {
      if (isset($form_data['require_shipping_terms'])) {
        $this->load->model('catalog/information');

        $information_info = $this->model_catalog_information->getInformation($form_data['require_shipping_terms']);

        if ($information_info && !isset($this->request->post['shipping_agree'])) {
          $json['error']['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
        }
      }
    }

    if (!$json) {
      $this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];
      $this->session->data['shipping_agree'] = isset($this->request->post['shipping_agree']) ? $this->request->post['shipping_agree'] : '';
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function payment_method() {
    $data = array();
    $data = array_merge($data, $this->load->language('checkout/'.self::$_module_name), $this->config->get(self::$_module_name.'_form_data'));

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');
    $text_data  = (array)$this->config->get(self::$_module_name.'_text_data');

    $language_code = $this->session->data['language'];

    if (isset($text_data[$language_code])) {
      $data['button_cancel'] = $text_data[$language_code]['continue_button'];
    }

    $total_data = array();
    $total = 0;
    $taxes = $this->cart->getTaxes();

    $sort_order = array();

    $results = $this->model_extension_extension->getExtensions('total');

    foreach ($results as $key => $value) {
      $sort_order[$key] = $this->config->get($value['code'].'_sort_order');
    }

    array_multisort($sort_order, SORT_ASC, $results);

    foreach ($results as $result) {
      if ($this->config->get($result['code'].'_status')) {
        $this->load->model('total/'.$result['code']);
        $this->{'model_total_'.$result['code']}->getTotal($total_data, $total, $taxes);
      }
    }

    $payment_method_data = array();

    $payment_results = $this->model_extension_extension->getExtensions('payment');

    $recurring = $this->cart->hasRecurringProducts();

    foreach ($payment_results as $result) {
      if ($this->config->get($result['code'].'_status')) {
        $this->load->model('payment/'.$result['code']);

        $method = $this->{'model_payment_'.$result['code']}->getMethod($this->session->data['payment_address'], $total);

        if ($method && isset($form_data['payment_code_array']) && in_array($result['code'], $form_data['payment_code_array'])) {
          if ($recurring) {
            if (method_exists($this->{'model_payment_'.$result['code']}, 'recurringPayments') && $this->{'model_payment_'.$result['code']}->recurringPayments()) {
              $payment_method_data[$result['code']] = $method;
            }
          } else {
            $payment_method_data[$result['code']] = $method;
          }
        }
      }
    }

    $sort_order = array();

    foreach ($payment_method_data as $key => $value) {
      $sort_order[$key] = $value['sort_order'];
    }

    array_multisort($sort_order, SORT_ASC, $payment_method_data);

    $this->session->data['payment_methods'] = $payment_method_data;

    $data['error_warning_payment'] = (empty($this->session->data['payment_methods'])) ? sprintf($this->language->get('error_no_payment'), $this->url->link('information/contact')) : '';
    $data['payment_methods'] = (isset($this->session->data['payment_methods'])) ? $this->session->data['payment_methods'] : array();
    $data['code_p'] = (isset($this->session->data['payment_method']['code'])) ? $this->session->data['payment_method']['code'] : '';

    if (isset($form_data['require_payment_terms'])) {
      $information_info = $this->model_catalog_information->getInformation($form_data['require_payment_terms']);
      if ($information_info) {
        $data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/agree', 'information_id='.$form_data['require_payment_terms'], 'SSL'), $information_info['title'], $information_info['title']);
      } else {
        $data['text_agree'] = '';
      }
    } else {
      $data['text_agree'] = '';
    }

    $data['payment_agree'] = (isset($this->session->data['payment_agree'])) ? $this->session->data['payment_agree'] : '';
    $data['continue'] = $this->url->link('common/home');

    if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/payment_method.tpl')) {
      return $this->load->view($this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/payment_method.tpl', $data);
    } else {
      return $this->load->view('default/template/checkout/'.self::$_module_name.'/payment_method.tpl', $data);
    }
  }

  public function payment_save() {
    $json = array();

    $this->load->language('checkout/'.self::$_module_name);

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    if (!isset($this->request->post['payment_method'])) {
      $json['error']['warning'] = (!isset($form_data['payment_code_array'])) ? sprintf($this->language->get('error_no_payment'), $this->url->link('information/contact')) : $this->language->get('error_payment');
    } elseif (!isset($this->session->data['payment_methods'][$this->request->post['payment_method']])) {
      $json['error']['warning'] = (!isset($form_data['payment_code_array'])) ? sprintf($this->language->get('error_no_payment'), $this->url->link('information/contact')) : $this->language->get('error_payment');
    }

    if (!isset($this->request->post['skip_payment_agree'])) {
      if (isset($form_data['require_payment_terms'])) {
        $this->load->model('catalog/information');

        $information_info = $this->model_catalog_information->getInformation($form_data['require_payment_terms']);

        if ($information_info && !isset($this->request->post['payment_agree'])) {
          $json['error']['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
        }
      }
    }

    if ($this->validate('cart')) {
      $json['error']['validate'] = $this->validate('cart');
    }

    if (!$json) {
      $this->session->data['payment_method'] = $this->session->data['payment_methods'][$this->request->post['payment_method']];
      $this->session->data['payment_agree'] = isset($this->request->post['payment_agree']) ? $this->request->post['payment_agree'] : '';
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function register_save() {
    $json = array();

    // connect models array
    $models = array('localisation/country', 'localisation/zone', 'catalog/information', 'account/customer', 'account/customer_group', 'account/address', 'account/activity');
    foreach ($models as $model) {
      $this->load->model($model);
    }

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    $this->language->load('checkout/'.self::$_module_name);

    $language_code = $this->session->data['language'];

    // customer group
    if (isset($this->request->request['customer_group_id'])) {
      $customer_group_id = $this->request->request['customer_group_id'];
    } else {
      $customer_group_id = ($this->customer->isLogged()) ? (int)$this->customer->getGroupId() : (int)$this->config->get('config_customer_group_id');
    }

    // validate fields
    foreach ($this->getActiveField($customer_group_id, 'payment') as $field) {
      if (empty($this->request->request[$field['view']]) && $field['check'] == 1) {
        $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
      } elseif(!empty($field['check_rule']) && !preg_match($field['check_rule'], $this->request->request[$field['view']]) && $field['check'] == 2) {
        $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
      } elseif(utf8_strlen(str_replace(array('_','-','(',')','+'), "", $this->request->request[$field['view']])) < $field['check_min'] || utf8_strlen(str_replace(array('_','-','(',')','+'), "", $this->request->request[$field['view']])) > $field['check_max'] && $field['check'] == 3) {
        $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
      } else {
        unset($json['error']['field'][$field['view']]);
      }
    }

    if (!isset($this->request->post['email'])) {
      $json['error']['warning'] = $this->language->get('error_email_not_isset');
    }

    // special @postcode validation
    if (isset($this->request->post['postcode']) && isset($this->request->post['country_id'])) {
      $country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);
      if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
        $json['error']['warning'] = $this->language->get('error_postcode');
      }
    }

    if (!$this->customer->isLogged() && isset($form_data['require_checkout_terms'])) {
      $information_info = $this->model_catalog_information->getInformation($form_data['require_checkout_terms']);
      if ($information_info && !isset($this->request->post['agree'])) {
        $json['error']['warning'] = sprintf($this->language->get('error_agree_checkout'), $information_info['title']);
      }
    }

    if (isset($this->request->post['password'])) {
      if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
        $json['error']['field']['password'] = $this->language->get('error_password');
      } 
    }

    if (isset($this->request->post['confirm']) && isset($this->request->post['password'])) {
      if ($this->request->post['confirm'] != $this->request->post['password']) {
        $json['error']['field']['confirm'] = $this->language->get('error_confirm');
      } 
    }

    if ($form_data['allow_newsletter_subscribe'] == 2) {
      if (!isset($this->request->post['newsletter']) || empty($this->request->post['newsletter'])) {
        $json['error']['newsletter'] = $this->language->get('error_newsletter');
      }
    }

    if ($form_data['allow_custom_fields']) {
      // custom field validation
      $this->load->model('account/custom_field');

      $custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);

      foreach ($custom_fields as $custom_field) {
        if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {
          if ($custom_field['location'] == 'account') {
            $json['error']['custom_fields'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
          }
        }
      }
    }

    if (!$json) {
      foreach (array('firstname', 'lastname', 'email', 'telephone', 'fax', 'company', 'address_1', 'address_2', 'city', 'postcode', 'country_id', 'zone_id') as $post_field) {
        if (!isset($this->request->post[$post_field])) {
          $this->request->post[$post_field] = '';
        }
      }

      $customer_id = $this->model_account_customer->addCustomer($this->request->post);

      // clear any previous login attempts for unregistered accounts.
      $this->model_account_customer->deleteLoginAttempts($this->request->post['email']);

      $this->session->data['account'] = 'register';

      $customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);

      if ($customer_group_info && !$customer_group_info['approval']) {
        $this->customer->login($this->request->post['email'], $this->request->post['password']);

        // default payment address
        $this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());

        if (!empty($this->request->post['shipping_address'])) {
          $this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
        }
      } else {
        $json['redirect'] = $this->url->link('account/success');
      }

      unset($this->session->data['guest']);

      // add to activity log
      $activity_data = array(
        'customer_id' => $customer_id,
        'name'        => $this->request->post['firstname'].' '.$this->request->post['lastname']
      );

      $this->model_account_activity->addActivity('register', $activity_data);
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function payment_address_save() {
    $json = array();

    // connect models array
    $models = array('account/address', 'localisation/country', 'account/activity');
    foreach ($models as $model) {
      $this->load->model($model);
    }

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    $this->language->load('checkout/'.self::$_module_name);

    $language_code = $this->session->data['language'];

    // customer group
    if (isset($this->request->request['customer_group_id'])) {
      $customer_group_id = $this->request->request['customer_group_id'];
    } else {
      $customer_group_id = ($this->customer->isLogged()) ? (int)$this->customer->getGroupId() : (int)$this->config->get('config_customer_group_id');
    }

    if (isset($this->request->post['payment_address']) && $this->request->post['payment_address'] == 'existing') {

      if (empty($this->request->post['address_id'])) {
        $json['error']['warning'] = $this->language->get('error_address');
      } elseif (!in_array($this->request->post['address_id'], array_keys($this->model_account_address->getAddresses()))) {
        $json['error']['warning'] = $this->language->get('error_address');
      }

      if (!$json) {
        // default payment address
        $this->session->data['payment_address'] = $this->model_account_address->getAddress($this->request->post['address_id']);
      }

    } else {

      // validate fields
      foreach ($this->getActiveField($customer_group_id, 'payment') as $field) {
        if (empty($this->request->request[$field['view']]) && $field['check'] == 1) {
          $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
        } elseif(!empty($field['check_rule']) && !preg_match($field['check_rule'], $this->request->request[$field['view']]) && $field['check'] == 2) {
          $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
        } elseif(utf8_strlen(str_replace(array('_','-','(',')','+'), "", $this->request->request[$field['view']])) < $field['check_min'] || utf8_strlen(str_replace(array('_','-','(',')','+'), "", $this->request->request[$field['view']])) > $field['check_max'] && $field['check'] == 3) {
          $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
        } else {
          unset($json['error']['field'][$field['view']]);
        }
      }

      // special @postcode validation
      if (isset($this->request->post['postcode']) && isset($this->request->post['country_id'])) {
        $country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);
        if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
          $json['error']['warning'] = $this->language->get('error_postcode');
        }
      }

      if ($form_data['allow_custom_fields']) {
        // custom field validation
        $this->load->model('account/custom_field');

        $custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);

        foreach ($custom_fields as $custom_field) {
          if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {
            if ($custom_field['location'] == 'account') {
              $json['error']['custom_fields'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
            }
          }
        }
      }

      if (isset($form_data['checkout_blocks']) && in_array('shipping', $form_data['checkout_blocks'])) {
        if (!isset($this->request->post['shipping_method'])) {
          $json['error']['select_shipping_method'] = $this->language->get('error_shipping');
        }

        if (!isset($this->request->post['skip_shipping_agree'])) {
          if (isset($form_data['require_shipping_terms'])) {
            $this->load->model('catalog/information');

            $information_info = $this->model_catalog_information->getInformation($form_data['require_shipping_terms']);

            if ($information_info && !isset($this->request->post['shipping_agree'])) {
              $json['error']['shipping_agree'] = sprintf($this->language->get('error_agree'), $information_info['title']);
            }
          }
        }
      }

      if (!$json) {
        foreach (array('firstname', 'lastname', 'company', 'address_1', 'address_2', 'postcode', 'city', 'zone_id', 'country_id') as $post_field) {
          if (!isset($this->request->post[$post_field])) {
            $this->request->post[$post_field] = '';
          }
        }

        // default payment address
        $address_id = $this->model_account_address->addAddress($this->request->post);
        $this->session->data['payment_address'] = $this->model_account_address->getAddress($address_id);
        $this->session->data['comment'] = (isset($this->request->request['comment'])) ? $this->request->request['comment'] : '';
        
        $activity_data = array(
          'customer_id' => $this->customer->getId(),
          'name'        => $this->customer->getFirstName().' '.$this->customer->getLastName()
        );

        $this->model_account_activity->addActivity('address_add', $activity_data);
      }
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function shipping_address_save() {
    $json = array();

    // connect models array
    $models = array('account/address', 'localisation/country', 'account/activity');
    foreach ($models as $model) {
      $this->load->model($model);
    }

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    $this->language->load('checkout/'.self::$_module_name);

    $language_code = $this->session->data['language'];

    // customer group
    if (isset($this->request->request['customer_group_id'])) {
      $customer_group_id = $this->request->request['customer_group_id'];
    } else {
      $customer_group_id = ($this->customer->isLogged()) ? (int)$this->customer->getGroupId() : (int)$this->config->get('config_customer_group_id');
    }

    if (isset($this->request->post['shipping_address']) && $this->request->post['shipping_address'] == 'existing') {

      if (empty($this->request->post['address_id'])) {
        $json['error']['warning'] = $this->language->get('error_address');
      } elseif (!in_array($this->request->post['address_id'], array_keys($this->model_account_address->getAddresses()))) {
        $json['error']['warning'] = $this->language->get('error_address');
      }

      if (!$json) {
        // default shipping address
        $this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->request->post['address_id']);
      }
    } else {
      // validate fields
      foreach ($this->getActiveField($customer_group_id, 'shipping') as $field) {
        if (empty($this->request->request[$field['view']]) && $field['check'] == 1) {
          $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
        } elseif(!empty($field['check_rule']) && !preg_match($field['check_rule'], $this->request->request[$field['view']]) && $field['check'] == 2) {
          $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
        } elseif(utf8_strlen(str_replace(array('_','-','(',')','+'), "", $this->request->request[$field['view']])) < $field['check_min'] || utf8_strlen(str_replace(array('_','-','(',')','+'), "", $this->request->request[$field['view']])) > $field['check_max'] && $field['check'] == 3) {
          $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
        } else {
          unset($json['error']['field'][$field['view']]);
        }
      }

      // special @postcode validation
      if (isset($this->request->post['postcode']) && isset($this->request->post['country_id'])) {
        $country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);
        if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
          $json['error']['warning'] = $this->language->get('error_postcode');
        }
      }

      if ($form_data['allow_custom_fields']) {
        // custom field validation
        $this->load->model('account/custom_field');

        $custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);

        foreach ($custom_fields as $custom_field) {
          if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {
            if ($custom_field['location'] == 'address') {
              $json['error']['custom_fields'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
            }
          }
        }
      }

      if (isset($form_data['checkout_blocks']) && in_array('shipping', $form_data['checkout_blocks'])) {
        if (!isset($this->request->post['shipping_method'])) {
          $json['error']['select_shipping_method'] = $this->language->get('error_shipping');
        }

        if (!isset($this->request->post['skip_shipping_agree'])) {
          if (isset($form_data['require_shipping_terms'])) {
            $this->load->model('catalog/information');

            $information_info = $this->model_catalog_information->getInformation($form_data['require_shipping_terms']);

            if ($information_info && !isset($this->request->post['shipping_agree'])) {
              $json['error']['shipping_agree'] = sprintf($this->language->get('error_agree'), $information_info['title']);
            }
          }
        }
      }

      if (!$json) {
        foreach (array('firstname', 'lastname', 'company', 'address_1', 'address_2', 'postcode', 'city', 'zone_id', 'country_id') as $post_field) {
          if (!isset($this->request->post[$post_field])) {
            $this->request->post[$post_field] = '';
          }
        }

        // default shipping address
        $address_id = $this->model_account_address->addAddress($this->request->post);
        $this->session->data['shipping_address'] = $this->model_account_address->getAddress($address_id);

        $activity_data = array(
          'customer_id' => $this->customer->getId(),
          'name'        => $this->customer->getFirstName().' '.$this->customer->getLastName()
        );

        $this->model_account_activity->addActivity('address_add', $activity_data);
      }
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function guest_save() {
    $json = array();

    // connect models array
    $models = array('localisation/country', 'localisation/zone', 'catalog/information');
    foreach ($models as $model) {
      $this->load->model($model);
    }

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    $this->language->load('checkout/'.self::$_module_name);

    $language_code = $this->session->data['language'];

    if (!isset($this->request->post['payment_address']) || $this->request->post['payment_address'] != "existing") {

      // customer group
      if (isset($this->request->request['customer_group_id'])) {
        $customer_group_id = $this->request->request['customer_group_id'];
      } else {
        $customer_group_id = ($this->customer->isLogged()) ? (int)$this->customer->getGroupId() : (int)$this->config->get('config_customer_group_id');
      }

      // validate fields
      foreach ($this->getActiveField($customer_group_id, 'payment') as $field) {
        if (empty($this->request->request[$field['view']]) && $field['check'] == 1) {
          $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
        } elseif(!empty($field['check_rule']) && !preg_match($field['check_rule'], $this->request->request[$field['view']]) && $field['check'] == 2) {
          $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
        } elseif(utf8_strlen(str_replace(array('_','-','(',')','+'), "", $this->request->request[$field['view']])) < $field['check_min'] || utf8_strlen(str_replace(array('_','-','(',')','+'), "", $this->request->request[$field['view']])) > $field['check_max'] && $field['check'] == 3) {
          $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
        } else {
          unset($json['error']['field'][$field['view']]);
        }
      }

      // special @postcode validation
      if (isset($this->request->post['postcode']) && isset($this->request->post['country_id'])) {
        $country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);
        if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
          $json['error']['warning'] = $this->language->get('error_postcode');
        }
      }

      if (isset($form_data['require_checkout_terms'])) {
        $information_info = $this->model_catalog_information->getInformation($form_data['require_checkout_terms']);
        if ($information_info && !isset($this->request->post['agree'])) {
          $json['error']['warning'] = sprintf($this->language->get('error_agree_checkout'), $information_info['title']);
        }
      }

      if ($form_data['allow_custom_fields']) {
        // custom field validation
        $this->load->model('account/custom_field');

        $custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);

        foreach ($custom_fields as $custom_field) {
          if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {
            if ($custom_field['location'] == 'account') {
              $json['error']['custom_fields'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
            }
          }
        }
      }

      if (isset($form_data['checkout_blocks']) && in_array('shipping', $form_data['checkout_blocks'])) {
        if (!isset($this->request->post['shipping_method'])) {
          $json['error']['select_shipping_method'] = $this->language->get('error_shipping');
        }

        if (!isset($this->request->post['skip_shipping_agree'])) {
          if (isset($form_data['require_shipping_terms'])) {
            $this->load->model('catalog/information');

            $information_info = $this->model_catalog_information->getInformation($form_data['require_shipping_terms']);

            if ($information_info && !isset($this->request->post['shipping_agree'])) {
              $json['error']['shipping_agree'] = sprintf($this->language->get('error_agree'), $information_info['title']);
            }
          }
        }
      }

      if (!$json) {
        $this->session->data['account'] = 'guest';

        $this->session->data['guest']['customer_group_id'] = $customer_group_id;
        $this->session->data['guest']['firstname'] = (isset($this->request->post['firstname'])) ? $this->request->post['firstname'] : '';
        $this->session->data['guest']['lastname'] = (isset($this->request->post['lastname'])) ? $this->request->post['lastname'] : '';
        $this->session->data['guest']['email'] = (isset($this->request->post['email'])) ? $this->request->post['email'] : '';
        $this->session->data['guest']['telephone'] = (isset($this->request->post['telephone'])) ? $this->request->post['telephone'] : '';
        $this->session->data['guest']['fax'] = (isset($this->request->post['fax'])) ? $this->request->post['fax'] : '';

        if (isset($this->request->post['custom_field']['account'])) {
          $this->session->data['guest']['custom_field'] = $this->request->post['custom_field']['account'];
        } else {
          $this->session->data['guest']['custom_field'] = array();
        }

        $this->session->data['payment_address']['firstname'] = (isset($this->request->post['firstname'])) ? $this->request->post['firstname'] : '';
        $this->session->data['payment_address']['lastname'] = (isset($this->request->post['lastname'])) ? $this->request->post['lastname'] : '';
        $this->session->data['payment_address']['company'] = (isset($this->request->post['company'])) ? $this->request->post['company'] : '';
        $this->session->data['payment_address']['address_1'] = (isset($this->request->post['address_1'])) ? $this->request->post['address_1'] : '';
        $this->session->data['payment_address']['address_2'] = (isset($this->request->post['address_2'])) ? $this->request->post['address_2'] : '';
        $this->session->data['payment_address']['postcode'] = (isset($this->request->post['postcode'])) ? $this->request->post['postcode'] : '';
        $this->session->data['payment_address']['city'] = (isset($this->request->post['city'])) ? $this->request->post['city'] : '';
        $this->session->data['payment_address']['country_id'] = (isset($this->request->post['country_id'])) ? $this->request->post['country_id'] : '';
        $this->session->data['payment_address']['zone_id'] = (isset($this->request->post['zone_id'])) ? $this->request->post['zone_id'] : '';

        $country_info = $this->model_localisation_country->getCountry((isset($this->request->post['country_id'])) ? $this->request->post['country_id'] : '');

        $this->session->data['payment_address']['country'] = ($country_info) ? $country_info['name'] : '';
        $this->session->data['payment_address']['iso_code_2'] = ($country_info) ? $country_info['iso_code_2'] : '';
        $this->session->data['payment_address']['iso_code_3'] = ($country_info) ? $country_info['iso_code_3'] : '';
        $this->session->data['payment_address']['address_format'] = ($country_info) ? $country_info['address_format'] : '';

        if (isset($this->request->post['custom_field']['address'])) {
          $this->session->data['payment_address']['custom_field'] = $this->request->post['custom_field']['address'];
        } else {
          $this->session->data['payment_address']['custom_field'] = array();
        }

        $zone_info = $this->model_localisation_zone->getZone((isset($this->request->post['zone_id'])) ? $this->request->post['zone_id'] : '');

        $this->session->data['payment_address']['zone'] = ($zone_info) ? $zone_info['name'] : '';
        $this->session->data['payment_address']['zone_code'] = ($zone_info) ? $zone_info['code'] : '';

        $this->session->data['guest']['shipping_address'] = (!empty($this->request->post['shipping_address'])) ? $this->request->post['shipping_address'] : false;

        // default payment address
        if ($this->session->data['guest']['shipping_address']) {
          $this->session->data['shipping_address']['firstname'] = (isset($this->request->post['firstname'])) ? $this->request->post['firstname'] : '';
          $this->session->data['shipping_address']['lastname'] = (isset($this->request->post['lastname'])) ? $this->request->post['lastname'] : '';
          $this->session->data['shipping_address']['company'] = (isset($this->request->post['company'])) ? $this->request->post['company'] : '';
          $this->session->data['shipping_address']['address_1'] = (isset($this->request->post['address_1'])) ? $this->request->post['address_1'] : '';
          $this->session->data['shipping_address']['address_2'] = (isset($this->request->post['address_2'])) ? $this->request->post['address_2'] : '';
          $this->session->data['shipping_address']['postcode'] = (isset($this->request->post['postcode'])) ? $this->request->post['postcode'] : '';
          $this->session->data['shipping_address']['city'] = (isset($this->request->post['city'])) ? $this->request->post['city'] : '';
          $this->session->data['shipping_address']['country_id'] = (isset($this->request->post['country_id'])) ? $this->request->post['country_id'] : '';
          $this->session->data['shipping_address']['zone_id'] = (isset($this->request->post['zone_id'])) ? $this->request->post['zone_id'] : '';
          $this->session->data['shipping_address']['country'] = ($country_info) ? $country_info['name'] : '';
          $this->session->data['shipping_address']['iso_code_2'] = ($country_info) ? $country_info['iso_code_2'] : '';
          $this->session->data['shipping_address']['iso_code_3'] = ($country_info) ? $country_info['iso_code_3'] : '';
          $this->session->data['shipping_address']['address_format'] = ($country_info) ? $country_info['address_format'] : '';
          $this->session->data['shipping_address']['zone'] = ($zone_info) ? $zone_info['name'] : '';
          $this->session->data['shipping_address']['zone_code'] = ($zone_info) ? $zone_info['code'] : '';

          if (isset($this->request->post['custom_field']['address'])) {
            $this->session->data['shipping_address']['custom_field'] = $this->request->post['custom_field']['address'];
          } else {
            $this->session->data['shipping_address']['custom_field'] = array();
          }
        }

        $this->session->data['comment'] = (isset($this->request->post['comment'])) ? $this->request->post['comment'] : "";
      }
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function guest_shipping_save() {
    $json = array();

    // connect models array
    $models = array('localisation/country', 'localisation/zone');
    foreach ($models as $model) {
      $this->load->model($model);
    }

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    $this->language->load('checkout/'.self::$_module_name);

    $language_code = $this->session->data['language'];

    // customer group
    if (isset($this->request->request['customer_group_id'])) {
      $customer_group_id = $this->request->request['customer_group_id'];
    } else {
      $customer_group_id = ($this->customer->isLogged()) ? (int)$this->customer->getGroupId() : (int)$this->config->get('config_customer_group_id');
    }

    // validate fields
    foreach ($this->getActiveField($customer_group_id, 'shipping') as $field) {
      if (empty($this->request->request[$field['view']]) && $field['check'] == 1) {
        $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
      } elseif(!empty($field['check_rule']) && !preg_match($field['check_rule'], $this->request->request[$field['view']]) && $field['check'] == 2) {
        $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
      } elseif(utf8_strlen(str_replace(array('_','-','(',')','+'), "", $this->request->request[$field['view']])) < $field['check_min'] || utf8_strlen(str_replace(array('_','-','(',')','+'), "", $this->request->request[$field['view']])) > $field['check_max'] && $field['check'] == 3) {
        $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
      } else {
        unset($json['error']['field'][$field['view']]);
      }
    }

    // special @postcode validation
    if (isset($this->request->post['postcode']) && isset($this->request->post['country_id'])) {
      $country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);
      if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
        $json['error']['warning'] = $this->language->get('error_postcode');
      }
    }

    if ($form_data['allow_custom_fields']) {
      // custom field validation
      $this->load->model('account/custom_field');

      $custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);

      foreach ($custom_fields as $custom_field) {
        if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {
          if ($custom_field['location'] == 'address') {
            $json['error']['custom_fields'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
          }
        }
      }
    }

    if (isset($form_data['checkout_blocks']) && in_array('shipping', $form_data['checkout_blocks'])) {
      if (!isset($this->request->post['shipping_method'])) {
        $json['error']['select_shipping_method'] = $this->language->get('error_shipping');
      }

      if (!isset($this->request->post['skip_shipping_agree'])) {
        if (isset($form_data['require_shipping_terms'])) {
          $this->load->model('catalog/information');

          $information_info = $this->model_catalog_information->getInformation($form_data['require_shipping_terms']);

          if ($information_info && !isset($this->request->post['shipping_agree'])) {
            $json['error']['shipping_agree'] = sprintf($this->language->get('error_agree'), $information_info['title']);
          }
        }
      }
    }

    if (!$json) {
      $this->session->data['shipping_address']['firstname'] = (isset($this->request->post['firstname'])) ? $this->request->post['firstname'] : '';
      $this->session->data['shipping_address']['lastname'] = (isset($this->request->post['lastname'])) ? $this->request->post['lastname'] : '';
      $this->session->data['shipping_address']['company'] = (isset($this->request->post['company'])) ? $this->request->post['company'] : '';
      $this->session->data['shipping_address']['address_1'] = (isset($this->request->post['address_1'])) ? $this->request->post['address_1'] : '';
      $this->session->data['shipping_address']['address_2'] = (isset($this->request->post['address_2'])) ? $this->request->post['address_2'] : '';
      $this->session->data['shipping_address']['postcode'] = (isset($this->request->post['postcode'])) ? $this->request->post['postcode'] : '';
      $this->session->data['shipping_address']['city'] = (isset($this->request->post['city'])) ? $this->request->post['city'] : '';
      $this->session->data['shipping_address']['country_id'] = (isset($this->request->post['country_id'])) ? $this->request->post['country_id'] : '';
      $this->session->data['shipping_address']['zone_id'] = (isset($this->request->post['zone_id'])) ? $this->request->post['zone_id'] : '';

      $country_info = $this->model_localisation_country->getCountry((isset($this->request->post['country_id'])) ? $this->request->post['country_id'] : '');

      $this->session->data['shipping_address']['country'] = ($country_info) ? $country_info['name'] : '';
      $this->session->data['shipping_address']['iso_code_2'] = ($country_info) ? $country_info['iso_code_2'] : '';
      $this->session->data['shipping_address']['iso_code_3'] = ($country_info) ? $country_info['iso_code_3'] : '';
      $this->session->data['shipping_address']['address_format'] = ($country_info) ? $country_info['address_format'] : '';

      $zone_info = $this->model_localisation_zone->getZone((isset($this->request->post['zone_id'])) ? $this->request->post['zone_id'] : '');

      $this->session->data['shipping_address']['zone'] = ($zone_info) ? $zone_info['name'] : '';
      $this->session->data['shipping_address']['zone_code'] = ($zone_info) ? $zone_info['code'] : '';
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function confirm() {

    // connect models array
    $models = array('extension/extension', 'account/customer', 'affiliate/affiliate', 'checkout/marketing', 'checkout/order');
    foreach ($models as $model) {
      $this->load->model($model);
    }

    $this->load->language('checkout/checkout');

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    $order_data = array();

    $order_data['totals'] = array();
    $total = 0;
    $taxes = $this->cart->getTaxes();

    $sort_order = array();

    $results = $this->model_extension_extension->getExtensions('total');

    foreach ($results as $key => $value) {
      $sort_order[$key] = $this->config->get($value['code'].'_sort_order');
    }

    array_multisort($sort_order, SORT_ASC, $results);

    foreach ($results as $result) {
      if ($this->config->get($result['code'].'_status')) {
        $this->load->model('total/'.$result['code']);

        $this->{'model_total_'.$result['code']}->getTotal($order_data['totals'], $total, $taxes);
      }
    }

    $sort_order = array();

    foreach ($order_data['totals'] as $key => $value) {
      $sort_order[$key] = $value['sort_order'];
    }

    array_multisort($sort_order, SORT_ASC, $order_data['totals']);

    $order_data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
    $order_data['store_id'] = $this->config->get('config_store_id');
    $order_data['store_name'] = $this->config->get('config_name');
    $order_data['store_url'] = ($order_data['store_id']) ? $this->config->get('config_url') : HTTP_SERVER;

    if ($this->customer->isLogged()) {
      $customer_info = $this->model_account_customer->getCustomer($this->customer->getId());

      $order_data['customer_id'] = $this->customer->getId();
      $order_data['customer_group_id'] = $customer_info['customer_group_id'];
      $order_data['firstname'] = $customer_info['firstname'];
      $order_data['lastname'] = $customer_info['lastname'];
      $order_data['email'] = $customer_info['email'];
      $order_data['telephone'] = $customer_info['telephone'];
      $order_data['fax'] = $customer_info['fax'];
      $order_data['custom_field'] = unserialize($customer_info['custom_field']);
    } elseif (isset($this->session->data['guest'])) {
      $order_data['customer_id'] = 0;
      $order_data['customer_group_id'] = $this->session->data['guest']['customer_group_id'];
      $order_data['firstname'] = $this->session->data['guest']['firstname'];
      $order_data['lastname'] = $this->session->data['guest']['lastname'];
      $order_data['email'] = $this->session->data['guest']['email'];
      $order_data['telephone'] = $this->session->data['guest']['telephone'];
      $order_data['fax'] = $this->session->data['guest']['fax'];
      $order_data['custom_field'] = $this->session->data['guest']['custom_field'];
    }

    $order_data['payment_firstname'] = $this->session->data['payment_address']['firstname'];
    $order_data['payment_lastname'] = $this->session->data['payment_address']['lastname'];
    $order_data['payment_company'] = $this->session->data['payment_address']['company'];
    $order_data['payment_address_1'] = $this->session->data['payment_address']['address_1'];
    $order_data['payment_address_2'] = $this->session->data['payment_address']['address_2'];
    $order_data['payment_city'] = $this->session->data['payment_address']['city'];
    $order_data['payment_postcode'] = $this->session->data['payment_address']['postcode'];
    $order_data['payment_zone'] = $this->session->data['payment_address']['zone'];
    $order_data['payment_zone_id'] = $this->session->data['payment_address']['zone_id'];
    $order_data['payment_country'] = $this->session->data['payment_address']['country'];
    $order_data['payment_country_id'] = $this->session->data['payment_address']['country_id'];
    $order_data['payment_address_format'] = $this->session->data['payment_address']['address_format'];
    $order_data['payment_custom_field'] = (isset($this->session->data['payment_address']['custom_field']) ? $this->session->data['payment_address']['custom_field'] : array());
    $order_data['payment_method'] = (isset($this->session->data['payment_method']['title'])) ? $this->session->data['payment_method']['title'] : '';
    $order_data['payment_code'] = (isset($this->session->data['payment_method']['code'])) ? $this->session->data['payment_method']['code'] : '';

    if ($this->cart->hasShipping()) {
      $order_data['shipping_firstname'] = $this->session->data['shipping_address']['firstname'];
      $order_data['shipping_lastname'] = $this->session->data['shipping_address']['lastname'];
      $order_data['shipping_company'] = $this->session->data['shipping_address']['company'];
      $order_data['shipping_address_1'] = $this->session->data['shipping_address']['address_1'];
      $order_data['shipping_address_2'] = $this->session->data['shipping_address']['address_2'];
      $order_data['shipping_city'] = $this->session->data['shipping_address']['city'];
      $order_data['shipping_postcode'] = $this->session->data['shipping_address']['postcode'];
      $order_data['shipping_zone'] = $this->session->data['shipping_address']['zone'];
      $order_data['shipping_zone_id'] = $this->session->data['shipping_address']['zone_id'];
      $order_data['shipping_country'] = $this->session->data['shipping_address']['country'];
      $order_data['shipping_country_id'] = $this->session->data['shipping_address']['country_id'];
      $order_data['shipping_address_format'] = $this->session->data['shipping_address']['address_format'];
      $order_data['shipping_custom_field'] = (isset($this->session->data['shipping_address']['custom_field']) ? $this->session->data['shipping_address']['custom_field'] : array());
      $order_data['shipping_method'] = (isset($this->session->data['shipping_method']['title'])) ? $this->session->data['shipping_method']['title'] : '';
      $order_data['shipping_code'] = (isset($this->session->data['shipping_method']['code'])) ? $this->session->data['shipping_method']['code'] : '';
    } else {
      $order_data['shipping_firstname'] = '';
      $order_data['shipping_lastname'] = '';
      $order_data['shipping_company'] = '';
      $order_data['shipping_address_1'] = '';
      $order_data['shipping_address_2'] = '';
      $order_data['shipping_city'] = '';
      $order_data['shipping_postcode'] = '';
      $order_data['shipping_zone'] = '';
      $order_data['shipping_zone_id'] = '';
      $order_data['shipping_country'] = '';
      $order_data['shipping_country_id'] = '';
      $order_data['shipping_address_format'] = '';
      $order_data['shipping_custom_field'] = array();
      $order_data['shipping_method'] = '';
      $order_data['shipping_code'] = '';
    }

    $order_data['products'] = array();

    foreach ($this->cart->getProducts() as $product) {
      $option_data = array();

      foreach ($product['option'] as $option) {
        $option_data[] = array(
          'product_option_id'       => $option['product_option_id'],
          'product_option_value_id' => $option['product_option_value_id'],
          'option_id'               => $option['option_id'],
          'option_value_id'         => $option['option_value_id'],
          'name'                    => $option['name'],
          'value'                   => $option['value'],
          'type'                    => $option['type']
        );
      }

      $order_data['products'][] = array(
        'product_id' => $product['product_id'],
        'name'       => $product['name'],
        'model'      => $product['model'],
        'option'     => $option_data,
        'download'   => $product['download'],
        'quantity'   => $product['quantity'],
        'subtract'   => $product['subtract'],
        'price'      => $product['price'],
        'total'      => $product['total'],
        'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
        'reward'     => $product['reward'],
        'child'     => !empty($product['child']) ? $product['child'] : '',
        'parent_id'     => !empty($product['parent_id']) ? $product['parent_id'] : '',
      );
    }

    // Gift Voucher
    $order_data['vouchers'] = array();

    if (!empty($this->session->data['vouchers'])) {
      foreach ($this->session->data['vouchers'] as $voucher) {
        $order_data['vouchers'][] = array(
          'description'      => $voucher['description'],
          'code'             => substr(md5(mt_rand()), 0, 10),
          'to_name'          => $voucher['to_name'],
          'to_email'         => $voucher['to_email'],
          'from_name'        => $voucher['from_name'],
          'from_email'       => $voucher['from_email'],
          'voucher_theme_id' => $voucher['voucher_theme_id'],
          'message'          => $voucher['message'],
          'amount'           => $voucher['amount']
        );
      }
    }

    $order_data['comment'] = isset($this->session->data['comment']) ? $this->session->data['comment'] : '' ;
    $order_data['total'] = $total;

    if (isset($this->request->cookie['tracking'])) {
      $order_data['tracking'] = $this->request->cookie['tracking'];

      $subtotal = $this->cart->getSubTotal();

      // affiliate
      $affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);

      if ($affiliate_info) {
        $order_data['affiliate_id'] = $affiliate_info['affiliate_id'];
        $order_data['commission'] = ($subtotal / 100) * $affiliate_info['commission'];
      } else {
        $order_data['affiliate_id'] = 0;
        $order_data['commission'] = 0;
      }

      // marketing
      $marketing_info = $this->model_checkout_marketing->getMarketingByCode($this->request->cookie['tracking']);
      $order_data['marketing_id'] = ($marketing_info) ? $marketing_info['marketing_id'] : 0;
    } else {
      $order_data['affiliate_id'] = 0;
      $order_data['commission'] = 0;
      $order_data['marketing_id'] = 0;
      $order_data['tracking'] = '';
    }

    $order_data['language_id'] = $this->config->get('config_language_id');
    $order_data['currency_id'] = $this->currency->getId();
    $order_data['currency_code'] = $this->currency->getCode();
    $order_data['currency_value'] = $this->currency->getValue($this->currency->getCode());
    $order_data['ip'] = $this->request->server['REMOTE_ADDR'];

    if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
      $order_data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
    } elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
      $order_data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
    } else {
      $order_data['forwarded_ip'] = '';
    }

    $order_data['user_agent'] = (isset($this->request->server['HTTP_USER_AGENT'])) ? $this->request->server['HTTP_USER_AGENT'] : '';
    $order_data['accept_language'] = (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) ? $this->request->server['HTTP_ACCEPT_LANGUAGE'] : '';

    $this->session->data['order_id'] = $this->model_checkout_order->addOrder($order_data);

    if (isset($form_data['checkout_blocks']) && in_array('payment', $form_data['checkout_blocks'])) {
      $data['payment'] = $this->load->controller('payment/'.$this->session->data['payment_method']['code']);
    } else {
      $data['payment'] = "";
      $this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $form_data['order_status_id']);
    }

    if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/confirm.tpl')) {
      $this->response->setOutput($this->load->view($this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/confirm.tpl', $data));
    } else {
      $this->response->setOutput($this->load->view('default/template/checkout/'.self::$_module_name.'/confirm.tpl', $data));
    }
  }

  public function login() {
    $data = array();
    $data = array_merge($data, $this->load->language('checkout/'.self::$_module_name));

    $data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

    if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/login.tpl')) {
      return $this->load->view($this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/login.tpl', $data);
    } else {
      return $this->load->view('default/template/checkout/'.self::$_module_name.'/login.tpl', $data);
    }
  }

  public function login_save() {
    $json = array();

    $this->load->model('account/customer');
    $this->load->language('checkout/'.self::$_module_name);

    // check how many login attempts have been made
    $login_info = $this->model_account_customer->getLoginAttempts($this->request->post['email']);

    if ($login_info && ($login_info['total'] >= $this->config->get('config_login_attempts')) && strtotime('-1 hour') < strtotime($login_info['date_modified'])) {
      $json['error']['warning'] = $this->language->get('error_attempts');
    }

    // check if customer has been approved
    $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

    if ($customer_info && !$customer_info['approved']) {
      $json['error']['warning'] = $this->language->get('error_approved');
    }

    if (!isset($json['error'])) {
      if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
        $json['error']['warning'] = $this->language->get('error_login');
        $this->model_account_customer->addLoginAttempt($this->request->post['email']);
      } else {
        $this->model_account_customer->deleteLoginAttempts($this->request->post['email']);
      }
    }

    if (!$json) {
      unset($this->session->data['guest']);

      $this->load->model('account/address');

      if ($this->config->get('config_tax_customer') == 'payment') {
        $this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
      }

      if ($this->config->get('config_tax_customer') == 'shipping') {
        $this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
      }

      $json['redirect'] = $this->url->link('checkout/'.self::$_module_name, '', 'SSL');

      // add to activity log
      $this->load->model('account/activity');

      $activity_data = array(
        'customer_id' => $this->customer->getId(),
        'name'        => $this->customer->getFirstName().' '.$this->customer->getLastName()
      );

      $this->model_account_activity->addActivity('login', $activity_data);
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function logout() {
    $json = array();

    if ($this->customer->isLogged()) {
      $this->event->trigger('pre.customer.logout');

      $this->customer->logout();
      $this->cart->clear();

      unset($this->session->data['wishlist']);
      unset($this->session->data['shipping_address']);
      unset($this->session->data['shipping_method']);
      unset($this->session->data['shipping_methods']);
      unset($this->session->data['payment_address']);
      unset($this->session->data['payment_method']);
      unset($this->session->data['payment_methods']);
      unset($this->session->data['comment']);
      unset($this->session->data['smopc_payment_comment']);
      unset($this->session->data['order_id']);
      unset($this->session->data['coupon']);
      unset($this->session->data['reward']);
      unset($this->session->data['voucher']);
      unset($this->session->data['vouchers']);

      $this->event->trigger('post.customer.logout');

      $json['redirect'] = $this->url->link('checkout/'.self::$_module_name, '', 'SSL');
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function country() {
    $json = array();

    $this->load->model('localisation/country');

    $country_info = $this->model_localisation_country->getCountry($this->request->request['country_id']);

    if ($country_info) {
      $this->load->model('localisation/zone');

      $json = array(
        'country_id'        => $country_info['country_id'],
        'name'              => $country_info['name'],
        'iso_code_2'        => $country_info['iso_code_2'],
        'iso_code_3'        => $country_info['iso_code_3'],
        'address_format'    => $country_info['address_format'],
        'postcode_required' => $country_info['postcode_required'],
        'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->request['country_id']),
        'status'            => $country_info['status']
      );
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function remove_voucher() {
    $json = array();

    if (isset($this->session->data['voucher'])) {
      unset($this->session->data['voucher']);
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function apply_voucher() {
    $json = array();

    $this->load->model((version_compare(VERSION, '2.1.0.1') < 0) ? 'checkout/voucher' : 'total/voucher');
    $this->load->language('checkout/'.self::$_module_name);

    $voucher = (isset($this->request->post['voucher'])) ? $this->request->post['voucher'] : '';
    $voucher_info = $this->{'model_'.((version_compare(VERSION, '2.1.0.1') < 0) ? 'checkout_voucher' : 'total_voucher')}->getVoucher($voucher);

    if (empty($this->request->post['voucher'])) {
      $json['error'] = $this->language->get('error_empty_voucher');
      unset($this->session->data['voucher']);
    } elseif ($voucher_info) {
      $this->session->data['voucher'] = $this->request->post['voucher'];
      $json['success'] = $this->language->get('text_success_voucher');
    } else {
      $json['error'] = $this->language->get('error_voucher');
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function remove_coupon() {
    $json = array();

    if (isset($this->session->data['coupon'])) {
      unset($this->session->data['coupon']);
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function apply_coupon() {
    $json = array();

    $this->load->model((version_compare(VERSION, '2.1.0.1') < 0) ? 'checkout/coupon' : 'total/coupon');
    $this->load->language('checkout/'.self::$_module_name);

    $coupon = (isset($this->request->post['coupon'])) ? $this->request->post['coupon'] : '';

    $coupon_info = $this->{'model_'.((version_compare(VERSION, '2.1.0.1') < 0) ? 'checkout_coupon' : 'total_coupon')}->getCoupon($coupon);

    if (empty($this->request->post['coupon'])) {
      $json['error'] = $this->language->get('error_empty_coupon');
      unset($this->session->data['coupon']);
    } elseif ($coupon_info) {
      $this->session->data['coupon'] = $this->request->post['coupon'];
      $json['success'] = $this->language->get('text_success_coupon');
    } else {
      $json['error'] = $this->language->get('error_coupon');
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function remove_reward() {
    $json = array();

    if (isset($this->session->data['reward'])) {
      unset($this->session->data['reward']);
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function apply_reward() {
    $json = array();

    $this->load->language('checkout/'.self::$_module_name);

    $points = $this->customer->getRewardPoints();

    $points_total = 0;

    foreach ($this->cart->getProducts() as $product) {
      if ($product['points']) {
        $points_total += $product['points'];
      }
    }

    if (empty($this->request->post['reward'])) {
      $json['error'] = $this->language->get('error_reward');
    }

    if ($this->request->post['reward'] > $points) {
      $json['error'] = sprintf($this->language->get('error_points'), $this->request->post['reward']);
    }

    if ($this->request->post['reward'] > $points_total) {
      $json['error'] = sprintf($this->language->get('error_maximum'), $points_total);
    }

    if (!$json) {
      $this->session->data['reward'] = abs($this->request->post['reward']);
      $json['success'] = $this->language->get('text_success_reward');
    }

    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }

  public function coupon_voucher_reward() {
    $data = array();
    $data = array_merge($data, $this->load->language('checkout/'.self::$_module_name), $this->config->get(self::$_module_name.'_form_data'));

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    if (isset($form_data['checkout_blocks']) && in_array('coupon', $form_data['checkout_blocks'])) {
      $data['coupon'] = (isset($this->session->data['coupon'])) ? $this->session->data['coupon'] : '';
    }

    if (isset($form_data['checkout_blocks']) && in_array('voucher', $form_data['checkout_blocks'])) {
      $data['voucher'] = (isset($this->session->data['voucher'])) ? $this->session->data['voucher'] : '';
    }

    $points = $this->customer->getRewardPoints();

    $points_total = 0;

    foreach ($this->cart->getProducts() as $product) {
      if ($product['points']) {
        $points_total += $product['points'];
      }
    }

    if ($points && $points_total && in_array('reward', $form_data['checkout_blocks'])) {
      $data['heading_reward_block'] = sprintf($this->language->get('heading_reward_block'), $points);
      $data['entry_reward'] = sprintf($this->language->get('entry_reward'), $points_total);
      $data['reward'] = (isset($this->session->data['reward'])) ? $this->session->data['reward'] : '';
    }

    if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/coupon_voucher_reward.tpl')) {
      return $this->load->view($this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/coupon_voucher_reward.tpl', $data);
    } else {
      return $this->load->view('default/template/checkout/'.self::$_module_name.'/coupon_voucher_reward.tpl', $data);
    }
  }

  public function validate($data) {

    $form_data = (array)$this->config->get(self::$_module_name.'_form_data');

    if ($data == 'cart') {
      $customer_group_id = $this->customer->isLogged() ? $this->customer->getGroupId() : $this->config->get('config_customer_group_id');

      foreach ($form_data['customer_group'] as $key => $customer_group_value) {
        if ($key == $customer_group_id) {
          if ($customer_group_value['min_order_total'] && $this->cart->getTotal() < $customer_group_value['min_order_total']) {
            $error = sprintf($this->language->get('error_min_order_total'), $customer_group_value['min_order_total']);
          }
          if ($customer_group_value['max_order_total'] && $this->cart->getTotal() > $customer_group_value['max_order_total']) {
            $error = sprintf($this->language->get('error_max_order_total'), $customer_group_value['max_order_total']);
          }
          if ($customer_group_value['min_weight_total'] && $this->cart->getWeight() < $customer_group_value['min_weight_total']) {
            $error = sprintf($this->language->get('error_min_weight_total'), $customer_group_value['min_weight_total']);
          }
          if ($customer_group_value['max_weight_total'] && $this->cart->getWeight() > $customer_group_value['max_weight_total']) {
            $error = sprintf($this->language->get('error_max_weight_total'), $customer_group_value['max_weight_total']);
          }
          if ($customer_group_value['min_quantity_total'] && $this->cart->countProducts() < $customer_group_value['min_quantity_total']) {
            $error = sprintf($this->language->get('error_min_quantity_total'), $customer_group_value['min_quantity_total']);
          }
          if ($customer_group_value['max_quantity_total'] && $this->cart->countProducts() > $customer_group_value['max_quantity_total']) {
            $error = sprintf($this->language->get('error_max_quantity_total'), $customer_group_value['max_quantity_total']);
          }
        }
      }

      $products = $this->cart->getProducts();

      foreach ($products as $product) {
        $product_total = 0;
        foreach ($products as $product_2) {
          if ($product_2['product_id'] == $product['product_id']) {
            $product_total += $product_2['quantity'];
          }
        }
        if ($product['minimum'] > $product_total) {
          $error = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
        }
      }

      if (!$form_data['stock_checkout'] && !$this->cart->hasStock()) {
        $error = $this->language->get('error_stock');
      }
    }

    if (isset($error)) {
      if ($data == 'cart') {
        return $error;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  public function success() {
    $data = array();

    // connect models array
    $models = array('tool/image', 'checkout/'.self::$_module_name, 'account/order', 'checkout/order' );
    foreach ($models as $model) {
      $this->load->model($model);
    }

    $order_status = false;

    if (isset($this->session->data['order_id']) && (!empty($this->session->data['order_id']))) {
      $this->session->data['current_order_id'] = $this->session->data['order_id'];
    }

    if (isset($this->session->data['order_id'])) {
      $this->cart->clear();
      unset($this->session->data['shipping_method']);
      unset($this->session->data['shipping_methods']);
      unset($this->session->data['payment_method']);
      unset($this->session->data['payment_methods']);
      unset($this->session->data['guest']);
      unset($this->session->data['comment']);
      unset($this->session->data['order_id']);
      unset($this->session->data['coupon']);
      unset($this->session->data['reward']);
      unset($this->session->data['voucher']);
      unset($this->session->data['vouchers']);
      unset($this->session->data['totals']);
    }

    $data = array_merge($data, $this->language->load('checkout/'.self::$_module_name), $this->config->get(self::$_module_name.'_sp_form_data'), $this->config->get(self::$_module_name.'_sp_form_data'), $this->config->get(self::$_module_name.'_form_data'));

    $sp_text_data  = (array)$this->config->get(self::$_module_name.'_sp_text_data');
    $sp_form_data  = (array)$this->config->get(self::$_module_name.'_sp_form_data');
    $form_data  = (array)$this->config->get(self::$_module_name.'_form_data');

    if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/stylesheet/'.self::$_module_name.'/stylesheet.css')) {
      $this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template').'/stylesheet/'.self::$_module_name.'/stylesheet.css');
    } else {
      $this->document->addStyle('catalog/view/theme/default/stylesheet/'.self::$_module_name.'/stylesheet.css');
    }

    $this->document->addStyle("catalog/view/theme/default/stylesheet/". self::$_module_name. "/print.css", $rel = 'stylesheet', $media = 'print');

    $language_code = $this->session->data['language'];

    if (isset($sp_text_data[$language_code])) {
      $this->document->setTitle($this->language->get('text_empty'));
      $data['heading_title'] = $this->language->get('text_empty');
    }

    $data['breadcrumbs'] = array(
      0 => array(
        'href'      => $this->url->link('common/home'),
        'text'      => $this->language->get('text_home'),
        'separator' => false
      ),
      1 => array(
        'href'      => $this->url->link('checkout/success'),
        'text'      => $this->language->get('text_success'),
        'separator' => $this->language->get('text_separator')
      )
    );

    if (isset($this->session->data['current_order_id']) && !empty($this->session->data['current_order_id'])) {

      $order_info = $this->model_checkout_order->getOrder($this->session->data['current_order_id']);

      $order_status = true;

      $code_find = array(
        '{firstname}',
        '{lastname}',
        '{order_id}'
      );

      $code_replace = array(
        $order_info['firstname'],
        $order_info['lastname'],
        $order_info['order_id']
      );

      $code_find_full = array(
        '{firstname}',
        '{lastname}',
        '{email}',
        '{total}',
        '{address_1}',
        '{address_2}',
        '{telephone}',
        '{fax}',
        '{postcode}',
        '{city}',
        '{order_id}',
        '{comment}'
      );

      $code_replace_full = array(
        $order_info['payment_firstname'] ? $order_info['payment_firstname'] : '',
        $order_info['payment_lastname'] ? $order_info['payment_lastname'] : '',
        $order_info['email'] ? $order_info['email'] : '',
        $this->currency->format($order_info['total']),
        $order_info['payment_address_1'] ? $order_info['payment_address_1'] : '',
        $order_info['payment_address_2'] ? $order_info['payment_address_2'] : '',
        $order_info['telephone'] ? $order_info['telephone'] : '',
        $order_info['fax'] ? $order_info['fax'] : '',
        $order_info['payment_postcode'] ? $order_info['payment_postcode'] : '',
        $order_info['payment_city'] ? $order_info['payment_city'] : '',
        $order_info['order_id'],
        $order_info['comment'] ? $order_info['comment'] : ''
      );

      if (isset($sp_text_data[$language_code])) {
        $data['heading_title'] = html_entity_decode(str_ireplace($code_find, $code_replace, $sp_text_data[$language_code]['heading']), ENT_QUOTES, 'UTF-8');
        $this->document->setTitle(str_ireplace($code_find, $code_replace, $sp_text_data[$language_code]['heading']));
        $data['recommended_products_heading_title'] = html_entity_decode(str_ireplace($code_find, $code_replace, $sp_text_data[$language_code]['recommended_products_heading']), ENT_QUOTES, 'UTF-8');
        $data['text_success'] = html_entity_decode(str_ireplace($code_find_full, $code_replace_full, $sp_text_data[$language_code]['success_text']), ENT_QUOTES, 'UTF-8');
      }

      if ($order_info['invoice_no']) {
        $data['invoice_no'] = $order_info['invoice_prefix'].$order_info['invoice_no'];
      } else {
        $data['invoice_no'] = '';
      }

      $coupon_info = $this->{'model_checkout_'.self::$_module_name}->getCoupon($form_data['gift_coupon']);

      $data['gift_coupon_code'] = $coupon_info ? $coupon_info['code'] : '';

      $data['order_id'] = $order_info['order_id'];
      $data['date_added'] = date($this->language->get('date_format_short'), strtotime($order_info['date_added']));
      $data['payment_method'] = $order_info['payment_method'];
      $data['shipping_method'] = $order_info['shipping_method'];
      $data['email'] = $order_info['email'];
      $data['telephone'] = $order_info['telephone'];
      $data['ip'] = $order_info['ip'];

      if ($order_info['comment']) {
        $data['comment'] = nl2br($order_info['comment']);
      } else {
        $data['comment'] = '';
      }

      if (isset($this->session->data['smopc_payment_comment'])) {
        $data['payment_instructions'] = nl2br($this->session->data['smopc_payment_comment']);
      } else {
        $data['payment_instructions'] = '';
      }

      if ($order_info['payment_address_format']) {
        $format = $order_info['payment_address_format'];
      } else {
        $format = '{firstname} {lastname}'."\n".'{company}'."\n".'{address_1}'."\n".'{address_2}'."\n".'{city} {postcode}'."\n".'{zone}'."\n".'{country}';
      }

      $find = array(
        '{firstname}',
        '{lastname}',
        '{telephone}',
        '{company}',
        '{address_1}',
        '{address_2}',
        '{city}',
        '{postcode}',
        '{zone}',
        '{zone_code}',
        '{country}'
      );

      $replace = array(
        'firstname' => $order_info['payment_firstname'],
        'lastname'  => $order_info['payment_lastname'],
        'telephone' => $order_info['telephone'],
        'company'   => $order_info['payment_company'],
        'address_1' => $order_info['payment_address_1'],
        'address_2' => $order_info['payment_address_2'],
        'city'      => $order_info['payment_city'],
        'postcode'  => $order_info['payment_postcode'],
        'zone'      => $order_info['payment_zone'],
        'zone_code' => $order_info['payment_zone_code'],
        'country'   => $order_info['payment_country']
      );

      $data['payment_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

      if ($order_info['shipping_address_format']) {
        $format = $order_info['shipping_address_format'];
      } else {
        $format = '{firstname} {lastname}'."\n".'{company}'."\n".'{address_1}'."\n".'{address_2}'."\n".'{city} {postcode}'."\n".'{zone}'."\n".'{country}';
      }

      $find = array(
        '{firstname}',
        '{lastname}',
        '{telephone}',
        '{company}',
        '{address_1}',
        '{address_2}',
        '{city}',
        '{postcode}',
        '{zone}',
        '{zone_code}',
        '{country}'
      );

      $replace = array(
        'firstname' => $order_info['shipping_firstname'],
        'lastname'  => $order_info['shipping_lastname'],
        'telephone' => $order_info['telephone'],
        'company'   => $order_info['shipping_company'],
        'address_1' => $order_info['shipping_address_1'],
        'address_2' => $order_info['shipping_address_2'],
        'city'      => $order_info['shipping_city'],
        'postcode'  => $order_info['shipping_postcode'],
        'zone'      => $order_info['shipping_zone'],
        'zone_code' => $order_info['shipping_zone_code'],
        'country'   => $order_info['shipping_country']
      );

      $data['shipping_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

      // order products
      $data['products'] = array();

      $order_product_query = $this->db->query("SELECT op.*, p.image FROM ".DB_PREFIX."order_product op LEFT JOIN ".DB_PREFIX."product p ON (op.product_id = p.product_id) WHERE op.order_id = '".(int)$order_info['order_id']."'");

      foreach ($order_product_query->rows as $product) {
        $option_data = array();

        $order_option_query = $this->db->query("SELECT * FROM ".DB_PREFIX."order_option WHERE order_id = '".(int)$order_info['order_id']."' AND order_product_id = '".(int)$product['order_product_id']."'");

        foreach ($order_option_query->rows as $option) {
          if ($option['type'] != 'file') {
            $value = $option['value'];
          } else {
            $value = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));
          }

          $option_data[] = array(
            'name'  => $option['name'],
            'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20).'..' : $value)
          );
        }
        
        $sql = "SELECT p.image, cp.child_id FROM ".DB_PREFIX."product AS p, ".DB_PREFIX."child_products AS cp WHERE cp.product_id = '".(int)$product['product_id']."' AND cp.child_id = p.product_id ORDER BY p.price ASC LIMIT 1";
          $imagenew = $this->db->query($sql);
    
        if (!empty($imagenew->row['image']) && !empty($imagenew->row['child_id'])) {
          $product['image'] = $imagenew->row['image'];
          $product['child'] = $imagenew->row['child_id'];
        }


        $image = ($product['image']) ? $this->model_tool_image->resize( $product['image'], $sp_form_data['table_image_width'], $sp_form_data['table_image_height']) : $this->model_tool_image->resize("no_image.jpg", $sp_form_data['table_image_width'], $sp_form_data['table_image_height']);

        $data['products'][] = array(
          'product_id'  => $product['product_id'],
          'name'        => $product['name'],
          'model'       => $product['model'],
          'sku'         => !empty($product['sku']) ? $product['sku'] : $product['model'],
          'thumb'       => $image,
          'option'      => $option_data,
          'quantity'    => $product['quantity'],
          'price'       => $this->currency->format($product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value']),
          'ga_price'    => $product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value'],
          'total'       => $this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']),
          'href'        => $this->url->link('product/product', 'product_id='.$product['product_id']),
        );
      }

      // vouchers
      $data['vouchers'] = array();

      $vouchers = $this->model_account_order->getOrderVouchers($order_info['order_id']);

      foreach ($vouchers as $voucher) {
        $data['vouchers'][] = array(
          'description' => $voucher['description'],
          'amount'      => $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value'])
        );
      }

      // order totals
      $data['totals'] = array();

      $totals = $this->model_account_order->getOrderTotals($order_info['order_id']);

      foreach ($totals as $total) {
        $data['totals'][] = array(
          'title' => $total['title'],
          'text'  => $this->currency->format($total['value'], $order_info['currency_code'], $order_info['currency_value'])
        );
      }

      // tax
      $tax = 0;
      foreach ($order_product_query->rows as $product) {
        $tax = $tax + $product['tax'];
      }

      $order_total_query = $this->db->query("SELECT * FROM `".DB_PREFIX."order_total` WHERE order_id = '".(int)$order_info['order_id']."' ORDER BY sort_order ASC");

      // totals
      $totals = array();
      foreach($order_total_query->rows as $total) {
        $totals[] = $total['value'];
      }

      // google ecommerce tracking
      $data['ga_order_id']    = (int)$order_info['order_id']; // Transaction ID. Required.
      $data['ga_affiliation'] = (string)$this->config->get('config_name');   // Affiliation or store name.
      $data['ga_revenue']     = round(end($totals), 2);
      $data['ga_tax']         = round($tax, 2);
      $data['ga_currency']    = (string)$this->currency->getCode();

      // google event
      $data['ga_e_category']  = !empty($form_data['google_event_category']) ? $form_data['google_event_category'] : "One Page Checkout";
      $data['ga_e_action']    = !empty($form_data['google_event_action']) ? $form_data['google_event_action'] : "Success";
      $data['ga_e_name']      = (string)$this->config->get('config_name');
      $data['ga_e_order_id']  = (int)$order_info['order_id'];

    } else {
      $data['text_order_empty'] = $this->language->get('text_empty');
    }

    $data['order_status'] = $order_status;
    $data['continue']   = $this->url->link('common/home');

    // recommended products
    $data['recommended_products'] = array();

    $data['text_tax'] = $this->language->get('text_tax');

    if (!empty($sp_form_data['check']) && $sp_form_data['check'] == 3) {

      $products = array();

      if (isset($sp_form_data['recommended_products'])) {
        foreach ($sp_form_data['recommended_products'] as $product_id) {
          $products[] = $product_id;
        }
      }

      $data_x = array(
        'sort'  => 'p.date_added',
        'order' => 'DESC',
        'start' => 0,
        'limit' => $sp_form_data['limit_recommended'],
        'products_id' => implode(',', $products)
      );

      $ajax_products = $this->{'model_checkout_'.self::$_module_name}->getRecommendedProducts($data_x);

      foreach($ajax_products as $product) {
        if (in_array($product['product_id'], $products)) {

          $image = ($product['image']) ? $this->model_tool_image->resize($product['image'], $sp_form_data['sub_images_width'], $sp_form_data['sub_images_height']) : $this->model_tool_image->resize("placeholder.png", $sp_form_data['sub_images_width'], $sp_form_data['sub_images_height']);

          $price = (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) ? $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'))) : false;

          $special = ((float)$product['special']) ? $this->currency->format($this->tax->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax'))) : false;

          $rating = ($this->config->get('config_review_status')) ? $product['rating'] : false;

          $data['recommended_products'][] = array(
            'product_id' => $product['product_id'],
            'thumb'      => $image,
            'name'       => $product['name'],
            'price'      => $price,
            'special'    => $special,
            'rating'     => $rating,
            'reviews'    => sprintf($this->language->get('text_reviews'), (int)$product['reviews']),
            'href'       => $this->url->link('product/product', 'product_id='.$product['product_id'])
          );
        }
      }
    } else {
      if ($sp_form_data['check']) {
        if ($sp_form_data['check'] == 1) {
          $data_x = array(
            'sort'                => 'p.date_added',
            'order'               => 'DESC',
            'start'               => 0,
            'limit'               => $sp_form_data['limit_recommended'],
            'filter_category_id'  => (!empty($sp_form_data['recommended_categories']) && $sp_form_data['check'] == 1) ? $sp_form_data['recommended_categories'] : false,
            'filter_sub_category' => true
          );
        }
        if ($sp_form_data['check'] == 2) {
          $data_x = array(
            'sort'                   => 'p.date_added',
            'order'                  => 'DESC',
            'start'                  => 0,
            'limit'                  => $sp_form_data['limit_recommended'],
            'filter_manufacturer_id' => (!empty($sp_form_data['recommended_manufacturers']) && $sp_form_data['check'] == 2) ? $sp_form_data['recommended_manufacturers'] : false
          );
        }

        $ajax_products = $this->{'model_checkout_'.self::$_module_name}->getRecommendedProducts($data_x);

        foreach ($ajax_products as $product) {

          $image = ($product['image']) ? $this->model_tool_image->resize($product['image'], $sp_form_data['sub_images_width'], $sp_form_data['sub_images_height']) : $this->model_tool_image->resize("placeholder.png", $sp_form_data['sub_images_width'], $sp_form_data['sub_images_height']);

          $price = (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) ? $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'))) : false;

          $special = ((float)$product['special']) ? $this->currency->format($this->tax->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax'))) : false;

          $rating = ($this->config->get('config_review_status')) ? $product['rating'] : false;

          $tax = ($this->config->get('config_tax')) ? $this->currency->format((float)$product['special'] ? $product['special'] : $product['price']) : false;

          $data['recommended_products'][] = array(
            'product_id' => $product['product_id'],
            'thumb'      => $image,
            'name'       => $product['name'],
            'description'=> utf8_substr(strip_tags(html_entity_decode($product['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')).'..',
            'price'      => $price,
            'special'    => $special,
            'tax'        => $tax,
            'rating'     => $rating,
            'reviews'    => sprintf($this->language->get('text_reviews'), (int)$product['reviews']),
            'href'       => $this->url->link('product/product', 'product_id='.$product['product_id'])
          );
        }
      }
    }

    $data['column_left']    = $this->load->controller('common/column_left');
    $data['column_right']   = $this->load->controller('common/column_right');
    $data['content_top']    = $this->load->controller('common/content_top');
    $data['content_bottom'] = $this->load->controller('common/content_bottom');
    $data['footer']         = $this->load->controller('common/footer');
    $data['header']         = $this->load->controller('common/header');

    if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/success.tpl')) {
      $this->response->setOutput($this->load->view($this->config->get('config_template').'/template/checkout/'.self::$_module_name.'/success.tpl', $data));
    } else {
      $this->response->setOutput($this->load->view('default/template/checkout/'.self::$_module_name.'/success.tpl', $data));
    }
  }

  public function replaceValue($view, $selector) {
    $views = array(
      'email'      => 'text',
      'firstname'  => 'text',
      'lastname'   => 'text',
      'telephone'  => 'text',
      'fax'        => 'text',
      'company'    => 'text',
      'company_id' => 'text',
      'text_id'    => 'text',
      'address_1'  => 'text',
      'address_2'  => 'text',
      'city'       => 'text',
      'postcode'   => 'text',
      'country_id' => 'select',
      'zone_id'    => 'select',
      'comment'    => 'textarea'
    );

    if ($selector == 1) {
      foreach ($views as $key => $value) {
        if ($key == $view) {
          return $value;
        }
      }
    } else {
      foreach ($views as $key => $value) {
        if ($key == $view) {
          return $key;
        }
      }
    }
  }

  public function getActiveField($customer_group_id, $address_block) {
    $field_data = (array)$this->config->get(self::$_module_name.'_field_data');

    foreach ($field_data as $key => $field) {
      if (!isset($field['customer_groups']) || !isset($field['address_blocks']) || ($field['activate'] == 0 || ($this->customer->isLogged() && ($field['view'] == 'email' || $field['view'] == 'fax' || $field['view'] == 'telephone')) || !in_array($customer_group_id, $field['customer_groups']) || !in_array($address_block, $field['address_blocks']))) {
        unset($field_data[$key]);
      }
    }

    return $field_data;
  }
}