<?php if (!empty($products)) {
$count_item = count($products);
$cls_btn_page = ($button_page == 'top') ? 'buttom-type1':'button-type2';
$btn_type 	  = ($button_page == 'top') ? 'button-type1':'button-type2';
$suffix = rand() . time();
$tag_id = 'sp_extra_slider_' . $suffix;
$class_respl = 'preset00-'.$nb_column0.' preset01-'.$nb_column1.' preset02-'.$nb_column2.' preset03-'.$nb_column3.' preset04-'.$nb_column4;
$btn_prev = ($button_page == 'top') ? '&#171;':'&#139;';
$btn_next = ($button_page == 'top') ? '&#187;':'&#155;';
$i = 0;
?>
<div class="moduletable <?php echo $class_suffix; ?>">
	<?php if($disp_title_module) { ?>
	<h3><?php echo $head_name; ?></h3>
	<?php } ?>

		<div id="<?php echo $tag_id ; ?>"
			 class="so-extraslider <?php echo $cls_btn_page; ?> <?php echo $class_respl; ?> <?php echo $btn_type; ?> ">
			<!-- Begin extraslider-inner -->

			<div class="extraslider-inner" data-effect="<?php echo $effect; ?>">
				<?php  foreach ($products as $product) {
				$i++;
				?>
				<?php if ($i % $nb_rows == 1 || $nb_rows == 1) { ?>
				<div class="item ">
					<?php } ?>
					<div class="item-wrap <?php echo $products_style; ?>">
						<div class="item-wrap-inner">
								<div class="item-image">
									<div class="item-img-info">
										<?php if($product_image) { ?>
										<a class="product_img_link" href="<?php echo $product['href'];?>" target="<?php echo $item_link_target;?>" title="<?php echo $product['name']; ?>">
											<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
										</a>
										<?php } else { ?>
										<a class="product_img_link" href="<?php echo $product['href'];?>" target="<?php echo $item_link_target;?>" title="<?php echo $product['name']; ?>">
											<img src="catalog/view/javascript/so_extra_slider/images/nophoto.jpg" style="width: <?php echo $width ;?>px !important; height: <?php echo $height ; ?>px !important;" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
										</a>
										<?php } ?>
										<?php if ($display_readmore_link == 1 && $products_style == 'style1' || $products_style == 'style2')  {  ?>
										
										<a class="quick-view" href="<?php echo $product['href'];?>" title="<?php echo $product['href'];?>" target="<?php echo $item_link_target;?>" >
											<span><?php echo $readmore_text ; ?></span>
										</a>
										<?php } ?>
									</div>
								</div>
							<?php if($display_title == 1 || $display_description == 1 || $display_price == 1 || $display_addtocart == 1 || $display_wishlist == 1 || $display_compare == 1 || $display_readmore_link == 1){ ?>
								<div class="item-info">
									<?php if($display_title == 1) { ?>
										<div class="item-title">
											<a href="<?php echo $product['href'];?>" target="<?php echo $item_link_target;?>"
											   title="<?php echo $product['name']; ?>"  >
												<?php echo html_entity_decode($product['name']); ?>
											</a>
										</div>
									<?php } ?>

									<?php if($display_description == 1 || $display_price == 1 || $display_addtocart == 1 || $display_wishlist == 1 || $display_compare == 1 || $display_readmore_link == 1) { ?>
										<!-- Begin item-content -->
										<div class="item-content">
											<?php if($display_description) { ?>
												<div class="item-des">
													<?php echo html_entity_decode($product['description']); ?>
												</div>
											<?php } ?>

											<?php if($display_price) { ?>
												<div  class="content_price">
													<?php if (!$product['special']) { ?>
													<span class="price product-price">
														<?php echo $product['price']; ?>
													</span>
													<?php } else { ?>
														<span class="old-price product-price"><?php echo $product['special']; ?></span>&nbsp;&nbsp;
														<span class="price-old"><?php echo $product['price']; ?></span>&nbsp;
													<?php } ?>
													<?php if ($product['tax']) { ?>
														<span class="price-percent-reduction"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
													<?php } ?>
												</div>
											<?php } ?>

											<?php if($display_addtocart || $display_readmore_link || $display_wishlist || $display_compare) { ?>
												<div class="button-container">
													<?php if ($display_addtocart == 1) { ?>
													<button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-cart"></i>
														<?php if($nb_column0 != 6) { ?>
														<span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span>
														<?php } ?>
													</button>
													<?php } ?>
													<?php if ($display_wishlist == 1) { ?>
													<button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
													<?php } ?>
													<?php if ($display_compare == 1) { ?>
													<button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
													<?php } ?>
												</div>
											<?php } ?>

											<?php if ($display_readmore_link == 1 && $products_style != 'style1' && $products_style !='style2') { ?>
											<div class="item-readmore">
												<a href="<?php echo $product['href'];?>" title="<?php echo $product['name']; ?>" target="<?php echo $item_link_target;?>" >
													<?php echo $readmore_text ; ?>
												</a>
											</div>
											<?php } ?>

										</div>
										<!-- End item-content -->
									<?php } ?>
								</div>
								<!-- End item-info -->
							<?php } ?>

						</div>
						<!-- End item-wrap-inner -->
					</div>
					<!-- End item-wrap -->
					<?php if ($i % $nb_rows == 0 || $i == $count_item) { ?>
				</div>
					<?php } ?>
				<?php } ?>

			</div>
			<!--End extraslider-inner -->
		</div>
	<script type="text/javascript">
		//<![CDATA[
		jQuery(document).ready(function ($) {
			;(function (element) {
				var $element = $(element),
						$extraslider = $(".extraslider-inner", $element),
						_delay = <?php echo $delay; ?>,
						_duration = <?php echo $duration; ?>,
						_effect = '<?php echo $effect; ?>';

				$extraslider.on("initialized.owl.carousel2", function () {
					var $item_active = $(".owl-item.active", $element);
					if ($item_active.length > 1 && _effect != "none") {
						_getAnimate($item_active);
					}
					else {
						var $item = $(".owl-item", $element);
						$item.css({"opacity": 1, "filter": "alpha(opacity = 100)"});
					}
					<?php if($dots == "true") { ?>
					if ($(".owl-dot", $element).length < 2) {
						$(".owl-prev", $element).css("display", "none");
						$(".owl-next", $element).css("display", "none");
						$(".owl-dot", $element).css("display", "none");
					}
					<?php }?>

					<?php if ($button_page == "top"){ ?>
					$(".owl-controls", $element).insertBefore($extraslider);
					$(".owl-dots", $element).insertAfter($(".owl-prev", $element));
					<?php }else{ ?>
					$(".owl-nav", $element).insertBefore($extraslider);
					$(".owl-controls", $element).insertAfter($extraslider);
					<?php }?>

				});

				$extraslider.owlCarousel2({
					margin: <?php echo $margin;?>,
				slideBy: <?php echo $slideBy;?>,
				autoplay: <?php echo $autoplay;?>,
				autoplayHoverPause: <?php echo $pausehover ;?>,
				autoplayTimeout: <?php echo $autoplay_timeout; ?>,
				autoplaySpeed: <?php echo $autoplaySpeed; ?>,
				smartSpeed: <?php echo $smartSpeed; ?>,
				startPosition: <?php echo $startPosition; ?>,
				mouseDrag: <?php echo $mouseDrag;?>,
				touchDrag: <?php echo $touchDrag; ?>,
				pullDrag: <?php echo $pullDrag; ?>,
				autoWidth: false,
				responsive: {
					0: 	{ items: <?php echo $nb_column4;?> } ,
					480: { items: <?php echo $nb_column3;?> },
					768: { items: <?php echo $nb_column2;?> },
					992: { items: <?php echo $nb_column1;?> },
					1200: {items: <?php echo $nb_column0;?>}
				},
					dotClass: "owl-dot",
					dotsClass: "owl-dots",
					dots: <?php echo $dots; ?>,
					dotsSpeed:<?php echo $dotsSpeed; ?>,
					nav: <?php echo $nav; ?>,
					loop: true,
					navSpeed: <?php echo $navSpeed; ?>,
					navText: ["<?php echo $btn_prev; ?>", "<?php echo $btn_next; ?>"],
					navClass: ["owl-prev", "owl-next"]

				});

				$extraslider.on("translate.owl.carousel2", function (e) {
					<?php if($dots == "true") { ?>
					if ($(".owl-dot", $element).length < 2) {
						$(".owl-prev", $element).css("display", "none");
						$(".owl-next", $element).css("display", "none");
						$(".owl-dot", $element).css("display", "none");
					}
					<?php } ?>

					var $item_active = $(".owl-item.active", $element);
					_UngetAnimate($item_active);
					_getAnimate($item_active);
				});

				$extraslider.on("translated.owl.carousel2", function (e) {

					<?php if($dots == "true") { ?>
					if ($(".owl-dot", $element).length < 2) {
						$(".owl-prev", $element).css("display", "none");
						$(".owl-next", $element).css("display", "none");
						$(".owl-dot", $element).css("display", "none");
					}
					<?php } ?>

					var $item_active = $(".owl-item.active", $element);
					var $item = $(".owl-item", $element);

					_UngetAnimate($item);

					if ($item_active.length > 1 && _effect != "none") {
						_getAnimate($item_active);
					} else {

						$item.css({"opacity": 1, "filter": "alpha(opacity = 100)"});

					}
				});

				function _getAnimate($el) {
					if (_effect == "none") return;
					//if ($.browser.msie && parseInt($.browser.version, 10) <= 9) return;
					$extraslider.removeClass("extra-animate");
					$el.each(function (i) {
						var $_el = $(this);
						$(this).css({
							"-webkit-animation": _effect + " " + _duration + "ms ease both",
							"-moz-animation": _effect + " " + _duration + "ms ease both",
							"-o-animation": _effect + " " + _duration + "ms ease both",
							"animation": _effect + " " + _duration + "ms ease both",
							"-webkit-animation-delay": +i * _delay + "ms",
							"-moz-animation-delay": +i * _delay + "ms",
							"-o-animation-delay": +i * _delay + "ms",
							"animation-delay": +i * _delay + "ms",
							"opacity": 1
						}).animate({
							opacity: 1
						});

						if (i == $el.size() - 1) {
							$extraslider.addClass("extra-animate");
						}
					});
				}

				function _UngetAnimate($el) {
					$el.each(function (i) {
						$(this).css({
							"animation": "",
							"-webkit-animation": "",
							"-moz-animation": "",
							"-o-animation": "",
							"opacity": 0
						});
					});
				}

			})("#<?php echo $tag_id ; ?>");
		});
		//]]>
	</script>
</div>
<?php
} else {
    echo JText::_('Has no item to show!');
} ?>