<div class="smopc-panel-group" id="checkout-cart">
	<div class="smopc-panel smopc-panel-default">
		<div class="smopc-panel-heading">
			<h4 class="smopc-panel-title"><?php echo $heading_cart_block; ?><?php if ($weight) { ?>&nbsp;(<?php echo $weight; ?>)<?php } ?></h4>
		</div>
		<div class="smopc-panel-collapse">
			<div class="smopc-panel-body">
				<?php if ($attention_cart) { ?>
				<div class="smopc-alert alert smopc-alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention_cart; ?>
					<button type="button" class="smopc-close" data-dismiss="alert">&times;</button>
				</div>
				<?php } ?>
				<?php if ($error_warning_cart) { ?>
				<div class="smopc-alert alert smopc-alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning_cart; ?>
					<button type="button" class="smopc-close" data-dismiss="alert">&times;</button>
				</div>
				<?php } ?>
				<div class="smopc-table-responsive">
					<table class="smopc-table smopc-table-bordered">
						<thead>
							<tr>
								<?php if ($hide_main_img) { ?><td class="smopc-text-center"><?php echo $column_image; ?></td><?php } ?>
								<td class="smopc-text-left"><?php echo $column_name; ?></td>
								<td class="smopc-text-left" style="width:21%;"><?php echo $column_quantity; ?></td>
								<td class="smopc-text-right"><?php echo $column_price; ?></td>
								<td class="smopc-text-right"><?php echo $column_total; ?></td>
								<td class="smopc-text-center"><?php echo $column_remove; ?></td>
							</tr>
						</thead>
						<tbody>
							<?php foreach ($products as $product) { ?>
							<tr>
								<?php if ($hide_main_img) { ?>
								<td class="smopc-text-center"><?php if ($product['thumb']) { ?>
									<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
									<?php } ?>
								</td>
								<?php } ?>
								<td class="smopc-text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
									<?php if (!$product['stock']) { ?>
									<span class="smopc-text-danger">***</span>
									<?php } ?>
									<?php if ($product['option']) { ?>
									<?php foreach ($product['option'] as $option) { ?>
									<br />
									<small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
									<?php } ?>
									<?php } ?>
									<?php if ($product['reward']) { ?>
									<br />
									<small><?php echo $product['reward']; ?></small>
									<?php } ?>
									<?php if ($product['recurring']) { ?>
									<br />
									<span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
									<?php } ?>
								</td>
								<td class="smopc-text-left">
									<input name="product_id_q" value="<?php echo $product['product_id']; ?>" style="display: none;" type="hidden" />
									<input name="product_id" value="<?php echo $product['key']; ?>" style="display: none;" type="hidden" />
									<div class="smopc-input-group smopc-btn-block" style="max-width: 50px;">
										<span class="smopc-input-group-btn">
										<a onclick="$(this).parent().next().val(~~$(this).parent().next().val()-1); update_cart(this, 'update');" class="smopc-btn smopc-btn-primary"><i class="fa fa-minus"></i></a>
										</span>
										<input type="text" name="quantity" value="<?php echo $product['quantity']; ?>" size="1" class="smopc-form-control" onchange="update_cart_input(this, '<?php echo $product['key']; ?>'); return validate_input(this);" onkeyup="update_cart_input(this, '<?php echo $product['key']; ?>'); return validate_input(this);" />
										<span class="smopc-input-group-btn">
										<a onclick="$(this).parent().prev().val(~~$(this).parent().prev().val()+1); update_cart(this, 'update');" class="smopc-btn smopc-btn-primary"><i class="fa fa-plus"></i></a>
										</span>
									</div>
								</td>
								<td class="smopc-text-right"><?php echo $product['price']; ?></td>
								<td class="smopc-text-right"><?php echo $product['total']; ?></td>
								<td class="smopc-text-center"><a onclick="update_cart(this, 'remove');" class="smopc-btn smopc-btn-danger"><i class="fa fa-times-circle"></i></a></td>
							</tr>
							<?php } ?>
							<?php foreach ($vouchers as $vouchers) { ?>
							<tr>
								<td></td>
								<td class="smopc-text-left"><?php echo $vouchers['description']; ?></td>
								<td class="smopc-text-left"></td>
								<td class="smopc-text-left"><div class="smopc-input-group smopc-btn-block" style="max-width: 200px;">
										<input type="text" name="" value="1" size="1" disabled="disabled" class="smopc-form-control" />
										<span class="smopc-input-group-btn"><button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="smopc-btn smopc-btn-danger" onclick="voucher.remove('<?php echo $vouchers['key']; ?>');"><i class="fa fa-times-circle"></i></button></span></div></td>
								<td class="smopc-text-right"><?php echo $vouchers['amount']; ?></td>
								<td class="smopc-text-right"><?php echo $vouchers['amount']; ?></td>
							</tr>
							<?php } ?>
						</tbody>
						<tfoot>
							<?php foreach ($totals as $total) { ?>
							<tr>
								<td class="smopc-text-right" colspan="<?php echo (!$hide_main_img) ? '3' : '4'; ?>"><strong><?php echo $total['title']; ?>:</strong></td>
								<td class="smopc-text-right"><?php echo $total['text']; ?></td>
								<td class="smopc-text-left"></td>
							</tr>
							<?php } ?>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
