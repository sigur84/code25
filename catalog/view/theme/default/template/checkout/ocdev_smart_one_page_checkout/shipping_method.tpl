<div class="smopc-panel-group smopc-col-sm-6">
	<div class="smopc-panel smopc-panel-default">
		<div class="smopc-panel-heading"><h4 class="smopc-panel-title"><i class="fa fa-truck"></i> <?php echo $heading_shipping_block; ?></h4></div>
		<div class="smopc-panel-collapse" id="shipping-method">
			<div class="smopc-panel-body">
				<?php if ($error_warning_shipping) { ?>
				<div class="smopc-alert alert smopc-alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning_shipping; ?></div>
				<?php } ?>
				<?php if ($shipping_methods) { ?>
					<p><?php echo $text_shipping_method; ?></p>
					<?php if ($display_shipping_type == 1) { ?>
						<?php foreach ($shipping_methods as $shipping_method) { ?>
							<?php if ($display_shipping_heading) { ?><p><strong><?php echo $shipping_method['title']; ?></strong></p><?php } ?>
							<?php if (!$shipping_method['error']) { ?>
							<?php foreach ($shipping_method['quote'] as $quote) { ?>
							<div class="smopc-radio">
								<label>
									<?php if ($quote['code'] == $code_s || !$code_s) { ?>
									<?php $code_s = $quote['code']; ?>
									<input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" checked="checked" onchange="save_shipping('#shipping-method', '#shipping-method, #checkout-cart', 'onload');" />
									<?php } else { ?>
									<input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" onchange="save_shipping('#shipping-method', '#shipping-method, #checkout-cart', 'onload');" />
									<?php } ?>
									<?php echo $quote['title']; ?> - <?php echo $quote['text']; ?>
								</label>
							</div>
							<?php } ?>
							<?php } else { ?>
							<div class="smopc-alert alert smopc-alert-danger"><?php echo $shipping_method['error']; ?></div>
							<?php } ?>
						<?php } ?>
					<?php } else { ?>
						<select name="shipping_method" class="smopc-form-control" onchange="save_shipping('#shipping-method', '#shipping-method, #checkout-cart', 'onload');">
							<?php foreach ($shipping_methods as $shipping_method) { ?>
								<?php if ($display_shipping_heading) { ?><optgroup label="<?php echo $shipping_method['title']; ?>" <?php echo ($shipping_method['error']) ? 'disabled' : ''; ?>><?php } ?>
								<?php if (!$shipping_method['error']) { ?>
								<?php foreach ($shipping_method['quote'] as $quote) { ?>
								<?php if ($quote['code'] == $code_s || !$code_s) { ?>
									<?php $code_s = $quote['code']; ?>
									<option value="<?php echo $quote['code']; ?>" selected="selected" <?php echo ($shipping_method['error']) ? 'disabled' : ''; ?>><?php echo $quote['title']; ?> - <?php echo $quote['text']; ?></option>
								<?php } else { ?>
									<option value="<?php echo $quote['code']; ?>" <?php echo ($shipping_method['error']) ? 'disabled' : ''; ?>><?php echo $quote['title']; ?> - <?php echo $quote['text']; ?></option>
								<?php } ?>
								<?php } ?>
								<?php } ?>
								<?php if ($display_shipping_heading) { ?></optgroup><?php } ?>
							<?php } ?>
						</select>
					<?php } ?>
				<?php } ?>
			</div>
			<?php if ($text_agree) { ?>
			<div class="smopc-panel-footer">
				<input type="hidden" name="skip_shipping_agree" value="1" />
				<input type="checkbox" name="shipping_agree" value="1" <?php echo ($shipping_agree) ? 'checked="checked"' : ''; ?> onchange="save_shipping('#shipping-method', '#shipping-method', 'onload');" />
				<?php echo $text_agree; ?>
			</div>
			<?php } ?>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
// multi-function for save shipping data start
function save_shipping(block, refresh, type) {
	masked(refresh, true);
	if (type == "onload") {
		$.ajax({
			url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/shipping_save',
			type: 'post',
			data: $(block + ' input[type=\'radio\']:checked, ' + block + ' input[type=\'hidden\'], ' + block + ' input[type=\'checkbox\']:checked, ' + block + ' select'),
			dataType: 'json',
			success: function(json) {
				$(block + ' .smopc-alert, ' + block + ' .smopc-text-danger').remove();

				if (json['error']) {
					masked(refresh, false);
					if (json['error']['warning']) {
						$(block + ' .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['warning'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
					}
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				} else {
					$.ajax({
						url: 'index.php?route=checkout/ocdev_smart_one_page_checkout',
						dataType: 'html',
						success: function(data) {
							$(block).html($(data).find(block + ' > *'));
							<?php if (isset($checkout_blocks) && in_array('cart', $checkout_blocks)) { ?>$('#checkout-cart').html($(data).find('#checkout-cart > *'));<?php } ?>
							masked(refresh, false);
						}
					});
				}
			}
		});
	} else {
		$.ajax({
			url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/shipping_save',
			type: 'post',
			data: $(block + ' input[type=\'radio\']:checked, ' + block + ' input[type=\'checkbox\']:checked, ' + block + ' select'),
			dataType: 'json',
			beforeSend: function() {
				$('input[data-button-type=\'checkout\']').button('loading');
			},
			complete: function() {
				$('input[data-button-type=\'checkout\']').button('reset');
			},
			success: function(json) {
				$(block + ' .smopc-alert, ' + block + ' .smopc-text-danger').remove();

				$('input[data-button-type=\'checkout\']').button('reset');

				if (json['error']) {
					masked(refresh, false);
					$('input[data-button-type=\'checkout\']').button('reset');

					if (json['error']['warning']) {
						$(block + ' .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['warning'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
					}
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				} else {
					$.ajax({
						url: 'index.php?route=checkout/ocdev_smart_one_page_checkout',
						dataType: 'html',
						success: function(data) {
							$(block).html($(data).find(block + ' > *'));
							masked(refresh, false);
						}
					});
				}
			}
		});
	}
}
// multi-function for save shipping data end
// update shipping data start
function update_shipping() {
	var country_id = $('#guest select[name=\'country_id\']').val(),
			zone_id = $('#guest select[name=\'zone_id\']').val();

	masked('#shipping-method', true);
	$.ajax({
		url: 'index.php?route=checkout/ocdev_smart_one_page_checkout&country_id=' + ((typeof(country_id) != 'undefined' || country_id != "") ? country_id : 0) + '&zone_id=' + ((typeof(zone_id) != 'undefined' || zone_id != "") ? zone_id : 0),
		dataType: 'html',
		success: function(data) {
			masked('#shipping-method', false);
			$('#shipping-method').html($(data).find('#shipping-method > *'));
		}
	});
}
function update_guest_shipping() {
	var country_id = $('#guest-shipping select[name=\'country_id\']').val(),
			zone_id = $('#guest-shipping select[name=\'zone_id\']').val();

	masked('#shipping-method', true);
	$.ajax({
		url: 'index.php?route=checkout/ocdev_smart_one_page_checkout&country_id=' + ((typeof(country_id) != 'undefined' || country_id != "") ? country_id : 0) + '&zone_id=' + ((typeof(zone_id) != 'undefined' || zone_id != "") ? zone_id : 0),
		dataType: 'html',
		success: function(data) {
			masked('#shipping-method', false);
			$('#shipping-method').html($(data).find('#shipping-method > *'));
		}
	});
}
// update shipping data end
//--></script>