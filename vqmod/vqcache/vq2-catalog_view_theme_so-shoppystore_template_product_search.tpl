<?php echo $header; ?>

<?php

    global $config, $loader, $registry, $db, $session;

	$lang = $config->get('config_language_id');

    $store_id = $config->get('config_store_id');

	$template = $config->get('config_template');

	$short_by = !empty ($pagination) ? 'col-md-7 col-sm-8 col-xs-12' : 'col-sm-10 col-xs-12';

	$devices = array(

		'lg' => ' Desktops',

		'sm' => ' Tablets',

		'xs' => ' Phones',

	);

     if ($store_id == 0) {

        $soconfig_pages = $config->get('soconfig_pages');

		$soconfig_general = $config->get('soconfig_general');

    } else {

        $soconfig_pages = $config->get('soconfig_pages_store');

		$soconfig_general = $config->get('soconfig_general_store');

/* PAGE PRODUCT */

		$text_product = array(

			'product_catalog_refine',

			'product_catalog_refine_col_lg',

			'product_catalog_refine_col_sm',

			'product_catalog_refine_col_xs',

			'lsttitle_cate_status',

			'lstimg_cate_status',

			'lstcompare_status',

			'product_catalog_mode',

			'product_catalog_column_lg',

			'product_catalog_column_sm',

			'product_catalog_column_xs',

			'secondimg',

			'rating_status',

			'lstdescription_status',

			'sale_status',

			'new_status',

			'days',

			'quick_status',

			'discount_status',

			'countdown_status',

		);

		foreach ($text_product as $text) {

			if (isset($soconfig_pages[$store_id][$text])) 		{$soconfig_pages[$text] = $soconfig_pages[$store_id][$text];}

		}

		

		if (isset($soconfig_pages[$lang][$store_id]["sale_text"])) 		{$soconfig_pages[$lang]["sale_text"]  = $soconfig_pages[$lang][$store_id]["sale_text"];}

		if (isset($soconfig_pages[$lang][$store_id]["new_text"])) 		{$soconfig_pages[$lang]["new_text"]  = $soconfig_pages[$lang][$store_id]["new_text"];}

		if (isset($soconfig_pages[$lang][$store_id]["quick_view_text"])) 		{$soconfig_pages[$lang]["quick_view_text"]  = $soconfig_pages[$lang][$store_id]["quick_view_text"];}

		if (isset($soconfig_general[$store_id]['scroll_animation'])) 	{$soconfig_general['scroll_animation'] = $soconfig_general[$store_id]['scroll_animation'];}

		

    }

	

 

/*VARIABLES*/

	global $countdown_status;	

	$new_text = $soconfig_pages[$lang]["new_text"];

	$sale_text = $soconfig_pages[$lang]["sale_text"];

	$quick_view_text = $soconfig_pages[$lang]["quick_view_text"];

	$sale_status = $soconfig_pages["sale_status"];

	$new_status = $soconfig_pages["new_status"];

	$quick_status = $soconfig_pages["quick_status"];

	$rating_status = $soconfig_pages["rating_status"];

	$discount_status = $soconfig_pages["discount_status"];

	$lsttitle_status = $soconfig_pages["lsttitle_cate_status"];

	$lstdes_status = $soconfig_pages["lstdescription_status"];

	$soconfig_days = $soconfig_pages["days"];

	$secondimg = $soconfig_pages["secondimg"];

	$lazyload_status = $soconfig_general["scroll_animation"];

	

	function lazyload($src_img){

		global $lazyload_status;

		return $lazyload_status ==1 ? 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7' : $src_img;

	}

	$lazyload_text = $lazyload_status ==1 ? 'lazy' : '';

/*SET CATEGORY COLUMN*/	

	$soconfig_pages["product_catalog_column_lg"] = 4;

?>