// update cart finctions start
function update_cart(target, status) {
	masked('#checkout-cart', true);
	var input_val    = $(target).parent().parent().children('input[name=quantity]').val(),
			quantity     = parseInt(input_val),
			product_id   = $(target).parent().parent().parent().children('input[name=product_id]').val(),
			product_id_q = $(target).parent().parent().parent().children('input[name=product_id_q]').val(),
			product_key  = $(target).parent().prev().prev().prev().children('input[name=product_id]').val(),
			urls         = null;

	if (quantity <= 0) {
		masked('#checkout-cart', false);
		quantity = $(target).parent().parent().children('input[name=quantity]').val(1);
		return;
	}

	if (status == 'update') {
		urls = 'index.php?route=checkout/ocdev_smart_one_page_checkout&update=' + product_id + '&quantity=' + quantity;
	} else if (status == 'add') {
		urls = 'index.php?route=checkout/ocdev_smart_one_page_checkout&add=' + target + '&quantity=1';
	} else {
		urls = 'index.php?route=checkout/ocdev_smart_one_page_checkout&remove=' + product_key;
	}

	$.ajax({
		url: urls,
		type: 'get',
		dataType: 'html',
		beforeSend: function() {
			$(target).html('<i class="fa fa-refresh fa-spin"></i>');
		},
		success: function(data) {
			$.ajax({
				url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/status_cart',
				type: 'get',
				dataType: 'json',
				success: function(json) {
					masked('#checkout-cart', false);
					if (json['total']) {
						setTimeout(function () {
							$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
						}, 100);
						$('#cart > ul').load('index.php?route=common/cart/info ul li');
					}
					if (!json['redirect']) {
						$('input[data-button-type=\'checkout\']').removeClass('disabled');

						<?php if (isset($checkout_blocks) && in_array('payment', $checkout_blocks)) { ?>save_payment('#payment-method', '#payment-method', "onload");<?php } ?>
						$('#checkout-cart').html($(data).find('#checkout-cart > *'));
						$('#shipping-method').html($(data).find('#shipping-method > *'));
						<?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>save_shipping('#shipping-method', '#shipping-method, #checkout-cart', "onload");<?php } ?>
					} else {
						location = json['redirect'];
					}
				}
			});
		}
	});
}

function update_cart_input(target, product_id) {
	masked('#checkout-cart', true);
	var input_val = $(target).val(),
			quantity  = parseInt(input_val);

	if (quantity <= 0) {
		masked('#checkout-cart', false);
		quantity = $(target).val(1);
		return;
	}

	$.ajax({
		url: 'index.php?route=checkout/ocdev_smart_one_page_checkout&update=' + product_id + '&quantity=' + quantity,
		type: 'get',
		dataType: 'html',
		success: function(data) {
			$.ajax({
				url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/status_cart',
				type: 'get',
				dataType: 'json',
				success: function(json) {
					masked('#checkout-cart', false);
					if (json['total']) {
						setTimeout(function () {
							$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
						}, 100);
						$('#cart > ul').load('index.php?route=common/cart/info ul li');
					}
					if (!json['redirect']) {
						$('input[data-button-type=\'checkout\']').removeClass('disabled');
						<?php if (isset($checkout_blocks) && in_array('shipping', $checkout_blocks)) { ?>save_shipping('#shipping-method', '#shipping-method, #checkout-cart', "onload");<?php } ?>
						<?php if (isset($checkout_blocks) && in_array('payment', $checkout_blocks)) { ?>save_payment('#payment-method', '#payment-method', "onload");<?php } ?>
						$('#checkout-cart').html($(data).find('#checkout-cart > *'));
						$('#shipping-method').html($(data).find('#shipping-method > *'));
					} else {
						location = json['redirect'];
					}
				}
			});
		}
	});
}
// update cart finctions end
//--></script>
