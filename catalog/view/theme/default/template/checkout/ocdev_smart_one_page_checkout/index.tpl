<?php echo $header; ?>
<div class="container" id="smopc-page">
	<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ul>
	<?php if ($error_warning) { ?>
	<div class="smopc-alert alert smopc-alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
		<button type="button" class="smopc-close" data-dismiss="alert">&times;</button>
	</div>
	<?php } ?>
	<div class="smopc-row"><?php echo $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
		<?php $class = 'smopc-col-sm-6'; ?>
		<?php } elseif ($column_left || $column_right) { ?>
		<?php $class = 'smopc-col-sm-9'; ?>
		<?php } else { ?>
		<?php $class = 'smopc-col-sm-12'; ?>
		<?php } ?>
		<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
			<h1><?php echo $heading_title; ?></h1>
			<?php if ($show_additional_text == 1) { ?>
			<div class="smopc-well"><?php echo $additional_text; ?></div>
			<?php } ?>
			<?php if ($cart_status) { ?>
				<div class="smopc-row">
					<div class="smopc-panel-group smopc-col-sm-12">
						<div class="smopc-pull-left">
							<div class="smopc-btn-group btn-group smopc-btn-group-fix-top" data-toggle="buttons" id="account-buttons">
								<?php if (!$logged) { ?>
									<?php if ($checkout_guest && !$allow_guest_order) { ?>
										<?php if ($account != 'guest' || $account == 'guest') { ?>
											<label class="smopc-btn btn smopc-btn-default active"><input type="radio" name="account" value="guest" style="display:none;" checked="checked" /><i class="fa fa-user"></i> <?php echo $button_guest; ?></label>
										<?php } else { ?>
											<label class="smopc-btn btn smopc-btn-default"><input type="radio" name="account" value="guest" style="display:none;" /><i class="fa fa-user"></i> <?php echo $button_guest; ?></label>
										<?php } ?>
									<?php } ?>
									<?php if (!$allow_register) { ?>
										<?php if (!$allow_register && $allow_guest_order) { ?>
											<label class="smopc-btn btn smopc-btn-default active"><input type="radio" name="account" value="register" style="display:none;" checked="checked"/><i class="fa fa-plus-square"></i> <?php echo $button_register; ?></label>
										<?php } else { ?>
											<label class="smopc-btn btn smopc-btn-default"><input type="radio" name="account" value="register" style="display:none;" /><i class="fa fa-plus-square"></i> <?php echo $button_register; ?></label>
										<?php } ?>
									<?php } ?>
									<?php if (isset($checkout_blocks) && in_array('login', $checkout_blocks) && !$allow_login) { ?>
									<label class="smopc-btn btn smopc-btn-default"><input type="radio" name="account" value="login" style="display:none;" /><i class="fa fa-sign-in"></i> <?php echo $button_login; ?></label>
									<?php } ?>
								<?php } ?>
								<?php if ($logged) { ?>
								<label class="smopc-btn btn smopc-btn-default smopc-active"><input type="radio" name="account" value="registered" style="display:none;" checked="checked" /><i class="fa fa-user"></i> <?php echo $button_registered_user; ?></label>
								<label class="smopc-btn btn smopc-btn-default"><input type="radio" name="account" value="logout" style="display:none;" /><i class="fa fa-sign-out"></i> <?php echo $button_logout; ?></label>
								<?php } ?>
							</div>
						</div>
						<div class="smopc-pull-right">
							<div class="smopc-btn-group btn-group" id="checkout-buttons-top">
							<?php if ($cancel_button == 1 || $cancel_button == 2) { ?><a href="<?php echo $continue; ?>" class="smopc-btn smopc-btn-default"><?php echo $button_cancel; ?></a><?php } ?>
							<?php if ($checkout_button == 1) { ?><input type="button" value="<?php echo $button_checkout; ?>" data-button-type="checkout" data-loading-text="<?php echo $text_loading; ?>" class="smopc-btn smopc-btn-primary" /><?php } ?>
							</div>
						</div>
					</div>
				</div>
				<div class="smopc-row">
					<div class="smopc-panel-group <?php echo (isset($checkout_blocks) && (in_array('shipping', $checkout_blocks) || in_array('payment', $checkout_blocks))) ? 'smopc-col-sm-5' : 'smopc-col-sm-12'; ?>">
						<?php if (!$logged && (isset($checkout_blocks) && in_array('login', $checkout_blocks))) { ?>
						<!-- LOGIN BLOCK START -->
							<?php echo $login_block; ?>
						<!-- LOGIN BLOCK END -->
						<?php } ?>

						<!-- PERSONAL & BILLING DETAILS START -->
						<div class="smopc-panel-group" id="guest">
							<div class="smopc-panel smopc-panel-default">
								<div class="smopc-panel-heading">
									<h4 class="smopc-panel-title"><i class="fa fa-user"></i> <?php echo $heading_user_block; ?></h4>
								</div>
								<div class="smopc-panel-collapse">
									<div class="smopc-panel-body">
										<div class="smopc-row">
											<?php if ($addresses) { ?>
											<div class="smopc-col-sm-12">
												<div class="smopc-radio">
													<label><input type="radio" name="payment_address" value="existing" checked="checked" /><?php echo $text_address_existing; ?></label>
												</div>
												<div id="payment-existing">
													<select name="address_id" class="smopc-form-control">
														<?php foreach ($addresses as $address) { ?>
														<?php if ($address['address_id'] == $address_id) { ?>
														<option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
														<?php } else { ?>
														<option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
														<?php } ?>
														<?php } ?>
													</select>
												</div>
												<?php if ($allow_second_address) { ?>
												<div class="smopc-radio">
													<label><input type="radio" name="payment_address" value="new" /><?php echo $text_address_new; ?></label>
												</div>
												<?php } ?>
											</div>
											<br />
											<?php } ?>
											<div id="payment-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
												<?php if ($customer_groups) { ?>
												<div class="smopc-form-group smopc-col-sm-12" style="display: <?php echo (count($customer_groups) > 1) ? 'block' : 'none'; ?>;" id="customer-group">
													<label class="smopc-control-label"><?php echo $entry_customer_group; ?></label>
													<?php if ($display_customer_groups_type == 1) { ?>
														<?php foreach ($customer_groups as $customer_group) { ?>
														<div class="smopc-radio">
															<label>
																<input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" <?php echo ($customer_group['customer_group_id'] == $customer_group_id) ? 'checked="checked"' : ''; ?> onchange="save_guest('#guest', '#guest', <?php echo $customer_group['customer_group_id']; ?>);" />
																<?php echo $customer_group['name']; ?>
															</label>
														</div>
														<?php } ?>
													<?php } else { ?>
														<select name="customer_group_id" onchange="save_guest('#guest', '#guest', $(this).val());" class="smopc-form-control">
															<?php foreach ($customer_groups as $customer_group) { ?>
																<option value="<?php echo $customer_group['customer_group_id']; ?>" <?php echo ($customer_group['customer_group_id'] == $customer_group_id) ? 'selected' : ''; ?>><?php echo $customer_group['name']; ?></option>
															<?php } ?>
														</select>
													<?php } ?>
												</div>
												<?php } ?>
												<?php foreach ($payment_address_fields as $field) { ?>
										      <?php if($field['type'] == 'textarea') { ?>
										        <div <?php echo ($field['css_id']) ? 'id="'.$field['css_id'].'"' : "" ; ?> class="smopc-form-group <?php echo $field['position'].' '; echo ($field['check'] != 0) ? 'smopc-required' : ''; echo ($field['css_class']) ? ' ' . $field['css_class'] : "" ; ?>" <?php echo ($field['activate'] == 2) ? 'style="display:none;"' : "" ; ?>>
										        	<label class="smopc-control-label"><?php echo $field['title']; ?></label>
										          <textarea name="<?php echo $field['name']; ?>" placeholder="<?php echo $field['placeholder_text']; ?>" class="smopc-form-control"><?php echo $input_value[$field['name']]; ?></textarea>
										        </div>
										      <?php } elseif ($field['type'] == 'select') { ?>
										        <div <?php echo ($field['css_id']) ? 'id="'.$field['css_id'].'"' : "" ; ?> class="smopc-form-group <?php echo $field['position'].' '; echo ($field['check'] != 0) ? 'smopc-required' : ''; echo ($field['css_class']) ? ' ' . $field['css_class'] : "" ; ?>" <?php echo ($field['activate'] == 2) ? 'style="display:none;"' : "" ; ?>>
										        	<label class="smopc-control-label"><?php echo $field['title']; ?></label>
										          <?php if($field['name'] == 'country_id') { ?>
										          <select name="<?php echo $field['name']; ?>" class="smopc-form-control">
										            <option value=""><?php echo $text_select; ?></option>
										            <?php if ($countries) { ?>
										              <?php foreach ($countries as $country) { ?>
										                <?php if ($country['country_id'] == $country_id) { ?>
										                <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
										                <?php } else { ?>
										                <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
										                <?php } ?>
										              <?php } ?>
										            <?php } ?>
										          </select>
										          <?php } elseif ($field['name'] == 'zone_id') { ?>
										            <select name="zone_id" class="smopc-form-control"></select>
										          <?php } else { ?>
										            <select name="<?php echo $field['name']; ?>" class="smopc-form-control"></select>
										          <?php } ?>
										        </div>
										      <?php } else { ?>
										        <div <?php echo ($field['css_id']) ? 'id="'.$field['css_id'].'"' : "" ; ?> class="smopc-form-group <?php echo $field['position'].' '; echo ($field['check'] != 0) ? 'smopc-required' : ''; echo ($field['css_class']) ? ' ' . $field['css_class'] : "" ; ?>" <?php echo ($field['activate'] == 2) ? 'style="display:none;"' : "" ; ?>>
										          <label class="smopc-control-label"><?php echo $field['title']; ?></label>
										          <input name="<?php echo $field['name']; ?>" value="<?php echo $input_value[$field['name']]; ?>" type="<?php echo $field['type']; ?>" placeholder="<?php echo $field['placeholder_text']; ?>" class="smopc-form-control"/>
										        </div>
										      <?php } ?>
										      <?php if ($field['mask']) { ?>
						                <script type="text/javascript">
						                  $("#payment-new [name='<?php echo $field['name']; ?>']").inputmask('<?php echo $field['mask']; ?>');
						                </script>
						              <?php } ?>
										    <?php } ?>
										    <?php if ($allow_custom_fields) { ?>
											    <?php foreach ($custom_fields as $custom_field) { ?>
											      <?php if ($custom_field['location'] == 'account') { ?>
												      <?php if ($custom_field['type'] == 'select') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control">
												          <option value=""><?php echo $text_select; ?></option>
												          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
												          <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $guest_custom_field[$custom_field['custom_field_id']]) { ?>
												          <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
												          <?php } else { ?>
												          <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
												          <?php } ?>
												          <?php } ?>
												        </select>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'radio') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label"><?php echo $custom_field['name']; ?></label>
												        <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
												          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
												          <div class="smopc-radio">
												            <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $guest_custom_field[$custom_field['custom_field_id']]) { ?>
												            <label>
												              <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
												              <?php echo $custom_field_value['name']; ?></label>
												            <?php } else { ?>
												            <label>
												              <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
												              <?php echo $custom_field_value['name']; ?></label>
												            <?php } ?>
												          </div>
												          <?php } ?>
												        </div>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'checkbox') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label"><?php echo $custom_field['name']; ?></label>
												        <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
												          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
												          <div class="smopc-checkbox">
												            <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $guest_custom_field[$custom_field['custom_field_id']])) { ?>
												            <label>
												              <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
												              <?php echo $custom_field_value['name']; ?></label>
												            <?php } else { ?>
												            <label>
												              <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
												              <?php echo $custom_field_value['name']; ?></label>
												            <?php } ?>
												          </div>
												          <?php } ?>
												        </div>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'text') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control" />
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'textarea') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control"><?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'file') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label"><?php echo $custom_field['name']; ?></label>
												        <br />
												        <button type="button" id="button-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="smopc-btn smopc-btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
												        <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : ''); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'date') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <div class="smopc-input-group date">
												          <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control" />
												          <span class="smopc-input-group-btn">
												          <button type="button" class="smopc-btn smopc-btn-default"><i class="fa fa-calendar"></i></button>
												          </span></div>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'time') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <div class="smopc-input-group time">
												          <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control" />
												          <span class="smopc-input-group-btn">
												          <button type="button" class="smopc-btn smopc-btn-default"><i class="fa fa-calendar"></i></button>
												          </span></div>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'datetime') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <div class="smopc-input-group datetime">
												          <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control" />
												          <span class="smopc-input-group-btn">
												          <button type="button" class="smopc-btn smopc-btn-default"><i class="fa fa-calendar"></i></button>
												          </span></div>
												      </div>
												      <?php } ?>
											      <?php } ?>
											    <?php } ?>
										    <?php } ?>
												<div id="password" class="smopc-col-sm-12">
													<div class="smopc-row">
														<div>
															<div class="smopc-form-group smopc-required smopc-col-sm-6">
																<label class="smopc-control-label" for="input-payment-password"><?php echo $entry_password; ?></label>
																<input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-payment-password" class="smopc-form-control" />
															</div>
															<div class="smopc-form-group smopc-required smopc-col-sm-6">
																<label class="smopc-control-label" for="input-payment-confirm"><?php echo $entry_confirm; ?></label>
																<input type="password" name="confirm" value="" placeholder="<?php echo $entry_confirm; ?>" id="input-payment-confirm" class="smopc-form-control" />
															</div>
														</div>
													</div>
													<?php if ($allow_newsletter_subscribe) { ?>
													<label for="newsletter"><input type="checkbox" name="newsletter" value="1" id="input-payment-newsletter" /> <?php echo $entry_newsletter; ?></label>
													<?php } ?>
												</div>
											</div>
											<?php if ($allow_second_address && !$logged && $shipping_required) { ?>
											<div class="smopc-col-sm-12">
												<label>
													<?php if ($shipping_address) { ?>
													<input type="checkbox" name="shipping_address" value="1" checked="checked" />
													<?php } else { ?>
													<input type="checkbox" name="shipping_address" value="1" />
													<?php } ?>
													<?php echo $entry_shipping; ?>
												</label>
											</div>
											<?php } else { ?>
											<div class="smopc-col-sm-12" style="display:none;">
												<label>
													<?php if ($shipping_address) { ?>
													<input type="checkbox" name="shipping_address" value="1" checked="checked" />
													<?php } else { ?>
													<input type="checkbox" name="shipping_address" value="1" />
													<?php } ?>
													<?php echo $entry_shipping; ?>
												</label>
											</div>
											<?php } ?>
										</div>
									</div>
									<?php if (!$logged && $text_agree_checkout) { ?>
									<div class="smopc-panel-footer">
										<label for="checkout-agree"><input type="checkbox" name="agree" value="1" id="checkout-agree" /> <?php echo $text_agree_checkout; ?></label>
									</div>
									<?php } ?>
								</div>
							</div>
						</div>
						<!-- PERSONAL & BILLING DETAILS END -->
						<!-- DELIVERY DETAILS START -->
						<div class="smopc-panel-group" id="guest-shipping" style="<?php echo ($allow_second_address && $shipping_address && !$logged) ? 'display:none;' : 'display:block;'; ?>">
							<div class="smopc-panel smopc-panel-default">
								<div class="smopc-panel-heading">
									<h4 class="smopc-panel-title"><i class="fa fa-map-marker"></i> <?php echo $heading_delivery_block; ?></h4>
								</div>
								<div class="smopc-panel-collapse">
									<div class="smopc-panel-body">
										<div class="smopc-row">
											<?php if ($addresses) { ?>
											<div class="smopc-col-sm-12">
												<div class="smopc-radio">
													<label><input type="radio" name="shipping_address" value="existing" checked="checked" /><?php echo $text_address_existing; ?></label>
												</div>
												<div id="shipping-existing">
													<select name="address_id" class="smopc-form-control">
														<?php foreach ($addresses as $address) { ?>
														<?php if ($address['address_id'] == $address_id) { ?>
														<option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
														<?php } else { ?>
														<option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
														<?php } ?>
														<?php } ?>
													</select>
												</div>
												<?php if ($allow_second_address) { ?>
												<div class="smopc-radio">
													<label><input type="radio" name="shipping_address" value="new" /><?php echo $text_address_new; ?></label>
												</div>
												<?php } ?>
											</div>
											<br />
											<?php } ?>
											<div id="shipping-new" style="display: <?php echo ($addresses) ? 'none' : 'block'; ?>;">
												<?php foreach ($shipping_address_fields as $field) { ?>
										      <?php if($field['type'] == 'textarea') { ?>
										        <div <?php echo ($field['css_id']) ? 'id="'.$field['css_id'].'"' : "" ; ?> class="smopc-form-group <?php echo $field['position'].' '; echo ($field['check'] != 0) ? 'smopc-required' : ''; echo ($field['css_class']) ? ' ' . $field['css_class'] : "" ; ?>" <?php echo ($field['activate'] == 2) ? 'style="display:none;"' : "" ; ?>>
										        	<label class="smopc-control-label"><?php echo $field['title']; ?></label>
										          <textarea name="<?php echo $field['name']; ?>" placeholder="<?php echo $field['placeholder_text']; ?>" class="smopc-form-control"><?php echo $input_value[$field['name']]; ?></textarea>
										        </div>
										      <?php } elseif ($field['type'] == 'select') { ?>
										        <div <?php echo ($field['css_id']) ? 'id="'.$field['css_id'].'"' : "" ; ?> class="smopc-form-group <?php echo $field['position'].' '; echo ($field['check'] != 0) ? 'smopc-required' : ''; echo ($field['css_class']) ? ' ' . $field['css_class'] : "" ; ?>" <?php echo ($field['activate'] == 2) ? 'style="display:none;"' : "" ; ?>>
										        	<label class="smopc-control-label"><?php echo $field['title']; ?></label>
										          <?php if($field['name'] == 'country_id') { ?>
										          <select name="<?php echo $field['name']; ?>" class="smopc-form-control">
										            <option value=""><?php echo $text_select; ?></option>
										            <?php if ($countries) { ?>
										              <?php foreach ($countries as $country) { ?>
										                <?php if ($country['country_id'] == $country_id) { ?>
										                <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
										                <?php } else { ?>
										                <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
										                <?php } ?>
										              <?php } ?>
										            <?php } ?>
										          </select>
										          <?php } elseif ($field['name'] == 'zone_id') { ?>
										            <select name="zone_id" class="smopc-form-control"></select>
										          <?php } else { ?>
										            <select name="<?php echo $field['name']; ?>" class="smopc-form-control"></select>
										          <?php } ?>
										        </div>
										      <?php } else { ?>
										        <div <?php echo ($field['css_id']) ? 'id="'.$field['css_id'].'"' : "" ; ?> class="smopc-form-group <?php echo $field['position'].' '; echo ($field['check'] != 0) ? 'smopc-required' : ''; echo ($field['css_class']) ? ' ' . $field['css_class'] : "" ; ?>" <?php echo ($field['activate'] == 2) ? 'style="display:none;"' : "" ; ?>>
										          <label class="smopc-control-label"><?php echo $field['title']; ?></label>
										          <input name="<?php echo $field['name']; ?>" value="<?php echo $input_value[$field['name']]; ?>" type="<?php echo $field['type']; ?>" placeholder="<?php echo $field['placeholder_text']; ?>" class="smopc-form-control"/>
										        </div>
										      <?php } ?>
										      <?php if ( $field['name'] == 'telephone' && $field['mask'] ) { ?>
						                <script type="text/javascript">
						                  $("#shipping-new [name='<?php echo $field['name']; ?>']").inputmask('<?php echo $field['mask']; ?>');
						                </script>
						              <?php } ?>
										    <?php } ?>
										    <?php if ($allow_custom_fields) { ?>
											    <?php foreach ($custom_fields as $custom_field) { ?>
											      <?php if ($custom_field['location'] == 'address') { ?>
												      <?php if ($custom_field['type'] == 'select') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control">
												          <option value=""><?php echo $text_select; ?></option>
												          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
												          <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $guest_custom_field[$custom_field['custom_field_id']]) { ?>
												          <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
												          <?php } else { ?>
												          <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
												          <?php } ?>
												          <?php } ?>
												        </select>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'radio') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label"><?php echo $custom_field['name']; ?></label>
												        <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
												          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
												          <div class="smopc-radio">
												            <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $guest_custom_field[$custom_field['custom_field_id']]) { ?>
												            <label>
												              <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
												              <?php echo $custom_field_value['name']; ?></label>
												            <?php } else { ?>
												            <label>
												              <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
												              <?php echo $custom_field_value['name']; ?></label>
												            <?php } ?>
												          </div>
												          <?php } ?>
												        </div>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'checkbox') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label"><?php echo $custom_field['name']; ?></label>
												        <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
												          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
												          <div class="smopc-checkbox">
												            <?php if (isset($guest_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $guest_custom_field[$custom_field['custom_field_id']])) { ?>
												            <label>
												              <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
												              <?php echo $custom_field_value['name']; ?></label>
												            <?php } else { ?>
												            <label>
												              <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
												              <?php echo $custom_field_value['name']; ?></label>
												            <?php } ?>
												          </div>
												          <?php } ?>
												        </div>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'text') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control" />
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'textarea') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control"><?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'file') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label"><?php echo $custom_field['name']; ?></label>
												        <br />
												        <button type="button" id="button-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="smopc-btn smopc-btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
												        <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : ''); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'date') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <div class="smopc-input-group date">
												          <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control" />
												          <span class="smopc-input-group-btn">
												          <button type="button" class="smopc-btn smopc-btn-default"><i class="fa fa-calendar"></i></button>
												          </span></div>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'time') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <div class="smopc-input-group time">
												          <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control" />
												          <span class="smopc-input-group-btn">
												          <button type="button" class="smopc-btn smopc-btn-default"><i class="fa fa-calendar"></i></button>
												          </span></div>
												      </div>
												      <?php } ?>
												      <?php if ($custom_field['type'] == 'datetime') { ?>
												      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-group custom-field smopc-col-sm-6 <?php echo ($custom_field['required']) ? 'smopc-required' : '' ;?>" data-sort="<?php echo $custom_field['sort_order']; ?>">
												        <label class="smopc-control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
												        <div class="smopc-input-group datetime">
												          <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($guest_custom_field[$custom_field['custom_field_id']]) ? $guest_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="smopc-form-control" />
												          <span class="smopc-input-group-btn">
												          <button type="button" class="smopc-btn smopc-btn-default"><i class="fa fa-calendar"></i></button>
												          </span></div>
												      </div>
												      <?php } ?>
											      <?php } ?>
											    <?php } ?>
											  <?php } ?>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- DELIVERY DETAILS END -->
					</div>

					<div class="<?php echo (isset($checkout_blocks) && (in_array('shipping', $checkout_blocks) || in_array('payment', $checkout_blocks))) ? 'smopc-col-sm-7' : 'smopc-col-sm-12'; ?>">
						<div class="smopc-row">
							<?php if (isset($checkout_blocks) && in_array('payment', $checkout_blocks)) { ?>
							<!-- PAYMENT METHOD START -->
							<?php echo $payment_block; ?>
							<!-- PAYMENT METHOD END -->
							<?php } ?>
							<?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>
							<!-- SHIPPING METHOD START -->
							<?php echo $shipping_block; ?>
							<!-- SHIPPING METHOD END -->
							<?php } else { ?>
								<script type="text/javascript">function update_shipping(){};</script>
							<?php } ?>
						</div>

						<?php if (isset($checkout_blocks) && (in_array('voucher', $checkout_blocks) || in_array('coupon', $checkout_blocks) || in_array('reward', $checkout_blocks))) { ?>
						<!-- GIFT VOUCHER & COUPON CODE START -->
						<?php echo $coupon_voucher_reward; ?>
						<!-- GIFT VOUCHER & COUPON CODE END -->
						<?php } ?>

						<?php if (isset($checkout_blocks) && in_array('cart', $checkout_blocks)) { ?>
						<!-- SHOPPING CART START -->
						<?php echo $cart_block; ?>
						<!-- SHOPPING CART END -->
						<?php } ?>
					</div>
				</div>
				<?php if ($show_additional_text == 2) { ?>
				<div class="smopc-well"><?php echo $additional_text; ?></div>
				<?php } ?>
				<div class="smopc-buttons" id="checkout-buttons-bottom">
					<?php if ($cancel_button == 2 || $cancel_button == 3) { ?><a href="<?php echo $continue; ?>" class="smopc-btn smopc-btn-default"><?php echo $button_cancel; ?></a><?php } ?>
					<?php if ($checkout_button == 1 || $checkout_button == 2) { ?>
						<input type="button" value="<?php echo $button_checkout; ?>" data-button-type="checkout" data-loading-text="<?php echo $text_loading; ?>" class="smopc-btn smopc-btn-primary smopc-pull-right" />
					<?php } ?>
				</div>
				<div class="smopc-row" id="bottom-payment-block">
					<div class="smopc-col-sm-12" id="payment"><?php echo $payment; ?></div>
				</div>
			<?php } else { ?>
				<p><?php echo $text_error; ?></p>
				<div class="smopc-buttons">
					<div class="smopc-pull-right"><a href="<?php echo $continue; ?>" class="smopc-btn smopc-btn-primary"><?php echo $button_continue; ?></a></div>
				</div>
			<?php } ?>
			<?php echo $content_bottom; ?></div>
		<?php echo $column_right; ?></div>