<div class="container">

  <ul class="breadcrumb">

    <?php foreach ($breadcrumbs as $breadcrumb) { ?>

    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>

    <?php } ?>

  </ul>

  

  <div class="row"><?php echo $column_left; ?>

    <?php if ($column_left && $column_right) { ?>

    <?php $class = 'col-sm-6'; ?>

    <?php } elseif ($column_left || $column_right) { ?>

    <?php $class = 'col-sm-9'; ?>

    <?php } else { ?>

    <?php $class = 'col-sm-12'; ?>

    <?php } ?>

    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>

		<div class="form-group">

			  <h1><?php echo $heading_title; ?></h1>

			  <label class="control-label" for="input-search"><?php echo $entry_search; ?></label>

			  <div class="row">

				<div class="col-sm-3">

				  <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" class="form-control" />

				</div>

				<div class="col-sm-3">

				  <select name="category_id" class="form-control">

					<option value="0"><?php echo $text_category; ?></option>

					<?php foreach ($categories as $category_1) { ?>

					<?php if ($category_1['category_id'] == $category_id) { ?>

					<option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>

					<?php } else { ?>

					<option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>

					<?php } ?>

					<?php foreach ($category_1['children'] as $category_2) { ?>

					<?php if ($category_2['category_id'] == $category_id) { ?>

					<option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>

					<?php } else { ?>

					<option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>

					<?php } ?>

					<?php foreach ($category_2['children'] as $category_3) { ?>

					<?php if ($category_3['category_id'] == $category_id) { ?>

					<option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>

					<?php } else { ?>

					<option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>

					<?php } ?>

					<?php } ?>

					<?php } ?>

					<?php } ?>

				  </select>

				</div>

				<div class="col-sm-12" style="margin: 15px 0;">

				  <label class="checkbox-inline">

					<?php if ($sub_category) { ?>

					<input type="checkbox" name="sub_category" value="1" checked="checked" />

					<?php } else { ?>

					<input type="checkbox" name="sub_category" value="1" />

					<?php } ?>

					<?php echo $text_sub_category; ?></label>

					

					<label class="checkbox-inline" style="margin:0;">

					  <?php if ($description) { ?>

					  <input type="checkbox" name="description" value="1" id="description" checked="checked" />

					  <?php } else { ?>

					  <input type="checkbox" name="description" value="1" id="description" />

					  <?php } ?>

					  <?php echo $entry_description; ?>

					</label>

				</div>

			  </div>



			  <input type="button" value="<?php echo $button_search; ?>" id="button-search" class="btn btn-primary" />

		</div>

      <?php if ($products) { ?>

			<!-- Filters -->

			<div class="product-filter filters-panel">

			  <div class="row">

				<div class="col-md-2 hidden-sm hidden-xs">

					<div class="view-mode">

						<div class="list-view">

							<button class="btn btn-default grid <?php if(isset($soconfig_pages['product_catalog_mode']) && $soconfig_pages['product_catalog_mode'] == '0') { echo 'active'; } ?>" data-view="grid" ><i class="fa fa-th-large"></i></button>

							<button class="btn btn-default list <?php if(isset($soconfig_pages['product_catalog_mode']) && $soconfig_pages['product_catalog_mode'] == '1') { echo 'active'; } ?>" data-view="list"><i class="fa fa-th-list"></i></button>

						</div>

					</div>

				</div>

				<div class="short-by-show form-inline text-right <?php echo $short_by;?>">

					<div class="form-group">

						<label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>

						<select id="input-sort" class="form-control" onchange="location = this.value;">

						  <?php foreach ($sorts as $sorts2) { ?>

						  <?php if ($sorts2['value'] == $sort . '-' . $order) { ?>

						  <option value="<?php echo $sorts2['href']; ?>" selected="selected"><?php echo $sorts2['text']; ?></option>

						  <?php } else { ?>

						  <option value="<?php echo $sorts2['href']; ?>"><?php echo $sorts2['text']; ?></option>

						  <?php } ?>

						  <?php } ?>

						</select>

					</div>

					

					<div class="form-group">

						<label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>

						<select id="input-limit" class="form-control" onchange="location = this.value;">

						  <?php 

						 

						  foreach ($limits as $limits2) { ?>

						  <?php if ($limits2['value'] == $limit) { ?>

						  <option value="<?php echo $limits2['href']; ?>" selected="selected"><?php echo $limits2['text']; ?></option>

						  <?php } else { ?>

						  <option value="<?php echo $limits2['href']; ?>"><?php echo $limits2['text']; ?></option>

						  <?php } ?>

						  <?php } ?>

						</select>

					</div>

					<?php if (isset($soconfig_pages["lstcompare_status"]) && $soconfig_pages["lstcompare_status"] == 1){ ;?>

						<div class="product-compare form-group" style="margin: 0 10px"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>

					<?php } ?>

				</div>

				<?php if (!empty($pagination)){?>

					<div class="box-pagination col-sm-3 text-right"><?php echo $pagination; ?></div>

				<?php }?>

			  </div>

			</div>

			<!-- //end Filters -->

	

			<!--Changed Listings-->

		<div class="products-list row <?php echo ($soconfig_pages['product_catalog_mode'] =='1') ? 'list' : 'grid'?>">

        <?php 

		

		$device_res  ='';

		foreach ($devices as $subfix => $device) {

			$device_res .=  'col-'.$subfix.'-'.ceil(12/$soconfig_pages["product_catalog_column_".$subfix] ).' ';

		}

		foreach ($products as $idproduct =>$product) { 

			$loader->model('catalog/product');

			$model = $registry->get('model_catalog_product');

			$product_info = $model->getProduct($product['product_id']);

			

			/*special end date output*/

			$query_date = $db->query("SELECT date_end FROM ".DB_PREFIX."product_special WHERE product_id='".(int)$product_info['product_id']."'");

			if ($query_date->rows) {

				$special_end_date = $query_date->row["date_end"];

			} else {

				$special_end_date = false;

			}



			$limit = 250;

			$full_description = strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8'));

			$product_description_short = (strlen($product_info['description']) > $limit ? utf8_substr($full_description, 0, $limit) . '...' : $full_description);

			/*special end date output*/

			if ((float)$product_info['special']) {

				if (!isset($discount_status) || $discount_status != 0) {

					$discount = '<span class="label label-percent">-'.round((($product_info['price'] - $product_info['special'])/$product_info['price'])*100, 0).'%</span>';

				} else {$discount = false;}

			} else {

				$discount = false;

			}

			

		?>

		

        <div class="product-layout <?php echo $device_res;?>">

			<div class="product-item-container">

				<div class="left-block">

					<div class="product-image-container <?php echo $lazyload_text?> <?php if($secondimg =='2' && isset($product['thumb2'])){ echo "second_img";} ?> ">

						<img data-src="<?php echo $product['thumb']; ?>" <?php /* Product Option Image PRO module << */ if ($poip_installed) { ?> data-poip_id="image_<?php echo "".$current_class."_".$product['product_id']; ?>" <?php } /*  >> Product Option Image PRO module */ ?>  src="<?php echo lazyload($product['thumb']); ?>"  title="<?php echo $product['name']; ?>" class="img-responsive" />

						<?php if( $secondimg =='2' && isset($product['thumb2']) && !empty($product['thumb2'])) :?>

						<img data-src="<?php echo $product['thumb2']; ?>" src="<?php echo lazyload($product['thumb2']); ?>"  alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img_0 img-responsive" />

						<?php endif;?>

					</div>

					<!--countdown box-->

					<?php include('catalog/view/theme/'.$template.'/template/product/countdown.php'); ?>

					<!--end countdown box--

				

					<!--New Label-->

					<?php if (!isset($new_status) || ($new_status != 0)) : ?>

					<?php

					$day_range = 10;

					if ($soconfig_days == '') {

						$days = $day_range;

					} else {

						$days = $soconfig_days;

					}

					$day_number_to_range = date( "Y-m-d" ,  strtotime("-$days day")  );

					if ($product_info['date_available'] >= $day_number_to_range) :

						?>

						<span class="label label-new"><?php echo (isset($new_text) ? $new_text : 'NEW'); ?></span>

						<?php endif; ?>

					<?php endif; ?>

				

					<!--Sale Label-->

					<?php if ($product['special']) : ?>

					<?php if (!isset($sale_status) || ($sale_status != 0)) : ?>

						<span class="label label-sale"><?php echo (isset($sale_text) ? $sale_text : 'SALE'); ?></span>

						<?php endif; ?>

					<?php endif; ?>

					  

						

					<?php if (!isset($quick_status) || $quick_status != 0) : ?>

						<!--full quick view block-->

							<?php $our_url = $this->registry->get('url'); ?>

							<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="<?php echo $our_url->link('product/quickview','product_id='.$product['product_id']);?>"> <i class="fa fa-search"></i></a>

						<!--end full quick view block-->

					<?php endif; ?>

				</div>

				<!-- end left block -->

				

				<div class="right-block">


      <?php // Product Option Image PRO module << ?>
      <?php  if ($poip_installed && isset($product['option_images']) && $product['option_images'] && $poip_theme_name == "bt_comohos" ) {
			
				if (!isset($poip_product_images_shown)) $poip_product_images_shown = false;
				
				if (!$poip_product_images_shown) {
				
					$poip_product_images_shown = true;
				
					foreach ($product['option_images'] as $product_option_id => $option_images) {
						
						echo "<div data-poip_id=\"poip_img\" style=\"  text-align: left; margin-top: 3px; width:100%; \">";
						$image_counter = 0;
						foreach ($option_images as $product_option_value_id => $option_image) {
							$image_counter++;
							echo "
											<a onmouseover=\"poip_show_thumb(this);return false;\"
												style=\"display:inline;\" href=\"".$product['href'].(strpos($product['href'],'?')===false?'?':'&amp;')."poip_ov=".(int)$product_option_value_id."\"
												".( (isset($option_image['title']) && $option_image['title']) ? " title=\"".$option_image['title']."\" " : "" )."
												data-thumb=\"".$option_image['thumb']."\"
												data-image_id=\"".$current_class."_".$product['product_id']."\">
											<img src=\"".$option_image['icon']."\" class=\"img-thumbnail\" width=\"23\" height=\"23\" alt=\"".( (isset($option_image['title']) && $option_image['title']) ? $option_image['title'] : "" )."\"></a>
										";
						}
						echo "</div>";
					}
				}
      } ?>
      <?php //  >> Product Option Image PRO module ?>
      

      <?php // Product Option Image PRO module << ?>
      <?php  if ($poip_installed && isset($product['option_images']) && $product['option_images'] && $poip_theme_name == 'opc1000') {
      
        foreach ($product['option_images'] as $product_option_id => $option_images) {
          
					echo "<div data-poip_id=\"poip_img\" style=\"  text-align: center; margin-top: 3px; \">";
          $image_counter = 0;
          foreach ($option_images as $product_option_value_id => $option_image) {
            $image_counter++;
            echo "
                    <a onmouseover=\"poip_show_thumb(this);\" 
                      style=\"display:inline;\" href=\"".$product['href'].(strpos($product['href'],'?')===false?'?':'&amp;')."poip_ov=".(int)$product_option_value_id."\"
                      ".( (isset($option_image['title']) && $option_image['title']) ? " title=\"".$option_image['title']."\" " : "" )."
                      data-thumb=\"".$option_image['thumb']."\"
                      data-image_id=\"".$current_class."_".$product['product_id']."\">
                    <img src=\"".$option_image['icon']."\" class=\"img-thumbnail\" alt=\"".( (isset($option_image['title']) && $option_image['title']) ? $option_image['title'] : "" )."\"></a>
                  ";
          }
          echo "</div>";
					
        }
      
      } ?>
      <?php //  >> Product Option Image PRO module ?>
      
					<div class="caption">

						<?php

							

							$after_title = substr($product['name'], 0 , 100 )

						?>

					<h4><a href="<?php echo $product['href']; ?>"><?php echo $after_title; ?></a></h4>		

					<?php if (isset($rating_status) && $rating_status!= 0) : ?>

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

					<?php endif; ?>

					

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

						<?php echo $discount; ?>    

					  

					</div>

					<?php } ?>

					

					<div class="description <?php if (!isset($lstdes_status) || $lstdes_status != 1) : ?> item-desc <?php endif; ?>">

						<p><?php echo $product_description_short; ?></p>

					</div>

				  </div>

				    

				  <div class="button-group">

					<button class="wishlist" type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart-o"></i></button>

					<button class="addToCart" type="button" data-toggle="tooltip" title="<?php echo $button_cart; ?>" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><span><?php echo $button_cart; ?></span></button>

					<button class="compare" type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-refresh"></i></button>

				  </div>

			   

				</div><!-- right block -->



			</div>

        </div>

		

        <?php } ?>

	</div>

	<!--// End Changed listings-->

	

	<!-- Filters -->

	<div class="product-filter product-filter-bottom filters-panel" style="float: left; width: 100%;">

	  <div class="row">

		<div class="col-md-2 hidden-sm hidden-xs">

			<div class="view-mode">

				<div class="list-view">

					<button class="btn btn-default grid <?php if(isset($soconfig_pages['product_catalog_mode']) == '0') { echo 'active'; } ?>" data-view="grid" ><i class="fa fa-th-large"></i></button>

					<button class="btn btn-default list <?php if(isset($soconfig_pages['product_catalog_mode']) == '1') { echo 'active'; } ?>" data-view="list"><i class="fa fa-th-list"></i></button>

				</div>

			</div>

		</div>

	   <div class="short-by-show text-center <?php echo $short_by;?>">

			<div class="form-group"><?php echo $results; ?></div>

			<?php if (isset($soconfig_pages["lstcompare_status"]) && $soconfig_pages["lstcompare_status"] == 1){ ;?>

				<div class="product-compare form-group" style="margin: 0 10px"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>

			<?php } ?>

		</div>

		<?php if (!empty($pagination)){?>

			<div class="box-pagination col-md-3 col-sm-4 text-right"><?php echo $pagination; ?></div>

		<?php }?>

		

	  </div>

	</div>

	<!-- //end Filters -->



	<!--changed listings-->

    <?php } ?>



  <!--end content-->

      <?php echo $content_bottom; ?></div>

    <?php echo $column_right; ?></div>

