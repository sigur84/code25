<div class="smopc-panel-group smopc-col-sm-6">
	<div class="smopc-panel smopc-panel-default">
		<div class="smopc-panel-heading"><h4 class="smopc-panel-title"><i class="fa fa-credit-card"></i> <?php echo $heading_payment_block; ?></h4></div>
		<div class="smopc-panel-collapse" id="payment-method">
			<div class="smopc-panel-body">
				<?php if ($error_warning_payment) { ?>
				<div class="smopc-alert alert smopc-alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning_payment; ?></div>
				<?php } ?>
				<?php if ($payment_methods) { ?>
				<p><?php echo $text_payment_method; ?></p>
				<?php if ($display_payment_type == 1) { ?>
					<?php foreach ($payment_methods as $payment_method) { ?>
					<div class="smopc-radio">
						<label>
							<?php if ($payment_method['code'] == $code_p || !$code_p) { ?>
							<?php $code_p = $payment_method['code']; ?>
							<input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" checked="checked" onchange="save_payment('#payment-method', '#payment-method', 'onload');" />
							<?php } else { ?>
							<input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" onchange="save_payment('#payment-method', '#payment-method', 'onload');" />
							<?php } ?>
							<?php echo $payment_method['title']; ?>
							<?php if ($payment_method['terms']) { ?>
							(<?php echo $payment_method['terms']; ?>)
							<?php } ?>
						</label>
					</div>
					<?php } ?>
				<?php } else { ?>
					<select name="payment_method" class="smopc-form-control" onchange="save_payment('#payment-method', '#payment-method', 'onload');">
					<?php foreach ($payment_methods as $payment_method) { ?>
						<?php if ($payment_method['code'] == $code_p || !$code_p) { ?>
							<?php $code_p = $payment_method['code']; ?>
							<option value="<?php echo $payment_method['code']; ?>" selected="selected"><?php echo $payment_method['title']; ?><?php if ($payment_method['terms']) { ?>(<?php echo $payment_method['terms']; ?>)<?php } ?></option>
						<?php } else { ?>
							<option value="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?><?php if ($payment_method['terms']) { ?>(<?php echo $payment_method['terms']; ?>)<?php } ?></option>
						<?php } ?>
					<?php } ?>
					</select>
				<?php } ?>
				<?php } ?>
			</div>
			<?php if ($text_agree) { ?>
			<div class="smopc-panel-footer">
				<input type="hidden" name="skip_payment_agree" value="1" />
				<input type="checkbox" name="payment_agree" value="1" <?php echo ($payment_agree) ? 'checked="checked"' : ''; ?> onchange="save_payment('#payment-method', '#payment-method', 'onload');" />
				<?php echo $text_agree; ?>
			</div>
			<?php } ?>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
// multi-function for save payment data start
function save_payment(block, refresh, type) {
	masked(refresh, true);
	$('#checkout-buttons-bottom').show();
	$('input[data-button-type=\'checkout\']').button('reset');
	if (type == "onload") {
		$.ajax({
			url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/payment_save',
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
							$('#bottom-payment-block').html($(data).find('#bottom-payment-block > *'));
							masked(refresh, false);
						}
					});
				}
			}
		});
	} else {
		$.ajax({
			url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/payment_save',
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

				if (json['error']) {
					masked(refresh, false);
					$('input[data-button-type=\'checkout\']').button('reset');

					if (json['error']['warning']) {
						$(block + ' .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-warning">' + json['error']['warning'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
					}
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				} else {
					$.ajax({
						url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/confirm',
						dataType: 'html',
						success: function(data) {
							$('#bottom-payment-block').show();
							$('input[data-button-type=\'checkout\']').button('loading');
							$('#payment').html(data);
							<?php if ($cancel_button == 2 || $cancel_button == 3) { ?>
								$('#payment').find('.buttons').last().append('<a href="<?php echo $continue; ?>" class="smopc-btn smopc-btn-default"><?php echo $button_cancel; ?></a>');
							<?php } ?>
							$('#checkout-buttons-bottom').hide();
							var pay_form = $('#payment form').html();
							if (typeof(pay_form) === "undefined" || pay_form == "") {
								$('#button-confirm').click();
							}
							masked(refresh, false);
						}
					});
				}
			}
		});
	}
}
// multi-function for save payment data end
//--></script>