</div>
<script type="text/javascript">
// set first shipping and payment methods start
<?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>save_shipping('#shipping-method', '#shipping-method, #checkout-cart', 'onload');<?php } ?>
<?php if (isset($checkout_blocks) && in_array('payment', $checkout_blocks)) { ?>save_payment('#payment-method', '#payment-method', 'onload');<?php } ?>
save_guest('#guest', '#guest', $('input[name="customer_group_id"]:checked').val());
// set first shipping and payment methods end

// multi-function for save guest data start
function save_guest(block, refresh, id) {
	var account_type = $('input[name=\'account\']:checked').val();
	masked(refresh, true);
	$.ajax({
		url: 'index.php?route=checkout/ocdev_smart_one_page_checkout&customer_group_id=' + id,
		dataType: 'html',
    success: function(data) {
    	masked(refresh, false);
      $('#guest').html($(data).find('#guest > *'));
      $('#payment-method').html($(data).find('#payment-method > *'));
      $('#guest select[name=\'country_id\']').trigger('change');
			$('#guest-shipping select[name=\'country_id\']').trigger('change');
			<?php if ($allow_custom_fields) { ?>sort_custom_fields();<?php } ?>
			if (account_type == "register") {
				$('#password').slideDown();
	    } else {
	    	$('#password').slideUp();
	    }
    }
	});
}
// multi-function for save guest data end

