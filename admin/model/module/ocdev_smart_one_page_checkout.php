<?php

// @category  : OpenCart
// @module    : Smart One Page Checkout
// @author    : OCdevWizard <ocdevwizard@gmail.com>
// @copyright : Copyright (c) 2015, OCdevWizard
// @license   : http://license.ocdevwizard.com/Licensing_Policy.pdf

class ModelModuleOCdevSmartOnePageCheckout extends Model {

  static $_module_version = '1.0.3';
  static $_module_name    = 'ocdev_smart_one_page_checkout';

  public function getOCdevCatalog() {
    $catalog = array();

    $results = simplexml_load_file('http://ocdevwizard.com/products/share/share.xml');

    if ($results !== false) {
      foreach ($results->product as $product) {
        $catalog[] = array(
          'extension_id'      => (int)$product->extension_id,
          'title'             => (string)$product->title,
          'img'               => (string)$product->img,
          'price'             => (string)$product->price,
          'url'               => (string)str_replace("&amp;", "&", $product->url),
          'date_added'        => (string)$product->date_added,
          'opencart_version'  => (string)$product->opencart_version,
          'latest_version'    => (string)$product->latest_version,
          'features'          => (string)$product->features
        );
      }
    }
    return $catalog;
  }
}
