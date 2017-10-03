<?php 
	global $config, $lazyload_status, $registry, $db, $session;
	$store_id = $config->get('config_store_id');
	if ($store_id == 0) {
        $soconfig_general = $config->get('soconfig_general');
		
    } else {
		$soconfig_general = $config->get('soconfig_general_store');
		if (isset($soconfig_general[$store_id]['scroll_animation'])) 	{$soconfig_general['scroll_animation'] = $soconfig_general[$store_id]['scroll_animation'];}
	
	}
	$lazyload_status = $soconfig_general["scroll_animation"];
	$lazyload_text = ($lazyload_status == 1 )? 'lazy' : '';
	
?>
<div class="module latest-product icon-style">
 
		<h3 class="modtitle">
		<i class="fa fa-tags"></i>
		<?php echo $heading_title; ?></h3>
	
  <div class="modcontent clearfix">
    <?php foreach ($products as $product) { 
		$thumb = ($lazyload_status == 1) ? 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7' : $product['thumb'];
	?>
    
      <div class="product-latest-item transition">
        <div class="media">
        <div class="media-left"><a class="<?php echo $lazyload_text?>" href="<?php echo $product['href']; ?>"><img data-src="<?php echo $product['thumb'];?>" src="<?php echo $thumb; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
       <div class="media-body">
          <div class="caption">
            <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
            <div class="description"><?php echo $product['description']; ?></div>
            <?php if ($product['price']) { ?>
            <div class="price">
              <?php if (!$product['special']) { ?>
               <span class="price-new"><?php echo $product['price']; ?></span>
              <?php } else { ?>
              <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
              <?php } ?>
              <?php if ($product['tax']) { ?>
              <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
              <?php } ?>
            </div>
            <?php } ?>
            <div class="ratings">
                <div class="rating-box">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($product['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
                </div>
            </div>
            
          </div>
          <div class="button-group">
            <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
            <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
            <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
          </div>
        </div>
        </div>
      </div>
    
    <?php } ?>
  </div>
</div>