// checkout function start
$(document).on('click', 'input[data-button-type=\'checkout\']', function() {

	var account_type = $('input[name=\'account\']:checked').val();

	if (account_type == "register") {
		var ajax_url = 'index.php?route=checkout/ocdev_smart_one_page_checkout/register_save';
	} else if (account_type == "registered") {
		var ajax_url = 'index.php?route=checkout/ocdev_smart_one_page_checkout/payment_address_save';
	} else {
		var ajax_url = 'index.php?route=checkout/ocdev_smart_one_page_checkout/guest_save';
	}

	masked('#guest .smopc-panel-body, #guest-shipping .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart', true);

	var next_step_g  = false;
	var next_step_gs = false;

	if (account_type == "registered") { // if user is registered start
		$.ajax({ // main ajax start
			url: ajax_url,
			type: 'post',
			data: $('#guest input[type=\'text\'], #guest input[type=\'checkbox\']:checked, #guest input[type=\'radio\']:checked, #guest textarea, #guest select<?php if (isset($checkout_blocks) && in_array("shipping", $checkout_blocks)) { ?>, #shipping-method input[type=\'radio\']:checked<?php } ?>'),
			dataType: 'json',
			beforeSend: function() {
				$('input[data-button-type=\'checkout\']').button('loading');
			},
			success: function(json) {
				masked('#guest .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart', false);
				$('#guest .smopc-alert, #guest .smopc-text-danger').remove();

				if (json['redirect']) {
					location = json['redirect'];
				} else if (json['error']) { // if json errors
					masked('#guest .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart', false);
					$('input[data-button-type=\'checkout\']').button('reset');

					if (json['error']['warning']) {
						$('#guest .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['warning'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
					}

					<?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>
					if (json['error']['select_shipping_method']) {
						$('#shipping-method .smopc-alert').remove();
						$('#shipping-method .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['select_shipping_method'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
					}

					if (json['error']['shipping_agree']) {
						$('#shipping-method .smopc-alert').remove();
						$('#shipping-method .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['shipping_agree'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
					}
					<?php } ?>

					if (json['error']['field']) {
            $.each(json['error']['field'], function(i, val) {
            	var element = $('#payment-new [name="' + i + '"]');
							if ($(element).parent().hasClass('smopc-input-group')) {
								$(element).parent().after('<div class="smopc-text-danger">' + val + '</div>');
							} else {
								$(element).after('<div class="smopc-text-danger">' + val + '</div>');
							}
            });

            $('#guest .smopc-text-danger').parent().addClass('smopc-has-error');
          } else {
          	$('#guest').find('div').removeClass('smopc-has-error');
          }

          if (json['error']['custom_fields']) {
            $.each(json['error']['custom_fields'], function(i, val) {
            	var element = $('#payment-new #input-payment-custom-field' + i);
							if ($(element).parent().hasClass('smopc-input-group')) {
								$(element).parent().after('<div class="smopc-text-danger">' + val + '</div>');
							} else {
								$(element).after('<div class="smopc-text-danger">' + val + '</div>');
							}
            });

            $('#guest .smopc-text-danger').parent().addClass('smopc-has-error');
          } else {
          	$('#guest').find('div').removeClass('smopc-has-error');
          }

					$('html, body').animate({ scrollTop: 0 }, 'slow');

				} else { // if not json errors
					masked('#guest .smopc-panel-body, #guest-shipping .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart', false);
					next_step_g = true;
				} // main ajax end

				$.ajax({ // shipping_address ajax start
					url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/shipping_address_save',
					type: 'post',
					data: $('#guest-shipping input[type=\'text\'], #guest-shipping input[type=\'checkbox\']:checked, #guest-shipping input[type=\'radio\']:checked, #guest-shipping textarea, #guest-shipping select<?php if (isset($checkout_blocks) && in_array("shipping", $checkout_blocks)) { ?>, #shipping-method input[type=\'radio\']:checked, #shipping-method input[type=\'checkbox\']:checked<?php } ?>'),
					dataType: 'json',
					beforeSend: function() {
						$('input[data-button-type=\'checkout\']').button('loading');
					},
					complete: function() {
						$('input[data-button-type=\'checkout\']').button('reset');
					},
					success: function(json) {
						$('#guest-shipping .smopc-alert, #guest-shipping .smopc-text-danger').remove();
						masked('#guest .smopc-panel-body, #guest-shipping .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart', false);

						if (json['error']) {
							if (json['error']['warning']) {
								$('#guest-shipping .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['warning'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
							}

							<?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>
							if (json['error']['select_shipping_method']) {
								$('#shipping-method .smopc-alert').remove();
								$('#shipping-method .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['select_shipping_method'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
							}

							if (json['error']['shipping_agree']) {
								$('#shipping-method .smopc-alert').remove();
								$('#shipping-method .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['shipping_agree'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
							}
							<?php } ?>

							if (json['error']['field']) {
		            $.each(json['error']['field'], function(i, val) {
		            	var element = $('#shipping-new [name="' + i + '"]');
									if ($(element).parent().hasClass('smopc-input-group')) {
										$(element).parent().after('<div class="smopc-text-danger">' + val + '</div>');
									} else {
										$(element).after('<div class="smopc-text-danger">' + val + '</div>');
									}
		            });

		            $('#guest-shipping .smopc-text-danger').parent().addClass('smopc-has-error');
		          } else {
		          	$('#guest-shipping').find('div').removeClass('smopc-has-error');
		          }

		          if (json['error']['custom_fields']) {
		            $.each(json['error']['custom_fields'], function(i, val) {
		            	var element = $('#shipping-new #input-payment-custom-field' + i);
									if ($(element).parent().hasClass('smopc-input-group')) {
										$(element).parent().after('<div class="smopc-text-danger">' + val + '</div>');
									} else {
										$(element).after('<div class="smopc-text-danger">' + val + '</div>');
									}
		            });

		            $('#guest-shipping .smopc-text-danger').parent().addClass('smopc-has-error');
		          } else {
		          	$('#guest-shipping').find('div').removeClass('smopc-has-error');
		          }

						} else {
							masked('#guest .smopc-panel-body, #guest-shipping .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart', false);
							next_step_gs = true;
						}

						if (next_step_g && next_step_gs) { // next step start
							<?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>
							save_shipping('#shipping-method', '#guest .smopc-panel-body, #guest-shipping .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart');
							<?php } ?>
							<?php if (isset($checkout_blocks) && in_array('payment', $checkout_blocks)) { ?>
							save_payment('#payment-method', '#guest .smopc-panel-body, #guest-shipping .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart');
							<?php } else { ?>
							$.ajax({
								url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/confirm',
								dataType: 'html',
								beforeSend: function() {
								  $('input[data-button-type=\'checkout\']').button('loading');
								},
								success: function(html) {
								  location.href = '<?php echo $success_page; ?>';
								  masked(refresh, false);
								  $('input[data-button-type=\'checkout\']').button('reset');
								}
							});
							<?php } ?>
						} // next step end
					}
				}); // shipping_address ajax end
			}
		});
	} else { // if user is guest (not registered)
		$.ajax({ // main ajax start
			url: ajax_url,
			type: 'post',
			data: $('#guest input[type=\'text\'], #guest input[type=\'password\'], #guest input[type=\'checkbox\']:checked, #guest input[type=\'radio\']:checked, #guest input[type=\'hidden\'], #guest textarea, #guest select<?php if (isset($checkout_blocks) && in_array("shipping", $checkout_blocks)) { ?>, #shipping-method input[type=\'radio\']:checked, #shipping-method input[type=\'checkbox\']:checked<?php } ?>'),
			dataType: 'json',
			beforeSend: function() {
				$('input[data-button-type=\'checkout\']').button('loading');
			},
			success: function(json) {
				masked('#guest .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart', false);
				$('#guest .smopc-alert, #guest .smopc-text-danger').remove();

				if (json['redirect']) {
					location = json['redirect'];
				} else if (json['error']) {
					masked('#guest .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart', false);
					$('input[data-button-type=\'checkout\']').button('reset');

					if (json['error']['warning']) {
						$('#guest .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['warning'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
					}
					
					<?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>
					if (json['error']['select_shipping_method']) {
						$('#shipping-method .smopc-alert').remove();
						$('#shipping-method .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['select_shipping_method'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
					}

					if (json['error']['shipping_agree']) {
						$('#shipping-method .smopc-alert').remove();
						$('#shipping-method .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['shipping_agree'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
					}
					<?php } ?>

					if (json['error']['field']) {
            $.each(json['error']['field'], function(i, val) {
            	var element = $('#payment-new [name="' + i + '"]');
							if ($(element).parent().hasClass('smopc-input-group')) {
								$(element).parent().after('<div class="smopc-text-danger">' + val + '</div>');
							} else {
								$(element).after('<div class="smopc-text-danger">' + val + '</div>');
							}
            });

            $('#guest .smopc-text-danger').parent().addClass('smopc-has-error');
          } else {
          	$('#guest').find('div').removeClass('smopc-has-error');
          }

          if (json['error']['custom_fields']) {
            $.each(json['error']['custom_fields'], function(i, val) {
            	var element = $('#payment-new #input-payment-custom-field' + i);
							if ($(element).parent().hasClass('smopc-input-group')) {
								$(element).parent().after('<div class="smopc-text-danger">' + val + '</div>');
							} else {
								$(element).after('<div class="smopc-text-danger">' + val + '</div>');
							}
            });

            $('#guest .smopc-text-danger').parent().addClass('smopc-has-error');
          } else {
          	$('#guest').find('div').removeClass('smopc-has-error');
          }

					$('html, body').animate({ scrollTop: 0 }, 'slow');

				} else {

					if (account_type == "register") {
						$.ajax({
	            url: 'index.php?route=checkout/ocdev_smart_one_page_checkout',
	            dataType: 'html',
	            success: function(data) {
	              $('#account-buttons').html($(data).find('#account-buttons > *'));
	              $('#checkout-buttons-top').html($(data).find('#checkout-buttons-top > *'));
	              $('#checkout-buttons-bottom').html($(data).find('#checkout-buttons-bottom > *'));
	              $('#guest').html($(data).find('#guest > *'));
	              $('#guest-shipping').show();
	              $('#guest-shipping').html($(data).find('#guest-shipping > *'));
	              <?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>
	              $('#shipping-method').html($(data).find('#shipping-method > *'));
	              <?php } ?>
	              <?php if (isset($checkout_blocks) && in_array('payment', $checkout_blocks)) { ?>
	              $('#payment-method').html($(data).find('#payment-method > *'));
	              <?php } ?>
	              <?php if (isset($checkout_blocks) && in_array('cart', $checkout_blocks)) { ?>$('#checkout-cart').html($(data).find('#checkout-cart > *'));<?php } ?>
	              $('input[data-button-type=\'checkout\']').button('reset');
	              $('input[data-button-type=\'checkout\']').val('<?php echo $button_checkout; ?>');
	              <?php if ($allow_custom_fields) { ?>sort_custom_fields();<?php } ?>
	            }
	          });
					}
					next_step_g = true;
				} // main ajax end

				if (account_type == "guest") { // if guest start
					var shipping_address = $('#guest input[name=\'shipping_address\']:checked').val();

					if (!shipping_address) { // if guest shipping_address start
						$.ajax({ // shipping_address ajax start
							url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/guest_shipping_save',
							type: 'post',
							data: $('#guest-shipping input[type=\'text\'], #guest-shipping select<?php if (isset($checkout_blocks) && in_array("shipping", $checkout_blocks)) { ?>, #shipping-method input[type=\'radio\']:checked, #shipping-method input[type=\'checkbox\']:checked<?php } ?>'),
							dataType: 'json',
							beforeSend: function() {
								$('input[data-button-type=\'checkout\']').button('loading');
							},
							complete: function() {
								$('input[data-button-type=\'checkout\']').button('reset');
							},
							success: function(json) {
								masked('#guest .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart', false);
								$('#guest-shipping .smopc-alert, #guest-shipping .smopc-text-danger').remove();

								if (json['error']) {
									if (json['error']['warning']) {
										$('#guest-shipping .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['warning'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
									}

									<?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>
									if (json['error']['select_shipping_method']) {
										$('#shipping-method .smopc-alert').remove();
										$('#shipping-method .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['select_shipping_method'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
									}

									if (json['error']['shipping_agree']) {
										$('#shipping-method .smopc-alert').remove();
										$('#shipping-method .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['shipping_agree'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
									}
									<?php } ?>

									if (json['error']['field']) {
				            $.each(json['error']['field'], function(i, val) {
				            	var element = $('#shipping-new [name="' + i + '"]');
											if ($(element).parent().hasClass('smopc-input-group')) {
												$(element).parent().after('<div class="smopc-text-danger">' + val + '</div>');
											} else {
												$(element).after('<div class="smopc-text-danger">' + val + '</div>');
											}
				            });

				            $('#guest-shipping .smopc-text-danger').parent().addClass('smopc-has-error');
				          } else {
				          	$('#guest-shipping').find('div').removeClass('smopc-has-error');
				          }

				          if (json['error']['custom_fields']) {
				            $.each(json['error']['custom_fields'], function(i, val) {
				            	var element = $('#shipping-new #input-payment-custom-field' + i);
											if ($(element).parent().hasClass('smopc-input-group')) {
												$(element).parent().after('<div class="smopc-text-danger">' + val + '</div>');
											} else {
												$(element).after('<div class="smopc-text-danger">' + val + '</div>');
											}
				            });

				            $('#guest-shipping .smopc-text-danger').parent().addClass('smopc-has-error');
				          } else {
				          	$('#guest-shipping').find('div').removeClass('smopc-has-error');
				          }

								} else {
									masked('#guest .smopc-panel-body, #guest-shipping .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart', true);
									next_step_gs = true;
								}

								if (next_step_g && next_step_gs) { // next step start
									<?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>
									save_shipping('#shipping-method', '#guest .smopc-panel-body, #guest-shipping .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart');
									<?php } ?>
									<?php if (isset($checkout_blocks) && in_array('payment', $checkout_blocks)) { ?>
									save_payment('#payment-method', '#guest .smopc-panel-body, #guest-shipping .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart');
									<?php } else { ?>
									$.ajax({
										url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/confirm',
										dataType: 'html',
										beforeSend: function() {
										  $('input[data-button-type=\'checkout\']').button('loading');
										},
										success: function(html) {
										  location.href = '<?php echo $success_page; ?>';
										  masked(refresh, false);
										  $('input[data-button-type=\'checkout\']').button('reset');
										}
									});
									<?php } ?>
								} // next step end
							}
						}); // shipping_address ajax end
					} else { // if guest shipping_address else
						masked('#guest .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart', false);

						if (next_step_g) { // next step start
							<?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>
							save_shipping('#shipping-method', '#guest .smopc-panel-body, #guest-shipping .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart');
							<?php } ?>
							<?php if (isset($checkout_blocks) && in_array('payment', $checkout_blocks)) { ?>
							save_payment('#payment-method', '#guest .smopc-panel-body, #guest-shipping .smopc-panel-body, #shipping-method, #payment-method, #checkout-cart');
							<?php } else { ?>
							$.ajax({
								url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/confirm',
								dataType: 'html',
								beforeSend: function() {
								  $('input[data-button-type=\'checkout\']').button('loading');
								},
								success: function(html) {
								  location.href = '<?php echo $success_page; ?>';
								  masked(refresh, false);
								  $('input[data-button-type=\'checkout\']').button('reset');
								}
							});
							<?php } ?>
						} // next step end
					} // if guest shipping_address end
				} // if guest end
			}
		});
	} // if user is registered end
});
// checkout function end
</script>
<script type="text/javascript"><!--
$(document).on('change', '#guest select[name=\'country_id\']', function() {
	$.ajax({
		url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#guest select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('.fa-spin').remove();
		},
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#guest input[name=\'postcode\']').parent().addClass('smopc-required');
			} else {
				$('#guest input[name=\'postcode\']').parent().removeClass('smopc-required');
			}
			html = '<option value=""><?php echo $text_select; ?></option>';
			if (json['zone'] && json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
					html += '<option value="' + json['zone'][i]['zone_id'] + '">' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			$('#guest select[name=\'zone_id\']').html(html);

			update_shipping();
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});
$('#guest select[name=\'country_id\']').trigger('change');
$(document).on('change', '#guest select[name=\'zone_id\']', function() {
	update_shipping();
});
$(document).on('change', '#guest-shipping select[name=\'country_id\']', function() {
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#guest-shipping select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('.fa-spin').remove();
		},
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#guest-shipping input[name=\'postcode\']').parent().addClass('smopc-required');
			} else {
				$('#guest-shipping input[name=\'postcode\']').parent().removeClass('smopc-required');
			}
			html = '<option value=""><?php echo $text_select; ?></option>';
			if (json['zone'] && json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
					html += '<option value="' + json['zone'][i]['zone_id'] + '"';
					html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			$('#guest-shipping select[name=\'zone_id\']').html(html);
		}
	});
});
$('#guest-shipping select[name=\'country_id\']').trigger('change');
$(document).on('change', '#guest-shipping select[name=\'zone_id\']', function() {
	update_guest_shipping();
});
//--></script>
<?php if ($allow_custom_fields) { ?>
<script type="text/javascript">
function sort_custom_fields() {
	$('#guest .smopc-form-group[data-sort]').detach().each(function() {
		if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#guest .smopc-form-group').length) {
			$('#guest .smopc-form-group').eq($(this).attr('data-sort')).before(this);
		}
		if ($(this).attr('data-sort') > $('#guest .smopc-form-group').length) {
			$('#guest .smopc-form-group:last').after(this);
		}
		if ($(this).attr('data-sort') < -$('#guest .smopc-form-group').length) {
			$('#guest .smopc-form-group:first').before(this);
		}
	});

	$('#guest-shipping .smopc-form-group[data-sort]').detach().each(function() {
		if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#guest-shipping .smopc-form-group').length) {
			$('#guest-shipping .smopc-form-group').eq($(this).attr('data-sort')).before(this);
		}
		if ($(this).attr('data-sort') > $('#guest-shipping .smopc-form-group').length) {
			$('#guest-shipping .smopc-form-group:last').after(this);
		}
		if ($(this).attr('data-sort') < -$('#guest-shipping .smopc-form-group').length) {
			$('#guest-shipping .smopc-form-group:first').before(this);
		}
	});
}

