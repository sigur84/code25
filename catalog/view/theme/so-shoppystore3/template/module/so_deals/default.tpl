<script type="text/javascript">
    //<![CDATA[
    var listdeal<?php echo $module;?> = [];
    //]]>
</script>
<div class="module <?php echo $class_suffix; ?>">
    <?php if($disp_title_module) { ?>
	<h3 class="modtitle"><span><?php echo $head_name; ?></span></h3>
    <?php } ?>
    <?php if (isset($list) && !empty($list))
    {
    $tag_id = 'so_deals_' . rand() . time();
    $class_respl = 'preset00-'.$nb_column0.' preset01-'.$nb_column1.' preset02-'.$nb_column2.' preset03-'.$nb_column3.' preset04-'.$nb_column4;
    ?>
    <div id="<?php echo $tag_id?>" class="so-deal modcontent clearfix <?php echo $class_respl; ?> <?php if($button_page == "top"){echo "button-type1";}else{echo "button-type2";} ?> style2">
        <div class="extraslider-inner" data-effect="<?php echo $effect; ?>">
            <?php foreach ($list as $product)
            {
            ?>

                <div class="product-thumb transition">
                    <?php if($product_image) { ?>
                    <div class="image">
                        <a href="<?php echo $product['href'];?>" target="<?php echo $item_link_target;?>">
                            <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo html_entity_decode($product['name']); ?>" class="img-responsive" />
                        </a>
						<div class="item-time">
							<div class="item-timer product_time_<?php echo $product['product_id']?>"></div>
							<script type="text/javascript">
								//<![CDATA[
								listdeal<?php echo $module?>.push('product_time_<?php echo $product['product_id']?>|<?php echo $product['specialPriceToDate'] ?>');
								//]]>
							</script>
						</div>
                    </div>
					
                    <?php } ?>
                    <div class="caption">
						<?php if (isset($product['rating'])) { ?>
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
                        <?php if($display_title == 1) { ?>
                        <h4 class="item-title"><a href="<?php echo $product['href']; ?>" target="<?php echo $item_link_target;?>"><?php echo $product['name']; ?></a></h4>
                        <?php } ?>
                        <?php if($display_description){ ?>
                        <p><?php echo  html_entity_decode($product['description']); ?></p>
                        <?php } ?>
                        
                        <?php if ($product['price'] && $display_price) { ?>
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
					<?php if($display_add_to_cart || $display_wishlist || $display_compare)
					{
					?>
						
						<div class="button-group">
						<?php if ($display_wishlist == 1) { ?>
						<button type="button" class="wishlist" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart-o"></i></button>
						<?php } ?>
						<?php if ($display_add_to_cart == 1) { ?>
						<button type="button" class="addToCart" onclick="cart.add('<?php echo $product['product_id']; ?>');">
							<?php if($nb_column0 != 6) { ?>
							<span><?php echo $button_cart; ?></span>
							<?php } ?>
						</button>
						<?php } ?>
						<?php if ($display_compare == 1) { ?>
						<button type="button" class="compare" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-refresh"></i></button>
						<?php } ?>
						</div>
					<?php 
					}
					?>
                </div>

            <?php
            }  ?>
        </div>
    </div>
    <script type="text/javascript">
        //<![CDATA[
        jQuery(document).ready(function ($) {
            ;
            (function (element) {
                var $element = $(element),
                        $extraslider = $('.extraslider-inner', $element),
                        _delay = <?php echo $delay; ?>,
                        _duration = <?php echo $duration; ?>,
                        _effect = '<?php echo $effect; ?>';

                $extraslider.on('initialized.owl.carousel2', function () {
                    var $item_active = $('.owl2-item.active', $element);
                    if ($item_active.length > 1 && _effect != 'none') {
                        _getAnimate($item_active);
                    }
                    else {
                        var $item = $('.owl2-item', $element);
                        $item.css({'opacity': 1, 'filter': 'alpha(opacity = 100)'});
                    }
                    <?php if ($dots == "true")
                    { ?>
                        if ($('.owl2-dot', $element).length < 2) {
                            $('.owl2-prev', $element).css('display', 'none');
                                $('.owl2-next', $element).css('display', 'none');
                                $('.owl2-dot', $element).css('display', 'none');
                            }
                    <?php
                    }?>

                    <?php if ($button_page == "top"){ ?>
                        $('.owl2-controls', $element).insertBefore($extraslider);
						$('.owl2-dots', $element).insertAfter($('.owl2-prev', $element));
                    <?php }else{ ?>
                        $('.owl2-nav', $element).insertBefore($extraslider);
						$('.owl2-controls', $element).insertAfter($extraslider);
                <?php }?>

            });

        $extraslider.owlCarousel2({
        margin: 30,
        slideBy: <?php echo $slideBy;?>,
        autoplay: <?php echo $autoplay;?>,
        autoplayHoverPause: <?php echo $autoplay_hover_pause ;?>,
        autoplayTimeout: <?php echo $autoplay_timeout; ?>,
        autoplaySpeed: <?php echo $autoplaySpeed; ?>,

        startPosition: <?php echo $startPosition; ?>,
        mouseDrag: <?php echo $mouseDrag;?>,
        touchDrag: <?php echo $touchDrag; ?>,

        autoWidth: false,
        responsive: {
            0: 	{ items: <?php echo $nb_column4;?> } ,
            480: { items: <?php echo $nb_column3;?> },
            768: { items: <?php echo $nb_column2;?> },
            992: { items: <?php echo $nb_column1;?> },
            1200: {items: <?php echo $nb_column0;?>}
        },
        dotClass: 'owl2-dot',
            dotsClass: 'owl2-dots',
        dots: <?php echo $dots; ?>,
        dotsSpeed: <?php echo $dotsSpeed; ?>,
        nav: <?php echo $navs?>,

        loop: <?php echo $loop; ?>,
        navSpeed: <?php echo $navSpeed; ?>,
        navText: ['', ''],
        navClass: ['owl2-prev', 'owl2-next']

        });

        $extraslider.on('translate.owl.carousel2', function (e) {
            var $item_active = $('.owl2-item.active', $element);
            _UngetAnimate($item_active);
            _getAnimate($item_active);
        });

        $extraslider.on('translated.owl.carousel2', function (e) {
            var $item_active = $('.owl2-item.active', $element);
            var $item = $('.owl2-item', $element);

            _UngetAnimate($item);

            if ($item_active.length > 1 && _effect != 'none') {
                _getAnimate($item_active);
            } else {
                $item.css({'opacity': 1, 'filter': 'alpha(opacity = 100)'});
            }
        });

        function _getAnimate($el) {
            if (_effect == 'none') return;
            //if ($.browser.msie && parseInt($.browser.version, 10) <= 9) return;
            $extraslider.removeClass('extra-animate');
            $el.each(function (i) {
                var $_el = $(this);
                $(this).css({
                    '-webkit-animation': _effect + ' ' + _duration + "ms ease both",
                    '-moz-animation': _effect + ' ' + _duration + "ms ease both",
                    '-o-animation': _effect + ' ' + _duration + "ms ease both",
                    'animation': _effect + ' ' + _duration + "ms ease both",
                    '-webkit-animation-delay': +i * _delay + 'ms',
                    '-moz-animation-delay': +i * _delay + 'ms',
                    '-o-animation-delay': +i * _delay + 'ms',
                    'animation-delay': +i * _delay + 'ms',
                    'opacity': 1
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
                    'animation': '',
                    '-webkit-animation': '',
                    '-moz-animation': '',
                    '-o-animation': '',
                    'opacity': 1
                });
            });
        }
        data = new Date(2013, 10, 26, 12, 00, 00);
        function CountDown(date, id) {
            dateNow = new Date();
            amount = date.getTime() - dateNow.getTime();
            if (amount < 0 && $('#' + id).length) {
                $('.' + id).html("Now!");
            } else {
                days = 0;
                hours = 0;
                mins = 0;
                secs = 0;
                out = "";
                amount = Math.floor(amount / 1000);
                days = Math.floor(amount / 86400);
                amount = amount % 86400;
                hours = Math.floor(amount / 3600);
                amount = amount % 3600;
                mins = Math.floor(amount / 60);
                amount = amount % 60;
                secs = Math.floor(amount);
                if (days != 0) {
                    out += "<div class='time-item time-day'>" + "<div class='num-time'>" + days + "</div>" + " <div class='name-time'>" + ((days == 1) ? "Day" : "Days") + "</div>" + "</div> ";
                }
				if(days == 0 && hours != 0)
				{
					 out += "<div class='time-item time-hour' style='width:33.33%'>" + "<div class='num-time'>" + hours + "</div>" + " <div class='name-time'>" + ((hours == 1) ? "Hour" : "Hours") + "</div>" + "</div> ";
				}else if (hours != 0) {
                    out += "<div class='time-item time-hour'>" + "<div class='num-time'>" + hours + "</div>" + " <div class='name-time'>" + ((hours == 1) ? "Hour" : "Hours") + "</div>" + "</div> ";
                }
				if(days == 0 && hours != 0)
				{
					out += "<div class='time-item time-min' style='width:33.33%'>" + "<div class='num-time'>" + mins + "</div>" + " <div class='name-time'>" + ((mins == 1) ? "Min" : "Mins") + "</div>" + "</div> ";
					out += "<div class='time-item time-sec' style='width:33.33%'>" + "<div class='num-time'>" + secs + "</div>" + " <div class='name-time'>" + ((secs == 1) ? "Sec" : "Secs") + "</div>" + "</div> ";
					out = out.substr(0, out.length - 2);
				}else if(days == 0 && hours == 0)
				{
					out += "<div class='time-item time-min' style='width:50%'>" + "<div class='num-time'>" + mins + "</div>" + " <div class='name-time'>" + ((mins == 1) ? "Min" : "Mins") + "</div>" + "</div> ";
					out += "<div class='time-item time-sec' style='width:50%'>" + "<div class='num-time'>" + secs + "</div>" + " <div class='name-time'>" + ((secs == 1) ? "Sec" : "Secs") + "</div>" + "</div> ";
					out = out.substr(0, out.length - 2);
				}else{
					out += "<div class='time-item time-min'>" + "<div class='num-time'>" + mins + "</div>" + " <div class='name-time'>" + ((mins == 1) ? "Min" : "Mins") + "</div>" + "</div> ";
					out += "<div class='time-item time-sec'>" + "<div class='num-time'>" + secs + "</div>" + " <div class='name-time'>" + ((secs == 1) ? "Sec" : "Secs") + "</div>" + "</div> ";
					out = out.substr(0, out.length - 2);
				}
                
                $('.' + id).html(out);

                setTimeout(function () {
                    CountDown(date, id);
                }, 1000);
            }
        }

        if (listdeal<?php echo $module?>.length > 0) {
            for (var i = 0; i < listdeal<?php echo $module?>.length; i++) {
                var arr = listdeal<?php echo $module?>[i].split("|");
                if (arr[1].length) {
                    var data = new Date(arr[1]);
                    CountDown(data, arr[0]);
                }
            }
        }
        })('#<?php echo $tag_id?>');
        });
        //]]>
    </script>
    <?php
    }else{
    echo '<p style="padding: 12em 0;text-align: center;">'.$NoItem.'</p>';
    }
    ?>
</div>
