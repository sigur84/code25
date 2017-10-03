<?php foreach ($products as $product) { ?>
<div class="product-layout product-list col-xs-12 col-sm-3 col-md-3">
<div class="product-layout <?php echo $device_res;?>">
  <div class="product-thumb product-item-container">
  <div class="left-block">
    <div class="product-image-container <?php echo $lazyload_text?> <?php if($secondimg =='2' && isset($product['thumb2'])){ echo "second_img";} ?> "><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
    <div>
    </div>
    <div class="right-block">
      <div class="caption">
        <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
        <!-- <p class="description"><?php echo $product['description']; ?></p> -->

            <?php if ($product['rating']) { ?>
        <div class="ratings">
        <div class="rating-box">
          <?php for ($i = 1; $i <= 5; $i++) { ?>
          <?php if ($product['rating'] < $i) { ?>
          <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
          <?php } else { ?>
          <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
          <?php } ?>
          <?php } ?>
        </div>
        </div>
        <?php } ?>

        <?php if ($product['price']) { ?>
        <div class="price content_price product-price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
          <?php global $config; if($config->get('marketshop_percentage_discount_badge')== 1) { ?>
          <span class="saving">-<?php echo $product['saving']; ?>%</span>
          <?php } ?>
          <?php } ?>
          <?php if ($product['tax']) { ?>
          <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>

      </div></div>
    <div class="button-group">
          <button class="wishlist" type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart-o"></i></button>
          <button class="addToCart" type="button" data-toggle="tooltip" title="<?php echo $button_cart; ?>" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><span><?php echo $button_cart; ?></span></button>
          <button class="compare" type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-refresh"></i></button>
          </div>
    </div>
  </div>
</div>
</div>
<?php } ?>
<?php if(empty($products)){ ?>
<div class="product-layout product-list col-xs-12"></div>
<?php } ?>