</div>

	<script type="text/javascript"><!--

	$('#button-search').bind('click', function() {

		url = 'index.php?route=product/search';



		var search = $('#content input[name=\'search\']').prop('value');



		if (search) {

			url += '&search=' + encodeURIComponent(search);

		}



		var category_id = $('#content select[name=\'category_id\']').prop('value');



		if (category_id > 0) {

			url += '&category_id=' + encodeURIComponent(category_id);

		}



		var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');



		if (sub_category) {

			url += '&sub_category=true';

		}



		var filter_description = $('#content input[name=\'description\']:checked').prop('value');



		if (filter_description) {

			url += '&description=true';

		}



		location = url;

	});



	$('#content input[name=\'search\']').bind('keydown', function(e) {

		if (e.keyCode == 13) {

			$('#button-search').trigger('click');

		}

	});



	$('select[name=\'category_id\']').on('change', function() {

		if (this.value == '0') {

			$('input[name=\'sub_category\']').prop('disabled', true);

		} else {

			$('input[name=\'sub_category\']').prop('disabled', false);

		}

	});



	$('select[name=\'category_id\']').trigger('change');

	function display(view) {

			$('.products-list').removeClass('list grid').addClass(view);

			$('.list-view .btn').removeClass('active');

			if(view == 'list') {

				$('.products-list .product-layout').addClass('col-lg-12');

				$('.products-list .product-layout .left-block').addClass('col-lg-3 col-md-4 col-xs-12');

				$('.products-list .product-layout .right-block').addClass('col-lg-9 col-md-8 col-xs-12');

				$('.products-list .product-layout .item-desc').removeClass('hidden')

				$('.list-view .' + view).addClass('active');

				$.cookie('display', 'list'); 

			}else{

				$('.products-list .product-layout').removeClass('col-lg-12');

				$('.products-list .product-layout .left-block').removeClass('col-lg-3 col-md-4 col-xs-12');

				$('.products-list .product-layout .right-block').removeClass('col-lg-9 col-md-8 col-xs-12');

				$('.products-list .product-layout .item-desc').addClass('hidden');

				$('.list-view .' + view).addClass('active');

				$.cookie('display', 'grid');

			}

	}

		

		$(document).ready(function () {

			// Check if Cookie exists

			if($.cookie('display')){

				view = $.cookie('display');

			}else{

				view = '<?php echo isset($soconfig_pages['product_catalog_mode'] )? 'list' : 'grid'?>' ;

			}

			if(view) display(view);

			

			// Click Button

			$('.list-view .btn').each(function() {

				var ua = navigator.userAgent,

				event = (ua.match(/iPad/i)) ? 'touchstart' : 'click';

				$(this).bind(event, function() {

					$(this).addClass(function() {

						if($(this).hasClass('active')) return ''; 

						return 'active';

					});

					$(this).siblings('.btn').removeClass('active');

					$catalog_mode = $(this).data('view');

					display($catalog_mode);

				});

				

			});

		});



	--></script>

<?php echo $footer; ?>