<?php echo $header; ?>
<?php echo $column_left; ?>

<!--
@category  : OpenCart
@module    : Smart One Page Checkout
@author    : OCdevWizard <ocdevwizard@gmail.com>
@copyright : Copyright (c) 2015, OCdevWizard
@license   : http://license.ocdevwizard.com/Licensing_Policy.pdf
 -->

<?php
// CODE ABBREVIATION
// opc - one page checkout;
// sp - success page;
// rp - recommended products;
?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" formaction="<?php echo $action; ?>" form="form-one-page-checkout" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <button type="submit" formaction="<?php echo $action_plus; ?>" form="form-one-page-checkout" data-toggle="tooltip" title="<?php echo $button_save_and_stay; ?>" class="btn btn-primary"><i class="fa fa-refresh"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
        <h1><?php echo $heading_name; ?></h1>
        <ul class="breadcrumb">
          <?php foreach ($breadcrumbs as $breadcrumb) { ?>
          <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
          <?php } ?>
        </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form method="post" enctype="multipart/form-data" id="form-one-page-checkout" class="form-horizontal">
          <!-- Nav tabs -->
          <ul class="nav nav-tabs" id="setting-tabs">
            <li class="active dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="fa fa-cog"></i> <?php echo $tab_control_panel; ?> <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="#general-block" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_general_setting; ?></a></li>
                <li><a href="#import-export-block" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_import_export_setting; ?></a></li>
              </ul>
            </li>
            <li><a href="#layout-block" data-toggle="tab"><i class="fa fa-eye"></i> <?php echo $tab_layout_setting; ?></a></li>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="fa fa-language"></i> <?php echo $tab_language_setting; ?> <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="#language-block" data-toggle="tab"><i class="fa fa-flag-o"></i> <?php echo $tab_basic_language_setting; ?></a></li>
                <li><a href="#custom-success-block" data-toggle="tab"><i class="fa fa-flag-o"></i> <?php echo $tab_custom_success_setting; ?></a></li>
              </ul>
            </li>
            <li class="dropdown">
              <a data-toggle="dropdown" href="#"><i class="fa fa-bars"></i> <?php echo $tab_fields_setting; ?> <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="#fields-block" data-toggle="tab"><i class="fa fa-puzzle-piece"></i> <?php echo $tab_basic_fields_setting; ?></a></li>
                <li><a href="<?php echo $opencart_custom_fields_link; ?>" target="_blank" data-toggle="tooltip" data-placement="bottom" title="<?php echo $text_opencart_custom_fields_setting_faq; ?>"><i class="fa fa-puzzle-piece"></i> <?php echo $tab_opencart_custom_fields_setting; ?></a></li>
              </ul>
            </li>
            <li><a href="#marketing-tools-block" data-toggle="tab"><i class="fa fa-thumbs-o-up"></i> <?php echo $tab_marketing_tools_setting; ?></a></li>
            <li><a href="#analytics-block" data-toggle="tab"><i class="fa fa-line-chart"></i> <?php echo $tab_analytics_setting; ?></a></li>
            <li><a href="#about-block" data-toggle="tab"><i class="fa fa-info-circle"></i> <?php echo $tab_about_setting; ?></a></li>
            <li><a href="#promo-block" data-toggle="tab"><i class="fa fa-briefcase"></i> <?php echo $tab_promo_setting; ?></a></li>
          </ul>
          <div class="tab-content">
            <!-- TAB General setting -->
            <div class="tab-pane active" id="general-block">
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_activate_module; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['activate'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[activate]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['activate'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['activate'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[activate]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['activate'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-alternative_email"><span data-toggle="tooltip" data-placement="right" title="<?php echo $text_alternative_email_faq; ?>"><?php echo $text_alternative_email; ?></span></label>
                <div class="col-sm-10">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-envelope-o"></i></span>
                    <input value="<?php echo $form_data['alternative_email']; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[alternative_email]" class="form-control" id="input-alternative_email" />
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-prefix_order"><span data-toggle="tooltip" data-placement="right" title="<?php echo $text_order_prefix_faq; ?>"><?php echo $text_order_prefix; ?></span></label>
                <div class="col-sm-10">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-tag"></i></span>
                    <input value="<?php echo $form_data['prefix_order']; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[prefix_order]" class="form-control" id="input-prefix_order" />
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_order_status; ?></label>
                <div class="col-sm-10">
                  <select name="<?php echo $_module_name; ?>_form_data[order_status_id]" class="form-control">
                    <?php foreach ($order_statuses as $order_status) { ?>
                      <?php if (isset($form_data['order_status_id']) && $order_status['status_id'] == $form_data['order_status_id']) { ?>
                        <option value="<?php echo $order_status['status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                      <?php } else { ?>
                        <option value="<?php echo $order_status['status_id']; ?>"><?php echo $order_status['name']; ?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" data-placement="right" title="<?php echo $text_checkout_validation_rules_faq; ?>"><?php echo $text_checkout_validation_rules; ?></span></label>
                <div class="col-sm-10">
                  <ul class="nav nav-tabs" id="order-totals-validations" style="margin-bottom:10px;">
                    <?php foreach ($all_customer_groups as $customer_group) { ?>
                      <li>
                        <a href="#tab-order-totals-validations<?php echo $customer_group['customer_group_id']; ?>" data-toggle="tab"> <?php echo $customer_group['name']; ?></a>
                      </li>
                    <?php } ?>
                  </ul>
                  <div class="tab-content">
                  <?php foreach ($all_customer_groups as $customer_group) { ?>
                    <div class="tab-pane" id="tab-order-totals-validations<?php echo $customer_group['customer_group_id']; ?>">
                      <div class="form-group">
                        <div class="col-sm-12">
                          <label><?php echo $text_order_total_validation; ?></label>
                          <div class="input-group">
                            <span class="input-group-addon"><?php echo $text_min; ?>&nbsp;</span>
                            <input value="<?php echo (!empty($form_data['customer_group'][$customer_group['customer_group_id']]['min_order_total'])) ? $form_data['customer_group'][$customer_group['customer_group_id']]['min_order_total'] : ''; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[customer_group][<?php echo $customer_group['customer_group_id']; ?>][min_order_total]" class="form-control" />
                          </div>
                          <div class="special_margin"></div>
                          <div class="input-group">
                            <span class="input-group-addon"><?php echo $text_max; ?></span>
                            <input value="<?php echo (!empty($form_data['customer_group'][$customer_group['customer_group_id']]['max_order_total'])) ? $form_data['customer_group'][$customer_group['customer_group_id']]['max_order_total'] : ''; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[customer_group][<?php echo $customer_group['customer_group_id']; ?>][max_order_total]" class="form-control" />
                          </div>
                        </div>
                      </div>
                      <div class="form-group">
                        <div class="col-sm-12">
                          <label><?php echo $text_order_weight_validation; ?></label>
                          <div class="input-group">
                            <span class="input-group-addon"><?php echo $text_min; ?>&nbsp;</span>
                            <input value="<?php echo (!empty($form_data['customer_group'][$customer_group['customer_group_id']]['min_weight_total'])) ? $form_data['customer_group'][$customer_group['customer_group_id']]['min_weight_total'] : ''; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[customer_group][<?php echo $customer_group['customer_group_id']; ?>][min_weight_total]" class="form-control" />
                          </div>
                          <div class="special_margin"></div>
                          <div class="input-group">
                            <span class="input-group-addon"><?php echo $text_max; ?></span>
                            <input value="<?php echo (!empty($form_data['customer_group'][$customer_group['customer_group_id']]['max_weight_total'])) ? $form_data['customer_group'][$customer_group['customer_group_id']]['max_weight_total'] : ''; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[customer_group][<?php echo $customer_group['customer_group_id']; ?>][max_weight_total]" class="form-control" />
                          </div>
                        </div>
                      </div>
                      <div class="form-group">
                        <div class="col-sm-12">
                          <label><?php echo $text_order_quantity_validation; ?></label>
                          <div class="input-group">
                            <span class="input-group-addon"><?php echo $text_min; ?>&nbsp;</span>
                            <input value="<?php echo (!empty($form_data['customer_group'][$customer_group['customer_group_id']]['min_quantity_total'])) ? $form_data['customer_group'][$customer_group['customer_group_id']]['min_quantity_total'] : ''; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[customer_group][<?php echo $customer_group['customer_group_id']; ?>][min_quantity_total]" class="form-control" />
                          </div>
                          <div class="special_margin"></div>
                          <div class="input-group">
                            <span class="input-group-addon"><?php echo $text_max; ?></span>
                            <input value="<?php echo (!empty($form_data['customer_group'][$customer_group['customer_group_id']]['max_quantity_total'])) ? $form_data['customer_group'][$customer_group['customer_group_id']]['max_quantity_total'] : ''; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[customer_group][<?php echo $customer_group['customer_group_id']; ?>][max_quantity_total]" class="form-control" />
                          </div>
                        </div>
                      </div>
                    </div>
                  <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_allow_guest_order; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['allow_guest_order'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_guest_order]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['allow_guest_order'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['allow_guest_order'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_guest_order]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['allow_guest_order'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_allow_register; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['allow_register'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_register]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['allow_register'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['allow_register'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_register]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['allow_register'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_allow_login; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['allow_login'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_login]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['allow_login'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['allow_login'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_login]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['allow_login'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" data-placement="right" title="<?php echo $text_stock_checkout_faq; ?>"><?php echo $text_stock_checkout; ?></span></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['stock_checkout'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[stock_checkout]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['stock_checkout'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['stock_checkout'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[stock_checkout]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['stock_checkout'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_redirect_from_cart_to_module; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['redirect_from_cart'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[redirect_from_cart]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['redirect_from_cart'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['redirect_from_cart'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[redirect_from_cart]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['redirect_from_cart'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" data-placement="right" title="<?php echo $text_allow_users_enter_second_address_faq; ?>"><?php echo $text_allow_users_enter_second_address; ?></span></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['allow_second_address'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_second_address]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['allow_second_address'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['allow_second_address'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_second_address]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['allow_second_address'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_allow_custom_fields; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['allow_custom_fields'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_custom_fields]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['allow_custom_fields'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['allow_custom_fields'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_custom_fields]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['allow_custom_fields'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_show_in_stores; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php $row = 0; foreach ($all_stores as $store) { ?>
                    <div class="checkbox">
                      <label>
                        <input type="checkbox" name="<?php echo $_module_name; ?>_form_data[stores][<?php echo $row; ?>]" value="<?php echo $store['store_id']; ?>" <?php echo (isset($form_data['stores']) && in_array($store['store_id'], $form_data['stores'])) ? 'checked' : ''; ?> /> <?php echo $store['name']; ?>
                      </label>
                    </div>
                    <?php $row++; ?>
                    <?php } ?>
                  </div>
                  <a class="btn btn-primary btn-sm" onclick="$(this).parent().find('input[type=checkbox]').attr('checked', true);"><?php echo $text_select_all; ?></a>
                  <a class="btn btn-warning btn-sm" onclick="$(this).parent().find(':checkbox').removeAttr('checked');"><?php echo $text_unselect_all; ?></a>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_customer_groups; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php $row = 0; foreach ($all_customer_groups as $customer_group) { ?>
                    <div class="checkbox">
                      <label>
                        <input
                          type="checkbox"
                          name="<?php echo $_module_name; ?>_form_data[customer_groups][<?php echo $row; ?>]"
                          value="<?php echo $customer_group['customer_group_id']; ?>" <?php echo (!empty($form_data['customer_groups'][$row])) ? 'checked' : ''; ?>
                        /> <?php echo $customer_group['name']; ?>
                      </label>
                    </div>
                    <?php $row++; ?>
                    <?php } ?>
                  </div>
                  <a class="btn btn-primary btn-sm" onclick="$(this).parent().find('input[type=checkbox]').attr('checked', true);"><?php echo $text_select_all; ?></a>
                  <a class="btn btn-warning btn-sm" onclick="$(this).parent().find(':checkbox').removeAttr('checked');"><?php echo $text_unselect_all; ?></a>
                </div>
              </div>
            </div>
            <!-- TAB Layout setting -->
            <div class="tab-pane" id="layout-block">
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_show_main_product_image; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['hide_main_img'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[hide_main_img]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['hide_main_img'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['hide_main_img'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[hide_main_img]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['hide_main_img'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_dementions_of_main_image; ?></label>
                <div class="col-sm-10">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-arrows-h"></i></span>
                    <input value="<?php echo $form_data['main_image_width']; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[main_image_width]" class="form-control" />
                  </div>
                  <?php if ($error_main_image_width) { ?>
                    <div class="text-danger"><?php echo $error_main_image_width; ?></div>
                  <?php } ?>
                  <div class="special_margin"></div>
                  <div class="input-group">
                    <span class="input-group-addon">&nbsp;<i class="fa fa-arrows-v"></i>&nbsp;</span>
                    <input value="<?php echo $form_data['main_image_height']; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[main_image_height]" class="form-control" />
                  </div>
                  <?php if ($error_main_image_height) { ?>
                    <div class="text-danger"><?php echo $error_main_image_height; ?></div>
                  <?php } ?>
                  <div class="special_margin"></div>
                  <h5><?php echo $text_warning_dementions_of_main_image; ?></h5>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_show_cancel_button; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['cancel_button'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[cancel_button]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['cancel_button'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_show_position_button_top; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['cancel_button'] == 2 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[cancel_button]"
                        value="2"
                        autocomplete="off"
                        <?php echo $form_data['cancel_button'] == 2 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_show_position_button_top_and_botton; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['cancel_button'] == 3 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[cancel_button]"
                        value="3"
                        autocomplete="off"
                        <?php echo $form_data['cancel_button'] == 3 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_show_position_button_bottom; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['cancel_button'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[cancel_button]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['cancel_button'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_show_checkout_button; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['checkout_button'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[checkout_button]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['checkout_button'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_show_position_button_top_and_botton; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['checkout_button'] == 2 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[checkout_button]"
                        value="2"
                        autocomplete="off"
                        <?php echo $form_data['checkout_button'] == 2 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_show_position_button_bottom; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_show_additional_text; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['show_additional_text'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[show_additional_text]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['show_additional_text'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_show_position_button_top; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['show_additional_text'] == 2 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[show_additional_text]"
                        value="2"
                        autocomplete="off"
                        <?php echo $form_data['show_additional_text'] == 2 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_show_position_button_bottom; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['show_additional_text'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[show_additional_text]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['show_additional_text'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" data-placement="right" title="<?php echo $text_allow_newsletter_subscribe_faq; ?>"><?php echo $text_allow_newsletter_subscribe; ?></span></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['allow_newsletter_subscribe'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_newsletter_subscribe]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['allow_newsletter_subscribe'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['allow_newsletter_subscribe'] == 2 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_newsletter_subscribe]"
                        value="2"
                        autocomplete="off"
                        <?php echo $form_data['allow_newsletter_subscribe'] == 2 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes_and_required; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['allow_newsletter_subscribe'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_newsletter_subscribe]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['allow_newsletter_subscribe'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_show_weight_cart; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['show_weight_cart'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[show_weight_cart]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['show_weight_cart'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['show_weight_cart'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[show_weight_cart]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['show_weight_cart'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_redirect_to_success_page; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['redirect_to_success_page'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[redirect_to_success_page]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['redirect_to_success_page'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_default_success_page; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['redirect_to_success_page'] == 2 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[redirect_to_success_page]"
                        value="2"
                        autocomplete="off"
                        <?php echo $form_data['redirect_to_success_page'] == 2 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_custom_success_page; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_show_checkout_blocks; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 100%;">
                    <?php foreach ($checkout_blocks as $block) { ?>
                    <div class="checkbox">
                      <label>
                        <input type="checkbox" name="<?php echo $_module_name; ?>_form_data[checkout_blocks][]" value="<?php echo $block['value']; ?>" <?php echo (isset($form_data['checkout_blocks']) && in_array($block['value'], $form_data['checkout_blocks'])) ? 'checked' : ''; ?> /> <?php echo $block['name']; ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                  <a class="btn btn-primary btn-sm" onclick="$(this).parent().find('input[type=checkbox]').attr('checked', true);"><?php echo $text_select_all; ?></a>
                  <a class="btn btn-warning btn-sm" onclick="$(this).parent().find(':checkbox').removeAttr('checked');"><?php echo $text_unselect_all; ?></a>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_display_payment_type; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['display_payment_type'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[display_payment_type]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['display_payment_type'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_like_radio; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['display_payment_type'] == 2 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[display_payment_type]"
                        value="2"
                        autocomplete="off"
                        <?php echo $form_data['display_payment_type'] == 2 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_like_select; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_select_payments; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php $row = 0; foreach ($payments as $payment) { ?>
                    <?php if (!empty($payment['code'])) { ?>
                    <div class="checkbox">
                      <label>
                        <input
                          type="checkbox"
                          class="payment_code_array"
                          name="<?php echo $_module_name; ?>_form_data[payment_code_array][<?php echo $row; ?>]"
                          value="<?php echo $payment['code']; ?>" <?php echo (!empty($form_data['payment_code_array'][$row])) ? 'checked' : ''; ?>
                        /> <?php echo $payment['name']; ?>
                      </label>
                      <div style="float:right;">
                        <input
                          type="checkbox"
                          name="<?php echo $_module_name; ?>_form_data[transfer_payments][<?php echo $row; ?>]"
                          value="<?php echo $payment['code']; ?>" <?php echo (!empty($form_data['transfer_payments'][$row])) ? 'checked' : ''; ?>
                          data-placement="top"
                          data-toggle="tooltip"
                          title="<?php echo $transfer_payments_faq; ?>"
                        />
                      </div>
                    </div>
                    <?php } ?>
                    <?php $row++; ?>
                    <?php } ?>
                  </div>
                  <a class="btn btn-primary btn-sm" onclick="$(this).parent().find('input[name*=payment_code_array]').attr('checked', true);"><?php echo $text_select_all; ?></a>
                  <a class="btn btn-warning btn-sm" onclick="$(this).parent().find('input[name*=payment_code_array]').removeAttr('checked');"><?php echo $text_unselect_all; ?></a>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_display_shipping_type; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['display_shipping_type'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[display_shipping_type]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['display_shipping_type'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_like_radio; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['display_shipping_type'] == 2 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[display_shipping_type]"
                        value="2"
                        autocomplete="off"
                        <?php echo $form_data['display_shipping_type'] == 2 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_like_select; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_display_shipping_heading; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['display_shipping_heading'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[display_shipping_heading]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['display_shipping_heading'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['display_shipping_heading'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[display_shipping_heading]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['display_shipping_heading'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_select_shipping; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php $row = 0; foreach ($shippings as $shipping) { ?>
                    <?php if (!empty($shipping['code'])) { ?>
                    <div class="checkbox">
                      <label>
                        <input type="checkbox" name="<?php echo $_module_name; ?>_form_data[shipping_code_array][<?php echo $row; ?>]" value="<?php echo $shipping['code']; ?>" <?php echo (!empty($form_data['shipping_code_array'][$row])) ? 'checked' : ''; ?>  /> <?php echo $shipping['name']; ?>
                      </label>
                    </div>
                    <?php } ?>
                    <?php $row++; ?>
                    <?php } ?>
                  </div>
                  <a class="btn btn-primary btn-sm" onclick="$(this).parent().find('input[type=checkbox]').attr('checked', true);"><?php echo $text_select_all; ?></a>
                  <a class="btn btn-warning btn-sm" onclick="$(this).parent().find(':checkbox').removeAttr('checked');"><?php echo $text_unselect_all; ?></a>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_display_customer_groups; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['display_customer_groups_type'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[display_customer_groups_type]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['display_customer_groups_type'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_like_radio; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['display_customer_groups_type'] == 2 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[display_customer_groups_type]"
                        value="2"
                        autocomplete="off"
                        <?php echo $form_data['display_customer_groups_type'] == 2 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_like_select; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_select_customer_groups; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php $row = 0; foreach ($all_customer_groups as $customer_group) { ?>
                    <div class="checkbox">
                      <label>
                        <input
                          type="checkbox"
                          name="<?php echo $_module_name; ?>_form_data[customer_group_id_array][<?php echo $row; ?>]"
                          value="<?php echo $customer_group['customer_group_id']; ?>" <?php echo (!empty($form_data['customer_group_id_array'][$row])) ? 'checked' : ''; ?>
                        /> <?php echo $customer_group['name']; ?>
                      </label>
                    </div>
                    <?php $row++; ?>
                    <?php } ?>
                  </div>
                  <a class="btn btn-primary btn-sm" onclick="$(this).parent().find('input[type=checkbox]').attr('checked', true);"><?php echo $text_select_all; ?></a>
                  <a class="btn btn-warning btn-sm" onclick="$(this).parent().find(':checkbox').removeAttr('checked');"><?php echo $text_unselect_all; ?></a>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_select_country; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php $row = 0; foreach ($countries_data as $country) { ?>
                    <div class="checkbox">
                      <label>
                        <input type="checkbox" name="<?php echo $_module_name; ?>_form_data[countries][<?php echo $row; ?>]" value="<?php echo $country['country_id']; ?>" <?php echo (!empty($form_data['countries'][$row])) ? 'checked' : ''; ?> /> <?php echo $country['name']; ?>
                      </label>
                      <div style="float:right;">
                        <input
                          type="radio"
                          name="<?php echo $_module_name; ?>_form_data[countries_default]"
                          value="<?php echo $country['country_id']; ?>"
                          <?php echo (isset($form_data['countries_default']) && $form_data['countries_default'] == $country['country_id']) ? 'checked' : ''; ?>
                          data-placement="left"
                          data-toggle="tooltip"
                          title="<?php echo $text_countries_default_faq; ?>"
                        />
                      </div>
                    </div>
                    <?php $row++; ?>
                    <?php } ?>
                  </div>
                  <a class="btn btn-primary btn-sm" onclick="$(this).parent().find('input[type=checkbox]').attr('checked', true);"><?php echo $text_select_all; ?></a>
                  <a class="btn btn-warning btn-sm" onclick="$(this).parent().find(':checkbox').removeAttr('checked');"><?php echo $text_unselect_all; ?></a>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $text_select_checkout_terms_faq; ?>"><?php echo $text_select_checkout_terms; ?></span></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php foreach ($informations as $information) { ?>
                    <div class="radio">
                      <label>
                        <input type="radio" name="<?php echo $_module_name; ?>_form_data[require_checkout_terms]" value="<?php echo $information['information_id']; ?>" <?php echo (isset($form_data['require_checkout_terms']) && $form_data['require_checkout_terms'] == $information['information_id']) ? 'checked' : ''; ?> /> <?php echo $information['title']; ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                  <a class="btn btn-warning btn-sm" onclick="$(this).parent().find(':radio').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $text_select_payment_terms_faq; ?>"><?php echo $text_select_payment_terms; ?></span></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php foreach ($informations as $information) { ?>
                    <div class="radio">
                      <label>
                        <input type="radio" name="<?php echo $_module_name; ?>_form_data[require_payment_terms]" value="<?php echo $information['information_id']; ?>" <?php echo (isset($form_data['require_payment_terms']) && $form_data['require_payment_terms'] == $information['information_id']) ? 'checked' : ''; ?> /> <?php echo $information['title']; ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                  <a class="btn btn-warning btn-sm" onclick="$(this).parent().find(':radio').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $text_select_shipping_terms_faq; ?>"><?php echo $text_select_shipping_terms; ?></span></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php foreach ($informations as $information) { ?>
                    <div class="radio">
                      <label>
                        <input type="radio" name="<?php echo $_module_name; ?>_form_data[require_shipping_terms]" value="<?php echo $information['information_id']; ?>" <?php echo (isset($form_data['require_shipping_terms']) && $form_data['require_shipping_terms'] == $information['information_id']) ? 'checked' : ''; ?> /> <?php echo $information['title']; ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                  <a class="btn btn-warning btn-sm" onclick="$(this).parent().find(':radio').attr('checked', false);"><?php echo $text_unselect_all; ?></a>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" data-placement="top" title="<?php echo $text_choose_gift_coupon_faq; ?>"><?php echo $text_choose_gift_coupon; ?></span></label>
                <div class="col-sm-10">
                  <select name="<?php echo $_module_name; ?>_form_data[gift_coupon]" class="form-control">
                    <option value=""><?php echo $text_make_a_choice; ?></option>
                    <?php foreach ($all_coupons as $coupon) { ?>
                      <?php if (isset($form_data['gift_coupon']) && $coupon['coupon_id'] == $form_data['gift_coupon']) { ?>
                        <option value="<?php echo $coupon['coupon_id']; ?>" selected="selected"><?php echo $coupon['name']; ?></option>
                      <?php } else { ?>
                        <option value="<?php echo $coupon['coupon_id']; ?>"><?php echo $coupon['name']; ?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
            </div>
            <!-- TAB Language setting -->
            <div class="tab-pane" id="language-block">
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $text_module_heading; ?></label>
                <div class="col-sm-10">
                  <ul class="nav nav-tabs" id="module_heading">
                    <?php foreach ($languages as $language) { ?>
                      <li>
                        <a href="#tab-module_heading-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                      </li>
                    <?php } ?>
                  </ul>
                  <div class="tab-content">
                  <?php foreach ($languages as $language) { ?>
                    <div class="tab-pane" id="tab-module_heading-language<?php echo $language['language_id']; ?>">
                      <input
                        type="text"
                        name="<?php echo $_module_name; ?>_text_data[<?php echo $language['code']; ?>][heading]"
                        value="<?php echo (!empty($text_data[$language['code']]['heading'])) ? $text_data[$language['code']]['heading'] : ''; ?>"
                        class="form-control"
                      />
                      <?php if (isset($error_heading[$language['code']])) { ?>
                        <div class="text-danger"><?php echo $error_heading[$language['code']]; ?></div>
                      <?php } ?>
                    </div>
                  <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $text_module_checkout_button; ?></label>
                <div class="col-sm-10">
                  <ul class="nav nav-tabs" id="module_checkout_button">
                    <?php foreach ($languages as $language) { ?>
                      <li>
                        <a href="#tab-module_checkout_button-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                      </li>
                    <?php } ?>
                  </ul>
                  <div class="tab-content">
                  <?php foreach ($languages as $language) { ?>
                    <div class="tab-pane" id="tab-module_checkout_button-language<?php echo $language['language_id']; ?>">
                      <input
                        type="text"
                        name="<?php echo $_module_name; ?>_text_data[<?php echo $language['code']; ?>][checkout_button]"
                        value="<?php echo (!empty($text_data[$language['code']]['checkout_button'])) ? $text_data[$language['code']]['checkout_button'] : ''; ?>"
                        class="form-control"
                      />
                      <?php if (isset($error_checkout_button[$language['code']])) { ?>
                        <div class="text-danger"><?php echo $error_checkout_button[$language['code']]; ?></div>
                      <?php } ?>
                    </div>
                  <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $text_module_continue_button; ?></label>
                <div class="col-sm-10">
                  <ul class="nav nav-tabs" id="module_continue_button">
                    <?php foreach ($languages as $language) { ?>
                      <li>
                        <a href="#tab-module_continue_button-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                      </li>
                    <?php } ?>
                  </ul>
                  <div class="tab-content">
                  <?php foreach ($languages as $language) { ?>
                    <div class="tab-pane" id="tab-module_continue_button-language<?php echo $language['language_id']; ?>">
                      <input
                        type="text"
                        name="<?php echo $_module_name; ?>_text_data[<?php echo $language['code']; ?>][continue_button]"
                        value="<?php echo (!empty($text_data[$language['code']]['continue_button'])) ? $text_data[$language['code']]['continue_button'] : ''; ?>"
                        class="form-control"
                      />
                      <?php if (isset($error_continue_button[$language['code']])) { ?>
                        <div class="text-danger"><?php echo $error_continue_button[$language['code']]; ?></div>
                      <?php } ?>
                    </div>
                  <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" data-placement="right" title="<?php echo $text_custom_success_page; ?>"><?php echo $text_result_empty; ?></span></label>
                <div class="col-sm-10">
                  <ul class="nav nav-tabs" id="empty_text">
                    <?php foreach ($languages as $language) { ?>
                      <li>
                        <a href="#tab-empty_text-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                      </li>
                    <?php } ?>
                  </ul>
                  <div class="tab-content">
                  <?php foreach ($languages as $language) { ?>
                    <div class="tab-pane" id="tab-empty_text-language<?php echo $language['language_id']; ?>">
                      <textarea
                        id="empty_text_<?php echo $language['language_id']; ?>"
                        class="form-control"
                        style="height:auto;resize:vertical;"
                        rows="3"
                        name="<?php echo $_module_name; ?>_text_data[<?php echo $language['code']; ?>][empty_text]"><?php echo (!empty($text_data[$language['code']]['empty_text'])) ? $text_data[$language['code']]['empty_text'] : '';?></textarea>
                    </div>
                  <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" data-placement="right" title="<?php echo $text_message_additional_faq; ?>"><?php echo $text_message_additional; ?></span></label>
                <div class="col-sm-10">
                  <ul class="nav nav-tabs" id="additional">
                    <?php foreach ($languages as $language) { ?>
                      <li>
                        <a href="#tab-additional-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                      </li>
                    <?php } ?>
                  </ul>
                  <div class="tab-content">
                  <?php foreach ($languages as $language) { ?>
                    <div class="tab-pane" id="tab-additional-language<?php echo $language['language_id']; ?>">
                      <textarea
                        id="additional_<?php echo $language['language_id']; ?>"
                        class="form-control"
                        style="height:auto;resize:vertical;"
                        rows="3"
                        name="<?php echo $_module_name; ?>_text_data[<?php echo $language['code']; ?>][additional]"><?php echo (!empty($text_data[$language['code']]['additional'])) ? $text_data[$language['code']]['additional'] : '';?></textarea>
                    </div>
                  <?php } ?>
                  </div>
                </div>
              </div>
            </div>
            <!-- TAB Custom success -->
            <div class="tab-pane" id="custom-success-block">
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $text_custom_sp_heading; ?></label>
                <div class="col-sm-8">
                  <ul class="nav nav-tabs" id="custom-success-page-heading">
                    <?php foreach ($languages as $language) { ?>
                      <li>
                        <a href="#tab-custom-success-page-heading-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                      </li>
                    <?php } ?>
                  </ul>
                  <div class="tab-content">
                  <?php foreach ($languages as $language) { ?>
                    <div class="tab-pane" id="tab-custom-success-page-heading-language<?php echo $language['language_id']; ?>">
                      <input
                        type="text"
                        name="<?php echo $_module_name; ?>_sp_text_data[<?php echo $language['code']; ?>][heading]"
                        value="<?php echo (!empty($sp_text_data[$language['code']]['heading'])) ? $sp_text_data[$language['code']]['heading'] : ''; ?>"
                        class="form-control"
                      />
                      <?php if (isset($error_sp_heading[$language['code']])) { ?>
                        <div class="text-danger"><?php echo $error_sp_heading[$language['code']]; ?></div>
                      <?php } ?>
                    </div>
                  <?php } ?>
                  </div>
                </div>
                <div class="col-sm-2">
                  <div class="special_margin"></div>
                  <?php echo $text_custom_sp_heading_short_tags; ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $text_recommended_products_heading; ?></label>
                <div class="col-sm-8">
                  <ul class="nav nav-tabs" id="recommended-products-heading">
                    <?php foreach ($languages as $language) { ?>
                      <li>
                        <a href="#tab-recommended-products-heading-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                      </li>
                    <?php } ?>
                  </ul>
                  <div class="tab-content">
                  <?php foreach ($languages as $language) { ?>
                    <div class="tab-pane" id="tab-recommended-products-heading-language<?php echo $language['language_id']; ?>">
                      <input
                        type="text"
                        name="<?php echo $_module_name; ?>_sp_text_data[<?php echo $language['code']; ?>][recommended_products_heading]"
                        value="<?php echo (!empty($sp_text_data[$language['code']]['recommended_products_heading'])) ? $sp_text_data[$language['code']]['recommended_products_heading'] : ''; ?>"
                        class="form-control"
                      />
                      <?php if (isset($error_sp_recommended_products_heading[$language['code']])) { ?>
                        <div class="text-danger"><?php echo $error_sp_recommended_products_heading[$language['code']]; ?></div>
                      <?php } ?>
                    </div>
                  <?php } ?>
                  </div>
                </div>
                <div class="col-sm-2">
                  <div class="special_margin"></div>
                  <?php echo $text_recommended_products_heading_short_tags; ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" data-placement="right" title="<?php echo $text_custom_succes_text_faq; ?>"><?php echo $text_custom_succes_text; ?></span></label>
                <div class="col-sm-8">
                  <ul class="nav nav-tabs" id="custom-success-page-massage">
                    <?php foreach ($languages as $language) { ?>
                      <li>
                        <a href="#tab-custom-success-page-massage-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                      </li>
                    <?php } ?>
                  </ul>
                  <div class="tab-content">
                  <?php foreach ($languages as $language) { ?>
                    <div class="tab-pane" id="tab-custom-success-page-massage-language<?php echo $language['language_id']; ?>">
                      <textarea
                        id="custom-success-page-massage_<?php echo $language['language_id']; ?>"
                        class="form-control"
                        name="<?php echo $_module_name; ?>_sp_text_data[<?php echo $language['code']; ?>][success_text]"><?php echo (!empty($sp_text_data[$language['code']]['success_text'])) ? $sp_text_data[$language['code']]['success_text'] : '';?></textarea>
                        <?php if (isset($error_sp_success_text[$language['code']])) { ?>
                          <div class="text-danger"><?php echo $error_sp_success_text[$language['code']]; ?></div>
                        <?php } ?>
                    </div>
                  <?php } ?>
                  </div>
                </div>
                <div class="col-sm-2">
                  <div class="special_margin"></div>
                  <?php echo $text_custom_succes_text_short_tags; ?>
                </div>
              </div>
            </div>
            <!-- TAB Fields setting -->
            <div class="tab-pane" id="fields-block">
              <div class="row">
                <div class="col-sm-2">
                  <ul class="nav nav-pills nav-stacked" id="module">
                    <?php $field_row = 1; ?>
                    <?php foreach ($field_data as $field) { ?>
                    <li>
                      <input type="hidden" style="display:none;" name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][sort_order]" />
                      <input type="hidden" style="display:none;" name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][name]" value="field_<?php echo $field_row; ?>" />
                      <a href="#tab-module<?php echo $field_row; ?>" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$('a[href=\'#tab-module<?php echo $field_row; ?>\']').parent().remove(); $('#tab-module<?php echo $field_row; ?>').remove(); $('#module a:first').tab('show');"></i> <?php echo $text_tab_field; ?> <?php echo '№'. $field_row; ?>
                      <span class="field_title">(<?php echo (isset($field['title'][$language['code']])) ? $field['title'][$language['code']] : ''; ?>)</span>
                      </a>
                    </li>
                    <?php $field_row++; ?>
                    <?php } ?>
                    <li id="module-add">
                      <a onclick="addField();" class="btn btn-success"><i class="fa fa-plus-circle"></i> <?php echo $button_add_field; ?></a>
                    </li>
                  </ul>
                </div>
                <div class="col-md-10">
                  <div class="tab-content">
                    <?php $field_row = 1; ?>
                    <?php foreach ($field_data as $field) { ?>
                      <div class="tab-pane" id="tab-module<?php echo $field_row; ?>">
                        <div class="form-group">
                          <label class="col-sm-2 control-label" for="input-activate<?php echo $field_row; ?>"><span data-toggle="tooltip" data-placement="right" title="<?php echo $text_activate_field_faq; ?>"><?php echo $text_activate_field; ?></span></label>
                          <div class="col-sm-10">
                            <select name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][activate]" class="form-control" id="input-activate<?php echo $field_row; ?>">
                              <?php if ($field['activate'] == 1) { ?>
                                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                                <option value="2"><?php echo $text_yes_and_hide; ?></option>
                                <option value="0"><?php echo $text_no; ?></option>
                              <?php } elseif ($field['activate'] == 2) { ?>
                                <option value="1"><?php echo $text_yes; ?></option>
                                <option value="2" selected="selected"><?php echo $text_yes_and_hide; ?></option>
                                <option value="0"><?php echo $text_no; ?></option>
                              <?php } else { ?>
                                <option value="1"><?php echo $text_yes; ?></option>
                                <option value="2"><?php echo $text_yes_and_hide; ?></option>
                                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                              <?php } ?>
                            </select>
                          </div>
                        </div>
                        <div class="form-group required">
                          <label class="col-sm-2 control-label" for="input-title<?php echo $field_row; ?>"><?php echo $text_heading_field; ?></label>
                          <div class="col-sm-10">
                            <ul class="nav nav-tabs" id="language<?php echo $field_row; ?>">
                              <?php foreach ($languages as $language) { ?>
                                <li>
                                  <a href="#tab-module<?php echo $field_row; ?>-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                                </li>
                              <?php } ?>
                            </ul>
                            <div class="tab-content">
                            <?php foreach ($languages as $language) { ?>
                              <div class="tab-pane" id="tab-module<?php echo $field_row; ?>-language<?php echo $language['language_id']; ?>">
                                <input
                                type="text"
                                name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][title][<?php echo $language['code']; ?>]"
                                value="<?php echo (isset($field['title'][$language['code']])) ? $field['title'][$language['code']] : ''; ?>"
                                class="form-control"
                                id="input-title<?php echo $field_row; ?>"
                                />
                                <?php if (isset($error_data_fields[$field_row]['title'][$language['code']])) { ?>
                                  <div class="text-danger"><?php echo $error_data_fields[$field_row]['title'][$language['code']]; ?></div>
                                <?php } ?>
                              </div>
                            <?php } ?>
                            </div>
                          </div>
                        </div>
                        <div class="form-group required">
                          <label class="col-sm-2 control-label" for="input-view<?php echo $field_row; ?>"><?php echo $text_assign_functionality; ?></label>
                          <div class="col-sm-10">
                            <select name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][view]" class="form-control" id="input-view<?php echo $field_row; ?>">
                              <option value="0"><?php echo $text_make_a_choice; ?></option>
                              <?php foreach ($field_view_data as $key => $view) { ?>
                              <option value="<?php echo $key; ?>" <?php echo ($field['view'] == $key) ? 'selected="selected"' : ''; ?> ><?php echo $view; ?></option>
                              <?php } ?>
                            </select>
                            <?php if (isset($error_data_fields[$field_row]['view'])) { ?>
                              <div class="text-danger"><?php echo $error_data_fields[$field_row]['view']; ?></div>
                            <?php } ?>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label"><?php echo $text_apply_to_customer_groups; ?></label>
                          <div class="col-sm-10"><div class="well well-sm" style="height: 150px; overflow: auto;">
                              <?php foreach ($all_customer_groups as $customer_group) { ?>
                              <div class="checkbox">
                                <label>
                                  <input
                                    type="checkbox"
                                    name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][customer_groups][]"
                                    value="<?php echo $customer_group['customer_group_id']; ?>" <?php echo (isset($field['customer_groups']) && in_array($customer_group['customer_group_id'], $field['customer_groups'])) ? 'checked' : ''; ?>
                                  /> <?php echo $customer_group['name']; ?>
                                </label>
                              </div>
                              <?php } ?>
                            </div>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label"><?php echo $text_apply_address_block; ?></label>
                          <div class="col-sm-10"><div class="well well-sm" style="height: 150px; overflow: auto;">
                              <div class="checkbox">
                                <label>
                                  <input
                                    type="checkbox"
                                    name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][address_blocks][]"
                                    value="payment" <?php echo (isset($field['address_blocks']) && in_array("payment", $field['address_blocks'])) ? 'checked' : ''; ?>
                                  /> <?php echo $text_payment_address; ?>
                                </label>
                              </div>
                              <div class="checkbox">
                                <label>
                                  <input
                                    type="checkbox"
                                    name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][address_blocks][]"
                                    value="shipping" <?php echo (isset($field['address_blocks']) && in_array("shipping", $field['address_blocks'])) ? 'checked' : ''; ?>
                                  /> <?php echo $text_shipping_address; ?>
                                </label>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label" for="input-check<?php echo $field_row; ?>"><?php echo $text_check_type; ?></label>
                          <div class="col-sm-10">
                            <select name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][check]" class="form-control" id="input-check<?php echo $field_row; ?>">
                              <option value="0" <?php echo $field['check'] == 0 ? 'selected="selected"' : ''; ?> ><?php echo $text_validation_type_1; ?></option>
                              <option value="1" <?php echo $field['check'] == 1 ? 'selected="selected"' : ''; ?> ><?php echo $text_validation_type_2; ?></option>
                              <option value="2" <?php echo $field['check'] == 2 ? 'selected="selected"' : ''; ?> ><?php echo $text_validation_type_3; ?></option>
                              <option value="3" <?php echo $field['check'] == 3 ? 'selected="selected"' : ''; ?> ><?php echo $text_validation_type_4; ?></option>
                            </select>
                            <div class="input-group" style="<?php echo $field['check'] == 2 ? 'display:table;margin-top:15px;' : 'display:none;margin-top:15px;'; ?>">
                              <span class="input-group-addon"><i class="fa fa-filter"></i></span>
                              <input type="text" placeholder="<?php echo $text_validation_type_3_ph; ?>" name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][check_rule]" value="<?php echo $field['check_rule']; ?>" class="form-control" />
                            </div>
                            <div class="input-group" style="<?php echo $field['check'] == 3 ? 'display:table;margin-top:15px;' : 'display:none;margin-top:15px;'; ?>">
                              <span class="input-group-addon"><i class="fa fa-chevron-right"></i></span>
                              <input type="text" placeholder="<?php echo $text_validation_type_4_1_ph; ?>" name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][check_min]" value="<?php echo $field['check_min']; ?>" class="form-control" />
                            </div>
                            <div class="input-group" style="<?php echo $field['check'] == 3 ? 'display:table;margin-top:15px;' : 'display:none;margin-top:15px;'; ?>">
                              <span class="input-group-addon"><i class="fa fa-chevron-left"></i></span>
                              <input type="text" placeholder="<?php echo $text_validation_type_4_2_ph; ?>" name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][check_max]" value="<?php echo $field['check_max']; ?>" class="form-control" />
                            </div>
                          </div>
                        </div>
                        <div class="form-group" style="<?php echo $field['view'] == 'telephone' ? 'display:block;' : 'display:none;'; ?>" id="field-mask">
                          <label class="col-sm-2 control-label" for="input-mask<?php echo $field_row; ?>"><span data-toggle="tooltip" title="<?php echo $text_mask_faq; ?>"><?php echo $text_mask; ?></span></label>
                          <div class="col-sm-10">
                            <div class="input-group">
                              <span class="input-group-addon"><i class="fa fa-pencil-square-o"></i></span>
                              <input value="<?php echo $field['mask']; ?>" type="text" name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][mask]" class="form-control" placeholder="<?php echo $text_mask_ph; ?>" id="input-mask<?php echo $field_row; ?>" />
                            </div>
                          </div>
                        </div>
                        <div class="form-group required">
                          <label class="col-sm-2 control-label" for="input-error_text<?php echo $field_row; ?>"><?php echo $text_error_text; ?></label>
                          <div class="col-sm-10">
                            <ul class="nav nav-tabs" id="language<?php echo $field_row; ?>">
                              <?php foreach ($languages as $language) { ?>
                                <li>
                                  <a href="#tab-module2<?php echo $field_row; ?>-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                                </li>
                              <?php } ?>
                            </ul>
                            <div class="tab-content">
                            <?php foreach ($languages as $language) { ?>
                              <div class="tab-pane" id="tab-module2<?php echo $field_row; ?>-language<?php echo $language['language_id']; ?>">
                                <input
                                type="text"
                                name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][error_text][<?php echo $language['code']; ?>]"
                                value="<?php echo (isset($field['error_text'][$language['code']])) ? $field['error_text'][$language['code']] : ''; ?>"
                                class="form-control"
                                id="input-error_text<?php echo $field_row; ?>"
                                />
                                <?php if (isset($error_data_fields[$field_row]['error_text'][$language['code']])) { ?>
                                  <div class="text-danger"><?php echo $error_data_fields[$field_row]['error_text'][$language['code']]; ?></div>
                                <?php } ?>
                              </div>
                            <?php } ?>
                            </div>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label" for="input-placeholder_text<?php echo $field_row; ?>"><?php echo $text_placeholder_text; ?></label>
                          <div class="col-sm-10">
                            <ul class="nav nav-tabs" id="language<?php echo $field_row; ?>">
                              <?php foreach ($languages as $language) { ?>
                                <li>
                                  <a href="#tab-module3<?php echo $field_row; ?>-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                                </li>
                              <?php } ?>
                            </ul>
                            <div class="tab-content">
                            <?php foreach ($languages as $language) { ?>
                              <div class="tab-pane" id="tab-module3<?php echo $field_row; ?>-language<?php echo $language['language_id']; ?>">
                                <input
                                type="text"
                                name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][placeholder_text][<?php echo $language['code']; ?>]"
                                value="<?php echo (isset($field['placeholder_text'][$language['code']])) ? $field['placeholder_text'][$language['code']] : ''; ?>"
                                class="form-control"
                                id="input-placeholder_text<?php echo $field_row; ?>"
                                />
                              </div>
                            <?php } ?>
                            </div>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label" for="input-css_id<?php echo $field_row; ?>"><?php echo $text_css_id; ?></label>
                          <div class="col-sm-10">
                            <div class="input-group">
                              <span class="input-group-addon">#</span>
                              <input value="<?php echo $field['css_id']; ?>" type="text" name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][css_id]" class="form-control" placeholder="<?php echo $text_css_id_ph; ?>" id="input-css_id<?php echo $field_row; ?>" />
                            </div>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label" for="input-css_class<?php echo $field_row; ?>"><?php echo $text_css_class; ?></label>
                          <div class="col-sm-10">
                            <div class="input-group">
                              <span class="input-group-addon">&#8226;</span>
                              <input value="<?php echo $field['css_class']; ?>" type="text" name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][css_class]" class="form-control" placeholder="<?php echo $text_css_class_ph; ?>" id="input-css_class<?php echo $field_row; ?>" />
                            </div>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label"><?php echo $text_position; ?></label>
                          <div class="col-sm-10">
                            <div class="btn-group" data-toggle="buttons">
                              <label class="btn btn-success <?php echo $field['position'] == 1 ? 'active' : ''; ?>">
                                <input type="radio"
                                  name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][position]"
                                  value="1"
                                  autocomplete="off"
                                  <?php echo $field['position'] == 1 ? 'checked="checked"' : ''; ?>
                                /><?php echo $text_left_side; ?>
                              </label>
                              <label class="btn btn-success <?php echo $field['position'] == 3 ? 'active' : ''; ?>">
                                <input type="radio"
                                  name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][position]"
                                  value="3"
                                  autocomplete="off"
                                  <?php echo $field['position'] == 3 ? 'checked="checked"' : ''; ?>
                                /><?php echo $text_center; ?>
                              </label>
                              <label class="btn btn-success <?php echo $field['position'] == 2 ? 'active' : ''; ?>">
                                <input type="radio"
                                  name="<?php echo $_module_name; ?>_field_data[<?php echo $field_row; ?>][position]"
                                  value="2"
                                  autocomplete="off"
                                  <?php echo $field['position'] == 2 ? 'checked="checked"' : ''; ?>
                                /><?php echo $text_right_side; ?>
                              </label>
                            </div>
                          </div>
                        </div>
                      </div>
                    <?php $field_row++; ?>
                    <?php } ?>
                  </div>
                </div>
              </div>
            </div>
            <!-- TAB Marketing tools -->
            <div class="tab-pane" id="marketing-tools-block">
              <fieldset>
                <legend><?php echo $text_heading_recommended_products; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_show_images_in_table_order; ?></label>
                  <div class="col-sm-10">
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-success <?php echo $sp_form_data['hide_table_img'] == 1 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[hide_table_img]"
                          value="1"
                          autocomplete="off"
                          <?php echo $sp_form_data['hide_table_img'] == 1 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-success <?php echo $sp_form_data['hide_table_img'] == 0 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[hide_table_img]"
                          value="0"
                          autocomplete="off"
                          <?php echo $sp_form_data['hide_table_img'] == 0 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_dementions_of_images_in_table_order; ?></label>
                  <div class="col-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-arrows-h"></i></span>
                      <input value="<?php echo $sp_form_data['table_image_width']; ?>" type="text" name="<?php echo $_module_name; ?>_sp_form_data[table_image_width]" class="form-control" />
                    </div>
                    <div class="special_margin"></div>
                    <div class="input-group">
                      <span class="input-group-addon">&nbsp;<i class="fa fa-arrows-v"></i>&nbsp;</span>
                      <input value="<?php echo $sp_form_data['table_image_height']; ?>" type="text" name="<?php echo $_module_name; ?>_sp_form_data[table_image_height]" class="form-control" />
                    </div>
                    <div class="special_margin"></div>
                    <h5><?php echo $text_warning_dementions_of_main_image; ?></h5>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_show_sub_images; ?></label>
                  <div class="col-sm-10">
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-success <?php echo $sp_form_data['hide_sub_img'] == 1 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[hide_sub_img]"
                          value="1"
                          autocomplete="off"
                          <?php echo $sp_form_data['hide_sub_img'] == 1 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-success <?php echo $sp_form_data['hide_sub_img'] == 0 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[hide_sub_img]"
                          value="0"
                          autocomplete="off"
                          <?php echo $sp_form_data['hide_sub_img'] == 0 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_dementions_of_sub_images; ?></label>
                  <div class="col-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-arrows-h"></i></span>
                      <input value="<?php echo $sp_form_data['sub_images_width']; ?>" type="text" name="<?php echo $_module_name; ?>_sp_form_data[sub_images_width]" class="form-control" />
                    </div>
                    <div class="special_margin"></div>
                    <div class="input-group">
                      <span class="input-group-addon">&nbsp;<i class="fa fa-arrows-v"></i>&nbsp;</span>
                      <input value="<?php echo $sp_form_data['sub_images_height']; ?>" type="text" name="<?php echo $_module_name; ?>_sp_form_data[sub_images_height]" class="form-control" />
                    </div>
                    <div class="special_margin"></div>
                    <h5><?php echo $text_warning_dementions_of_main_image; ?></h5>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_show_button_print; ?></label>
                  <div class="col-sm-10">
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-success <?php echo $sp_form_data['show_button_print'] == 1 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_button_print]"
                          value="1"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_button_print'] == 1 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-success <?php echo $sp_form_data['show_button_print'] == 0 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_button_print]"
                          value="0"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_button_print'] == 0 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_show_button_continue; ?></label>
                  <div class="col-sm-10">
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-success <?php echo $sp_form_data['show_button_continue'] == 1 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_button_continue]"
                          value="1"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_button_continue'] == 1 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-success <?php echo $sp_form_data['show_button_continue'] == 0 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_button_continue]"
                          value="0"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_button_continue'] == 0 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_show_comment; ?></label>
                  <div class="col-sm-10">
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-success <?php echo $sp_form_data['show_comment'] == 1 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_comment]"
                          value="1"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_comment'] == 1 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-success <?php echo $sp_form_data['show_comment'] == 0 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_comment]"
                          value="0"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_comment'] == 0 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_show_table_order_details; ?></label>
                  <div class="col-sm-10">
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-success <?php echo $sp_form_data['show_table_order_details'] == 1 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_table_order_details]"
                          value="1"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_table_order_details'] == 1 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-success <?php echo $sp_form_data['show_table_order_details'] == 0 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_table_order_details]"
                          value="0"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_table_order_details'] == 0 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_show_table_payment_address; ?></label>
                  <div class="col-sm-10">
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-success <?php echo $sp_form_data['show_table_payment_address'] == 1 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_table_payment_address]"
                          value="1"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_table_payment_address'] == 1 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-success <?php echo $sp_form_data['show_table_payment_address'] == 0 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_table_payment_address]"
                          value="0"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_table_payment_address'] == 0 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_show_table_shipping_address; ?></label>
                  <div class="col-sm-10">
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-success <?php echo $sp_form_data['show_table_shipping_address'] == 1 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_table_shipping_address]"
                          value="1"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_table_shipping_address'] == 1 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-success <?php echo $sp_form_data['show_table_shipping_address'] == 0 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_table_shipping_address]"
                          value="0"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_table_shipping_address'] == 0 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_show_table_products; ?></label>
                  <div class="col-sm-10">
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-success <?php echo $sp_form_data['show_table_products'] == 1 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_table_products]"
                          value="1"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_table_products'] == 1 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_yes; ?>
                      </label>
                      <label class="btn btn-success <?php echo $sp_form_data['show_table_products'] == 0 ? 'active' : ''; ?>">
                        <input type="radio"
                          name="<?php echo $_module_name; ?>_sp_form_data[show_table_products]"
                          value="0"
                          autocomplete="off"
                          <?php echo $sp_form_data['show_table_products'] == 0 ? 'checked="checked"' : ''; ?>
                        /><?php echo $text_no; ?>
                      </label>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_sp_custom_css; ?></label>
                  <div class="col-sm-10">
                    <textarea
                     class="form-control"
                     style="height:auto;resize:vertical;"
                     rows="3"
                     name="<?php echo $_module_name; ?>_sp_form_data[custom_css]"><?php echo $sp_form_data['custom_css']; ?></textarea>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label"><?php echo $text_limit_recommended; ?></label>
                  <div class="col-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-arrows-h"></i></span>
                      <input value="<?php echo $sp_form_data['limit_recommended']; ?>" type="text" name="<?php echo $_module_name; ?>_sp_form_data[limit_recommended]" class="form-control" />
                    </div>
                    <?php if ($error_sp_limit_recommended) { ?>
                      <div class="text-danger"><?php echo $error_sp_limit_recommended; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $text_show_recommended_products_from; ?></label>
                  <div class="col-sm-10">
                    <select name="<?php echo $_module_name; ?>_sp_form_data[check]" class="form-control" id="sp_check">
                      <option value="0" <?php echo $sp_form_data['check'] == 0 ? 'selected="selected"' : ''; ?> ><?php echo $text_check_type_1; ?></option>
                      <option value="1" <?php echo $sp_form_data['check'] == 1 ? 'selected="selected"' : ''; ?> ><?php echo $text_check_type_2; ?></option>
                      <option value="2" <?php echo $sp_form_data['check'] == 2 ? 'selected="selected"' : ''; ?> ><?php echo $text_check_type_3; ?></option>
                      <option value="3" <?php echo $sp_form_data['check'] == 3 ? 'selected="selected"' : ''; ?> ><?php echo $text_check_type_4; ?></option>
                    </select>
                  </div>
                </div>
                <div class="form-group" style="<?php echo $sp_form_data['check'] == 1 ? '' : 'display:none;'; ?>" id="rp-categories">
                  <label class="col-sm-2 control-label" for="sp-input-category"><?php echo $text_show_in_categories; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="sp_category" value="" placeholder="<?php echo $text_enter_category; ?>" id="sp-input-category" class="form-control" />
                    <div id="sp-category-filter" class="well well-sm" style="height: 150px; overflow: auto;">
                      <?php foreach ($sp_all_categories as $category) { ?>
                      <div id="sp-category-filter<?php echo $category['category_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $category['name']; ?>
                        <input type="hidden" name="<?php echo $_module_name; ?>_sp_form_data[recommended_categories][]" value="<?php echo $category['category_id']; ?>" />
                      </div>
                      <?php } ?>
                    </div>
                  </div>
                </div>
                <div class="form-group" style="<?php echo $sp_form_data['check'] == 2 ? '' : 'display:none;'; ?>" id="rp-manufacturers">
                  <label class="col-sm-2 control-label" for="sp-input-manufacturer"><?php echo $text_show_in_brands; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="sp_manufacturer" value="" placeholder="<?php echo $text_enter_manufacturer; ?>" id="sp-input-manufacturer" class="form-control" />
                    <div id="sp-manufacturer-filter" class="well well-sm" style="height: 150px; overflow: auto;">
                      <?php foreach ($sp_all_manufacturers as $manufacturer) { ?>
                      <div id="sp-manufacturer-filter<?php echo $manufacturer['manufacturer_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $manufacturer['name']; ?>
                        <input type="hidden" name="<?php echo $_module_name; ?>_sp_form_data[recommended_manufacturers][]" value="<?php echo $manufacturer['manufacturer_id']; ?>" />
                      </div>
                      <?php } ?>
                    </div>
                  </div>
                </div>
                <div class="form-group" style="<?php echo $sp_form_data['check'] == 3 ? '' : 'display:none;'; ?>" id="rp-products">
                  <label class="col-sm-2 control-label" for="sp-input-product"><?php echo $text_show_products; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="sp_product" value="" placeholder="<?php echo $text_enter_product; ?>" id="sp-input-product" class="form-control" />
                    <div id="sp-product-filter" class="well well-sm" style="height: 150px; overflow: auto;">
                      <?php foreach ($sp_all_products as $product) { ?>
                      <div id="sp-product-filter<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
                        <input type="hidden" name="<?php echo $_module_name; ?>_sp_form_data[recommended_products][]" value="<?php echo $product['product_id']; ?>" />
                      </div>
                      <?php } ?>
                    </div>
                  </div>
                </div>
              </fieldset>
            </div>
            <!-- TAB Analytics -->
            <div class="tab-pane" id="analytics-block">
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_allow_google_analytics; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['allow_google_analytics'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_google_analytics]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['allow_google_analytics'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['allow_google_analytics'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_google_analytics]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['allow_google_analytics'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="textarea-google_analytics_script"><?php echo $text_google_analytics_id; ?></label>
                <div class="col-sm-10">
                  <textarea style="resize:vertical;" name="<?php echo $_module_name; ?>_form_data[google_analytics_script]" class="form-control" id="textarea-google_analytics_script"><?php echo $form_data['google_analytics_script']; ?></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_allow_google_event; ?></label>
                <div class="col-sm-10">
                  <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-success <?php echo $form_data['allow_google_event'] == 1 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_google_event]"
                        value="1"
                        autocomplete="off"
                        <?php echo $form_data['allow_google_event'] == 1 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_yes; ?>
                    </label>
                    <label class="btn btn-success <?php echo $form_data['allow_google_event'] == 0 ? 'active' : ''; ?>">
                      <input type="radio"
                        name="<?php echo $_module_name; ?>_form_data[allow_google_event]"
                        value="0"
                        autocomplete="off"
                        <?php echo $form_data['allow_google_event'] == 0 ? 'checked="checked"' : ''; ?>
                      /><?php echo $text_no; ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-google_event_category"><?php echo $text_google_event_category_name; ?></label>
                <div class="col-sm-10">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-pencil"></i></span>
                    <input value="<?php echo $form_data['google_event_category']; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[google_event_category]" class="form-control" id="input-google_event_category" />
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-google_event_action_name"><?php echo $text_google_event_action_name; ?></label>
                <div class="col-sm-10">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-pencil"></i></span>
                    <input value="<?php echo $form_data['google_event_action']; ?>" type="text" name="<?php echo $_module_name; ?>_form_data[google_event_action]" class="form-control" id="input-google_event_action_name" />
                  </div>
                </div>
              </div>
            </div>
            <!-- TAB About -->
            <div class="tab-pane" id="about-block">
              <table class="table">
                <tr>
                  <td><?php echo $text_installed_module_version; ?></td>
                  <td><?php echo $_module_version; ?></td>
                </tr>
                <tr>
                  <td><?php echo $text_installed_module_name; ?></td>
                  <td>&copy; <?php echo str_replace(array('<b>','</b>'), "", $heading_title); ?></td>
                </tr>
                <tr>
                  <td><?php echo $text_author_email; ?></td>
                  <td><a href="mailto:ocdevwizard@gmail.com?subject=<?php echo $text_author_email_subject; ?> [<?php echo str_replace(array('<b>','</b>'), '', $heading_title); ?>]">ocdevwizard@gmail.com</td>
                </tr>
                <tr>
                  <td><?php echo $text_seller_page; ?></td>
                  <td><a href="http://www.opencart.com/index.php?route=extension/extension&filter_username=ocdevwizard">OCdevWizard</td>
                </tr>
              </table>
            </div>
            <!-- TAB Import / Export Block -->
            <div class="tab-pane" id="import-export-block">
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_restore; ?></label>
                <div class="col-sm-5">
                  <input type="file" name="import" style="display:none;" id="load-file" />
                  <div class="input-group">
                    <span class="input-group-btn">
                      <button class="btn btn-primary" type="button" onclick="$('#load-file').click();"><?php echo $text_select_file; ?></button>
                    </span>
                    <input type="text" name="load_file_mask" id="load-file-mask" class="form-control">
                    <span class="input-group-btn">
                      <button id="button-import-file" type="submit" formaction="<?php echo $action_plus; ?>" form="form-one-page-checkout" data-toggle="tooltip" class="btn btn-success" disabled="disabled"><i class="fa fa-download"></i> <?php echo $button_import; ?></button>
                    </span>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_export; ?></label>
                <div class="col-sm-5">
                  <a href="<?php echo $export_settings_button; ?>" class="btn btn-primary"><i class="fa fa-upload"></i> <?php echo $button_export; ?></a>
                </div>
              </div>
            </div>
            <!-- TAB OCdev Products -->
            <div class="tab-pane" id="promo-block">
              <?php if ($ocdev_products) { ?>
              <div class="row">
                <?php foreach ($ocdev_products as $product) { ?>
                <div class="col-xs-6 col-md-2 col-sm-3">
                  <div class="thumbnail" onclick='$("#extension_id-<?php echo $product['extension_id']; ?>").modal();' data-toggle="tooltip" data-placement="bottom" title="Click to Read more..." >
                    <img src="<?php echo $product['img']; ?>" alt="<?php echo $product['title']; ?>" width="100%" />
                  </div>
                  <!-- Modal -->
                  <div class="modal fade" id="extension_id-<?php echo $product['extension_id']; ?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog" style="max-width:450px;">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                          <h4 class="modal-title" id="myModalLabel"><?php echo $product['title']; ?></h4>
                        </div>
                        <div class="modal-body">
                          <div role="tabpanel">
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs" role="tablist">
                              <li class="active"><a href="#modal-info-<?php echo $product['extension_id']; ?>" data-toggle="tab"><i class="fa fa-info-circle"></i> <?php echo $tab_modal_info; ?></a></li>
                              <li><a href="#modal-opencart-version-<?php echo $product['extension_id']; ?>" data-toggle="tab"><i class="fa fa-check-circle"></i> <?php echo $tab_modal_for_opencart; ?></a></li>
                              <li><a href="#modal-features-<?php echo $product['extension_id']; ?>" data-toggle="tab"><i class="fa fa-star"></i> <?php echo $tab_modal_features; ?></a></li>
                            </ul>
                            <!-- Tab panes -->
                            <div class="tab-content">
                              <div class="tab-pane active" id="modal-info-<?php echo $product['extension_id']; ?>">
                                <ul class="list-group">
                                  <li class="list-group-item"><?php echo $text_modal_price; ?> <b class="pull-right"><?php echo $product['price']; ?></b></li>
                                  <li class="list-group-item"><?php echo $text_modal_date_added; ?> <b class="pull-right"><?php echo $product['date_added']; ?></b></li>
                                  <li class="list-group-item"><?php echo $text_modal_latest_version; ?> <b class="pull-right"><?php echo $product['latest_version']; ?></b></li>
                                </ul>
                              </div>
                              <div class="tab-pane" id="modal-opencart-version-<?php echo $product['extension_id']; ?>">
                                <ul class="list-group">
                                  <li class="list-group-item">
                                    <div class="row">
                                    <?php $opencart_version_array = explode(',', $product['opencart_version']); ?>
                                    <?php foreach ($opencart_version_array as $value) { ?>
                                      <div class="col-xs-6 col-md-2 col-sm-3"><?php echo $value; ?></div>
                                    <?php } ?>
                                    </div>
                                  </li>
                                </ul>
                              </div>
                              <div class="tab-pane" id="modal-features-<?php echo $product['extension_id']; ?>">
                                <ul class="list-group">
                                  <li class="list-group-item">
                                    <div class="row">
                                    <?php $opencart_features_array = explode(';', $product['features']); ?>
                                    <?php foreach ($opencart_features_array as $value) { ?>
                                      <div class="col-xs-12 col-md-12 col-sm-12"><?php echo $value; ?></div>
                                    <?php } ?>
                                    </div>
                                  </li>
                                </ul>
                              </div>
                            </div>
                          </div>
                          <a href="<?php echo $product['url']; ?>" target="blank" class="btn btn-primary" style="width:100%;"><i class="fa fa-external-link"></i> <?php echo $button_visit_sales_page; ?></a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <?php } ?>
              </div>
              <?php } ?>
            </div>
          </div>
          <input type="hidden" style="display:none;" name="<?php echo $_module_name; ?>_form_data[front_module_name]" value="<?php echo str_replace(array('<b>','</b>'), "", $heading_title); ?>" />
          <input type="hidden" style="display:none;" name="<?php echo $_module_name; ?>_form_data[front_module_version]" value="<?php echo $_module_version; ?>" />
        </form>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--

var field_row = <?php echo $field_row; ?>;

  function addField() {
    html  = '<div class="tab-pane" id="tab-module' + field_row + '">';
    html += '   <input type="hidden" style="display:none;" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][sort_order]" />';
    html += '   <input type="hidden" style="display:none;" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][name]" value="module_' + field_row + '" />';
    html += '   <div class="form-group">';
    html += '     <label class="col-sm-2 control-label" for="input-activate' + field_row + '"><?php echo $text_activate_field; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <select name="<?php echo $_module_name; ?>_field_data[' + field_row + '][activate]" class="form-control" id="input-activate' + field_row + '">';
    html += '         <option value="1"><?php echo $text_yes; ?></option><option value="2"><?php echo $text_yes_and_hide; ?></option><option value="0" selected="selected"><?php echo $text_no; ?></option>';
    html += '       </select>';
    html += '     </div>';
    html += '   </div>';
    html += '   <div class="form-group required">';
    html += '     <label class="col-sm-2 control-label" for="input-title' + field_row + '"><?php echo $text_heading_field; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <ul class="nav nav-tabs" id="language' + field_row + '">';
                      <?php foreach ($languages as $language) { ?>
    html += '         <li>';
    html += '           <a href="#tab-module' + field_row + '-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
    html += '         </li>';
                      <?php } ?>
    html += '       </ul>';
    html += '       <div class="tab-content">';
                      <?php foreach ($languages as $language) { ?>
    html += '         <div class="tab-pane" id="tab-module' + field_row + '-language<?php echo $language['language_id']; ?>">';
    html += '           <input type="text" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][title][<?php echo $language['code']; ?>]" value="" class="form-control" id="input-title' + field_row + '" />';
                        <?php if (isset($error_data_fields[$field_row]['title'][$language['code']])) { ?>
    html += '           <div class="text-danger"><?php echo $error_data_fields[' + field_row + ']['title'][$language['code']]; ?></div>';
                        <?php } ?>
    html += '         </div>';
                      <?php } ?>
    html += '       </div>';
    html += '     </div>';
    html += '   </div>';
    html += '   <div class="form-group required">';
    html += '     <label class="col-sm-2 control-label" for="input-view' + field_row + '"><?php echo $text_assign_functionality; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <select name="<?php echo $_module_name; ?>_field_data[' + field_row + '][view]" class="form-control" id="input-view' + field_row + '">';
    html += '         <option value="0"><?php echo $text_make_a_choice; ?></option>';
                      <?php foreach ($field_view_data as $key => $view) { ?>
    html += '           <option value="<?php echo $key; ?>"><?php echo $view; ?></option>';
                      <?php } ?>
    html += '       </select>';
                    <?php if (isset($error_data_fields[$field_row]['view'])) { ?>
    html += '       <div class="text-danger"><?php echo $error_data_fields[' + field_row + ']['view']; ?></div>';
                    <?php } ?>
    html += '     </div>';
    html += '   </div>';


    html += '   <div class="form-group">';
    html += '     <label class="col-sm-2 control-label"><?php echo $text_apply_to_customer_groups; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <div class="well well-sm" style="height: 150px; overflow: auto;">';
                      <?php foreach ($all_customer_groups as $customer_group) { ?>
    html += '         <div class="checkbox">';
    html += '           <label><input type="checkbox" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][customer_groups][]" value="<?php echo $customer_group['customer_group_id']; ?>" /> <?php echo $customer_group['name']; ?></label>';
    html += '         </div>';
                      <?php } ?>
    html += '       </div>';
    html += '     </div>';
    html += '   </div>';
    html += '   <div class="form-group">';
    html += '     <label class="col-sm-2 control-label"><?php echo $text_apply_address_block; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <div class="well well-sm" style="height: 150px; overflow: auto;">';
    html += '         <div class="checkbox">';
    html += '           <label><input type="checkbox" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][address_blocks][]" value="payment" /> <?php echo $text_payment_address; ?></label>';
    html += '         </div>';
    html += '         <div class="checkbox">';
    html += '           <label><input type="checkbox" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][address_blocks][]" value="shipping" /> <?php echo $text_shipping_address; ?></label>';
    html += '         </div>';
    html += '       </div>';
    html += '     </div>';
    html += '   </div>';
    html += '   <div class="form-group">';
    html += '     <label class="col-sm-2 control-label" for="input-check' + field_row + '"><?php echo $text_check_type; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <select name="<?php echo $_module_name; ?>_field_data[' + field_row + '][check]" class="form-control" id="input-check' + field_row + '">';
    html += '         <option value="0"><?php echo $text_validation_type_1; ?></option>';
    html += '         <option value="1"><?php echo $text_validation_type_2; ?></option>';
    html += '         <option value="2"><?php echo $text_validation_type_3; ?></option>';
    html += '         <option value="3"><?php echo $text_validation_type_4; ?></option>';
    html += '       </select>';
    html += '       <div class="input-group" style="display:none;margin-top:15px;">';
    html += '         <span class="input-group-addon"><i class="fa fa-filter"></i></span>';
    html += '         <input type="text" placeholder="" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][check_rule]" value="" class="form-control" />';
    html += '       </div>';
    html += '       <div class="input-group" style="display:none;margin-top:15px;">';
    html += '         <span class="input-group-addon"><i class="fa fa-chevron-right"></i></span>';
    html += '         <input type="text" placeholder="<?php echo $text_validation_type_4_1_ph; ?>" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][check_min]" value="" class="form-control" />';
    html += '       </div>';
    html += '       <div class="input-group" style="display:none;margin-top:15px;">';
    html += '         <span class="input-group-addon"><i class="fa fa-chevron-left"></i></span>';
    html += '         <input type="text" placeholder="<?php echo $text_validation_type_4_2_ph; ?>" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][check_max]" value="" class="form-control" />';
    html += '       </div>';
    html += '     </div>';
    html += '   </div>';
    html += '   <div class="form-group">';
    html += '     <label class="col-sm-2 control-label" for="input-mask' + field_row + '"><?php echo $text_mask; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <div class="input-group">';
    html += '         <span class="input-group-addon"><i class="fa fa-pencil-square-o"></i></span>';
    html += '         <input value="" type="text" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][mask]" class="form-control" placeholder="<?php echo $text_mask_ph; ?>" id="input-mask' + field_row + '" />';
    html += '       </div>';
    html += '     </div>';
    html += '   </div>';
    html += '   <div class="form-group required">';
    html += '     <label class="col-sm-2 control-label" for="input-error_text' + field_row + '"><?php echo $text_error_text; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <ul class="nav nav-tabs" id="language' + field_row + '">';
                      <?php foreach ($languages as $language) { ?>
    html += '           <li>';
    html += '             <a href="#tab-module2' + field_row + '-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
    html += '           </li>';
                      <?php } ?>
    html += '       </ul>';
    html += '       <div class="tab-content">';
                      <?php foreach ($languages as $language) { ?>
    html += '           <div class="tab-pane" id="tab-module2' + field_row + '-language<?php echo $language['language_id']; ?>">';
    html += '             <input type="text" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][error_text][<?php echo $language['code']; ?>]" value="<?php echo $text_default_error_message; ?>" class="form-control" id="input-error_text' + field_row + '" />';
                          <?php if (isset($error_data_fields[$field_row]['error_text'][$language['code']])) { ?>
    html += '               <div class="text-danger"><?php echo $error_data_fields[' + field_row + ']['error_text'][$language['code']]; ?></div>';
                          <?php } ?>
    html += '           </div>';
                      <?php } ?>
    html += '       </div>';
    html += '     </div>';
    html += '   </div>';
    html += '   <div class="form-group">';
    html += '     <label class="col-sm-2 control-label" for="input-placeholder_text' + field_row + '"><?php echo $text_placeholder_text; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <ul class="nav nav-tabs" id="language' + field_row + '">';
                      <?php foreach ($languages as $language) { ?>
    html += '           <li>';
    html += '             <a href="#tab-module2' + field_row + '-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
    html += '           </li>';
                      <?php } ?>
    html += '       </ul>';
    html += '       <div class="tab-content">';
                      <?php foreach ($languages as $language) { ?>
    html += '           <div class="tab-pane" id="tab-module2' + field_row + '-language<?php echo $language['language_id']; ?>">';
    html += '             <input type="text" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][placeholder_text][<?php echo $language['code']; ?>]" value="<?php echo $text_default_error_message; ?>" class="form-control" id="input-placeholder_text' + field_row + '" />';
    html += '           </div>';
                      <?php } ?>
    html += '       </div>';
    html += '     </div>';
    html += '   </div>';
    html += '   <div class="form-group">';
    html += '     <label class="col-sm-2 control-label" for="input-css_id' + field_row + '"><?php echo $text_css_id; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <div class="input-group">';
    html += '         <span class="input-group-addon">#</span>';
    html += '         <input value="" type="text" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][css_id]" class="form-control" placeholder="<?php echo $text_css_id_ph; ?>" id="input-css_id' + field_row + '" />';
    html += '       </div>';
    html += '     </div>';
    html += '   </div>';
    html += '   <div class="form-group">';
    html += '     <label class="col-sm-2 control-label" for="input-css_class' + field_row + '"><?php echo $text_css_class; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <div class="input-group">';
    html += '         <span class="input-group-addon">&#8226;</span>';
    html += '         <input value="" type="text" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][css_class]" class="form-control" placeholder="<?php echo $text_css_class_ph; ?>" id="input-css_class' + field_row + '" />';
    html += '       </div>';
    html += '     </div>';
    html += '   </div>';
    html += '   <div class="form-group">';
    html += '     <label class="col-sm-2 control-label"><?php echo $text_position; ?></label>';
    html += '     <div class="col-sm-10">';
    html += '       <div class="btn-group" data-toggle="buttons">';
    html += '         <label class="btn btn-success">';
    html += '           <input type="radio" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][position]" value="1" autocomplete="off" /><?php echo $text_left_side; ?>';
    html += '         </label>';
    html += '         <label class="btn btn-success active">';
    html += '           <input type="radio" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][position]" value="3" autocomplete="off" checked="checked" /><?php echo $text_center; ?>';
    html += '         </label>';
    html += '         <label class="btn btn-success">';
    html += '           <input type="radio" name="<?php echo $_module_name; ?>_field_data[' + field_row + '][position]" value="2" autocomplete="off" /><?php echo $text_right_side; ?>';
    html += '         </label>';
    html += '       </div>';
    html += '     </div>';
    html += '   </div>';

    $('#fields-block .tab-content:first-child').append(html);

    $('#module-add').before('<li class="no_field_title"><a href="#tab-module' + field_row + '" data-toggle="tab"><i class="fa fa-minus-circle" onclick="$(\'a[href=\\\'#tab-module' + field_row + '\\\']\').parent().remove(); $(\'#tab-module' + field_row + '\').remove(); $(\'#module a:first\').tab(\'show\');"></i> <?php echo $text_tab_field; ?> №' + field_row + '</a></li>');
    $('#module a[href=\'#tab-module' + field_row + '\']').tab('show');
    $('#module a[href=\'#tab-module2' + field_row + '\']').tab('show');
    $('#module a[href=\'#tab-module3' + field_row + '\']').tab('show');
    $('#language' + field_row + ' li:first-child a').tab('show');

    $('select[name*=check]').change(function() {
      var val = $(this).val();
      if (val == 2) {
        $(this).next().show();
        $(this).next().next().hide();
        $(this).next().next().next().hide();
      } else if(val == 3) {
        $(this).next().hide();
        $(this).next().next().show();
        $(this).next().next().next().show();
      } else {
        $(this).next().hide();
        $(this).next().next().hide();
        $(this).next().next().next().hide();
      }
    });

    $('select[name*=view]').change(function() {
      var val = $(this).val();
      if (val == "telephone") {
        $('#field-mask').show();
      } else {
        $('#field-mask').hide();
      }
    });

    field_row++;
  }

<?php $field_row = 1; foreach ($field_data as $field) { ?>
  $('#language<?php echo $field_row; ?> li:first-child a').tab('show');
<?php $field_row++; } ?>

$('select[name*=check]').change(function() {
  var val = $(this).val();
  if (val == 2) {
    $(this).next().show();
    $(this).next().next().hide();
    $(this).next().next().next().hide();
  } else if(val == 3) {
    $(this).next().hide();
    $(this).next().next().show();
    $(this).next().next().next().show();
  } else {
    $(this).next().hide();
    $(this).next().next().hide();
    $(this).next().next().next().hide();
  }
});

$('select[name*=view]').change(function() {
  var val = $(this).val();
  if (val == "telephone") {
    $('#field-mask').show();
  } else {
    $('#field-mask').hide();
  }
});

$('#module_heading a:first').tab('show');
$('#module_checkout_button a:first').tab('show');
$('#module_continue_button a:first').tab('show');
$('#success_text a:first').tab('show');
$('#additional a:first').tab('show');
$('#empty_text a:first').tab('show');
$('#order-totals-validations a:first').tab('show');
$('#module li:first-child a').tab('show');
$('#custom-success-page-heading a').tab('show');
$('#recommended-products-heading a').tab('show');
$('#custom-success-page-massage a').tab('show');

$('#fields-block .nav-pills').sortable({
  forcePlaceholderSize: true,
  items: '> li:not(#module-add)',
  cursor: "move",
  axis: "y",
  placeholder: 'tab-placeholder',
});

if (window.localStorage && window.localStorage['last_active_tab']) {
  $('#setting-tabs a[href=' + window.localStorage['last_active_tab'] + ']').trigger('click');
}
$('#setting-tabs a[data-toggle="tab"]').click(function() {
  if (window.localStorage) {
    window.localStorage['last_active_tab'] = $(this).attr('href');
  }
});

<?php foreach ($languages as $language) { ?>
$('#success_text_<?php echo $language['language_id']; ?>').summernote({height: 150});
$('#additional_<?php echo $language['language_id']; ?>').summernote({height: 150});
$('#empty_text_<?php echo $language['language_id']; ?>').summernote({height: 150});
$('#custom-success-page-massage_<?php echo $language['language_id']; ?>').summernote({height: 150});
<?php } ?>
//--></script>

<script type="text/javascript"><!--
  $('select#sp_check').change(function() {
    var val = $(this).val();
     if (val == 1) {
      $('#rp-categories').show();
      $('#rp-manufacturers').hide();
      $('#rp-products').hide();
     } else if(val == 2) {
      $('#rp-categories').hide();
      $('#rp-manufacturers').show();
      $('#rp-products').hide();
     } else if (val == 3) {
      $('#rp-categories').hide();
      $('#rp-manufacturers').hide();
      $('#rp-products').show();
     } else {
      $('#rp-categories').hide();
      $('#rp-manufacturers').hide();
      $('#rp-products').hide();
     }
  });
</script>
<script type="text/javascript"><!--
$('input[name=\'sp_manufacturer\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['manufacturer_id']
          }
        }));
      }
    });
  },
  select: function(item) {
    $('input[name=\'sp_manufacturer\']').val('');
    $('#sp-manufacturer-filter' + item['value']).remove();
    $('#sp-manufacturer-filter').append('<div id="sp-manufacturer-filter' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="<?php echo $_module_name; ?>_sp_form_data[recommended_manufacturers][]" value="' + item['value'] + '" /></div>');
  }
});

$('#sp-manufacturer-filter').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});
//--></script>
<script type="text/javascript"><!--
$('input[name=\'sp_category\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['category_id']
          }
        }));
      }
    });
  },
  select: function(item) {
    $('input[name=\'sp_category\']').val('');
    $('#sp-category-filter' + item['value']).remove();
    $('#sp-category-filter').append('<div id="sp-category-filter' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="<?php echo $_module_name; ?>_sp_form_data[recommended_categories][]" value="' + item['value'] + '" /></div>');
  }
});

$('#sp-category-filter').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});
//--></script>
<script type="text/javascript"><!--
$('input[name=\'sp_product\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['product_id']
          }
        }));
      }
    });
  },
  select: function(item) {
    $('input[name=\'sp_product\']').val('');
    $('#sp-product-filter' + item['value']).remove();
    $('#sp-product-filter').append('<div id="sp-product-filter' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="<?php echo $_module_name; ?>_sp_form_data[recommended_products][]" value="' + item['value'] + '" /></div>');
  }
});

$('#sp-product-filter').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});

$('#load-file').change(function(){
  $('#load-file-mask').val($(this).val());
  $('#button-import-file').attr('disabled', false);
});
//--></script>
<?php echo $footer; ?>