$('.date').datetimepicker({
	pickTime: false
});

$('.time').datetimepicker({
	pickDate: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});
</script>
<script type="text/javascript"><!--
$(document).on('click', 'button[id^=\'button-payment-custom-field\']', function() {
	var node = this;
	$('#form-upload').remove();
	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
	$('#form-upload input[name=\'file\']').trigger('click');
	if (typeof timer != 'undefined') {
    clearInterval(timer);
	}
	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);
			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$(node).parent().find('.smopc-text-danger').remove();
					if (json['error']) {
						$(node).parent().find('input[name^=\'custom_field\']').after('<div class="smopc-text-danger">' + json['error'] + '</div>');
					}
					if (json['success']) {
						alert(json['success']);
						$(node).parent().find('input[name^=\'custom_field\']').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<?php } ?>
<script type="text/javascript">
// get account type start
$(document).on('change', '#account-buttons input[name=\'account\']', function() {
	$('input[data-button-type=\'checkout\']').val('<?php echo $button_checkout; ?>');
	var account_type = $('input[name=\'account\']:checked').val();
	$('#login, #password').slideUp();
	if (account_type == "login") {
		$('#login').slideDown();
	} else if (account_type == "register") {
		$('#password').slideDown();
		$('input[data-button-type=\'checkout\']').val('<?php echo $button_register; ?>');
	} else if (account_type == "logout") {
		$.ajax({
	    url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/logout',
	    dataType: 'json',
	    success: function(json) {
	    	if (json['redirect']) {
					masked('#guest .smopc-panel-body, #guest-shipping, #shipping-method, #payment-method, #checkout-cart', true);
	    		location = json['redirect'];
	    	}
	    }
	  });
	}
});
// get account type end
</script>
<?php if ($allow_custom_fields) { ?>
<script type="text/javascript">
// sort custom fields start
sort_custom_fields();
// sort custom fields end
</script>
<?php } ?>
<?php echo $footer; ?>