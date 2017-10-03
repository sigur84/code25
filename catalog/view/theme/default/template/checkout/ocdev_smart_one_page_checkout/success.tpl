<?php echo $header; ?>
<!--
@category  : OpenCart
@module    : Smart One Page Chekout
@author    : OCdevWizard <ocdevwizard@gmail.com>
@copyright : Copyright (c) 2015, OCdevWizard
@license   : http://license.ocdevwizard.com/Licensing_Policy.pdf
-->
<div class="container">
  <ul class="breadcrumb">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
	<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
	<?php } ?>
  </ul>
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
	<div id="text-success"><?php echo $text_success; ?></div>
	<br/>
  <?php if ($order_status) { ?>
	  <?php if ($show_table_order_details) { ?>
		 <table class="smopc-table smopc-table-bordered smopc-table-hover smopc_list">
		   <thead>
			 <tr>
			   <td class="smopc-text-left" colspan="2"><?php echo $text_order_detail; ?></td>
			 </tr>
		   </thead>
		   <tbody>
			 <tr>
			   <td class="smopc-text-left" style="width:50%;">
				  <?php if ($invoice_no) { ?>
					 <b><?php echo $text_invoice_no; ?></b> <?php echo $invoice_no; ?><br />
				  <?php } ?>
				  <b><?php echo $text_order_id; ?></b> #<?php echo $order_id; ?>
				  <br />
				  <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?>
			   </td>
			   <td class="smopc-text-left" style="width:50%;">
				  <?php if ($payment_method) { ?>
					 <b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?><br />
				  <?php } ?>
				  <?php if ($shipping_method) { ?>
					 <b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>
				  <?php } ?>
			   </td>
			 </tr>
		   </tbody>
		 </table>
	  <?php } ?>
	  <?php if ($show_table_payment_address || $show_table_shipping_address) { ?>
		 <table class="smopc-table smopc-table-bordered smopc-table-hover smopc_list">
		   <thead>
			 <tr>
			   <?php if ($show_table_payment_address) { ?>
			   <td class="smopc-text-left"><?php echo $text_payment_address; ?></td>
			   <?php } ?>
			   <?php if ($shipping_address && $show_table_shipping_address) { ?>
			   <td class="smopc-text-left"><?php echo $text_shipping_address; ?></td>
			   <?php } ?>
			 </tr>
		   </thead>
		   <tbody>
			 <tr>
			   <?php if ($show_table_payment_address) { ?>
			   <td class="smopc-text-left"><?php echo $payment_address; ?></td>
			   <?php } ?>
			   <?php if ($shipping_address && $show_table_shipping_address) { ?>
			   <td class="smopc-text-left"><?php echo $shipping_address; ?></td>
			   <?php } ?>
			 </tr>
		   </tbody>
		 </table>
	  <?php } ?>
	  <?php if ($show_table_products) { ?>
	<div class="smopc-table-responsive">
		 <table class="smopc-table smopc-table-bordered smopc-table-hover smopc_list">
		   <thead>
			 <tr>
			   <?php if ($hide_table_img) { ?>
			   <td class="smopc-text-left"><?php echo $column_image; ?></td>
			   <?php } ?>
			   <td class="smopc-text-left"><?php echo $column_name; ?></td>
			   <td class="smopc-text-left"><?php echo $column_model; ?></td>
			   <td class="smopc-text-right"><?php echo $column_quantity; ?></td>
			   <td class="smopc-text-right"><?php echo $column_price; ?></td>
			   <td class="smopc-text-right"><?php echo $column_total; ?></td>
			 </tr>
		   </thead>
		   <tbody>
			 <?php foreach ($products as $product) { ?>
			 <tr>
			   <?php if ($hide_table_img) { ?>
			   <td class="smopc-text-left"><a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></td>
			   <?php } ?>
			   <td class="smopc-text-left"><a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><?php echo $product['name']; ?></a>
				 <?php foreach ($product['option'] as $option) { ?>
				 <br />
				 &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
				 <?php } ?></td>
			   <td class="smopc-text-left"><?php echo $product['model']; ?></td>
			   <td class="smopc-text-right"><?php echo $product['quantity']; ?></td>
			   <td class="smopc-text-right"><?php echo $product['price']; ?></td>
			   <td class="smopc-text-right"><?php echo $product['total']; ?></td>
			 </tr>
			 <?php } ?>
			 <?php foreach ($vouchers as $voucher) { ?>
			  <tr>
				<td class="smopc-text-left"><?php echo $voucher['description']; ?></td>
				<td class="smopc-text-left"></td>
				<td class="smopc-text-right">1</td>
				<td class="smopc-text-right"><?php echo $voucher['amount']; ?></td>
				<td class="smopc-text-right"><?php echo $voucher['amount']; ?></td>
			  </tr>
			 <?php } ?>
		   </tbody>
		   <tfoot>
			<?php foreach ($totals as $total) { ?>
			  <tr>
				<td colspan="4"></td>
				<td class="smopc-text-right"><b><?php echo $total['title']; ?></b></td>
				<td class="smopc-text-right"><?php echo $total['text']; ?></td>
			  </tr>
			<?php } ?>
		   </tfoot>
		 </table>
	 </div>
	  <?php } ?>
	  <?php if ($show_comment && $comment) { ?>
		<table class="smopc-table smopc-table-bordered smopc-table-hover smopc_list">
		  <thead>
			<tr>
			  <td class="smopc-text-left"><?php echo $text_comment; ?></td>
			</tr>
		  </thead>
		  <tbody>
			<tr>
			  <td class="smopc-text-left"><?php echo $comment; ?></td>
			</tr>
		  </tbody>
		</table>
	  <?php } ?>
	 	<?php if ($payment_instructions) { ?>
		<table class="smopc-table smopc-table-bordered smopc-table-hover smopc_list">
		  <thead>
			<tr>
			  <td class="smopc-text-left"><?php echo $text_payment_instructions; ?></td>
			</tr>
		  </thead>
		  <tbody>
			<tr>
			  <td class="smopc-text-left"><?php echo $payment_instructions; ?></td>
			</tr>
		  </tbody>
		</table>
	  <?php } ?>
	  <?php if ($gift_coupon_code) { ?>
		<table class="smopc-table smopc-table-bordered smopc-table-hover smopc_list">
		  <thead>
			<tr>
			  <td class="smopc-text-left"><?php echo $text_gift_coupon_code; ?></td>
			</tr>
		  </thead>
		  <tbody>
			<tr>
			  <td class="smopc-text-left"><?php echo $gift_coupon_code; ?></td>
			</tr>
		  </tbody>
		</table>
	  <?php } ?>
	<?php if ($check && $check != 0) { ?>
	<h3><?php echo $recommended_products_heading_title; ?></h3>
	<div class="smopc-row product-layout">
	  <?php foreach ($recommended_products as $product) { ?>
	  <div class="smopc-col-lg-3 smopc-col-md-3 smopc-col-sm-6 smopc-col-xs-12">
	  <div class="product-thumb transition">
	  <?php if ($hide_sub_img) { ?>
		<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
		<?php } ?>
		<div class="caption">
		<h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
		<p><?php echo $product['description']; ?></p>
		<?php if ($product['rating']) { ?>
		<div class="rating">
		  <?php for ($i = 1; $i <= 5; $i++) { ?>
		  <?php if ($product['rating'] < $i) { ?>
		  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
		  <?php } else { ?>
		  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
		  <?php } ?>
		  <?php } ?>
		</div>
		<?php } ?>
		<?php if ($product['price']) { ?>
		<p class="price">
		  <?php if (!$product['special']) { ?>
		  <?php echo $product['price']; ?>
		  <?php } else { ?>
		  <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
		  <?php } ?>
		  <?php if ($product['tax']) { ?>
		  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
		  <?php } ?>
		</p>
		<?php } ?>
		</div>
		<div class="button-group">
		<button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
		<button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
		<button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
		</div>
	  </div>
	  </div>
	  <?php } ?>
	</div>
	<?php } ?>
  <?php } else { ?>
	<div class="content"><?php echo $text_order_empty; ?></div>
  <?php } ?>
  <?php if ($show_button_print || $show_button_continue) { ?>
  <div class="smopc-buttons">
	<?php if ($show_button_print && $order_status) { ?>
	  <div class="smopc-pull-left"><input type="button" value="<?php echo $button_print_order; ?>" onclick="window.print()" class="smopc-btn smopc-btn-primary" /></div>
	<?php } ?>
	<?php if ($show_button_continue) { ?>
	  <div class="smopc-pull-right"><a href="<?php echo $continue; ?>" class="smopc-btn smopc-btn-primary"><?php echo $button_continue_shopping; ?></a></div>
	<?php } ?>
  </div>
  <?php } ?>
  <?php if ($custom_css) { ?>
	<style rel="stylesheet" type="text/css" media="print"><?php echo htmlspecialchars_decode($custom_css); ?></style>
  <?php } ?>
  <?php if ($allow_google_analytics || $allow_google_event) { ?>
  <script type="application/javascript">
	<?php if ($allow_google_analytics) { ?>
	  ga('require', 'ecommerce');
	  ga('ecommerce:addTransaction', {
		'id': '<?php echo $ga_order_id; ?>',
		'affiliation': '<?php echo $ga_affiliation; ?>',
		'revenue': '<?php echo $ga_revenue; ?>',
		'tax': '<?php echo $ga_tax; ?>',
		'currency': '<?php echo $ga_currency; ?>'
	  });
	  <?php if ($products) { ?>
		<?php foreach ($products as $product) { ?>
		ga('ecommerce:addItem', {
		  'id': '<?php echo $product["product_id"]; ?>',
		  'name': '<?php echo $product["name"]; ?>',
		  'sku': '<?php echo $product["sku"]; ?>',
		  'price': '<?php echo $product["ga_price"]; ?>',
		  'quantity': '<?php echo $product["quantity"]; ?>'
		});
		<?php } ?>
	  <?php } ?>
	  ga('ecommerce:send');
	<?php } ?>
	<?php if ($allow_google_event) { ?>
	  ga('send', 'event', '<?php echo $ga_e_category; ?>', '<?php echo $ga_e_action; ?>', '<?php echo $ga_e_name; ?>', '<?php echo $ga_e_order_id; ?>');
	<?php } ?>
  </script>
  <?php } ?>
	  <?php echo $content_bottom; ?></div>
	<?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
