<?php
global $config, $loader, $registry;
$loader->model('custom/general');
$model = $registry->get('model_custom_general');
$layout_id = $model->getCurrentLayout();
$lang = $config->get('config_language_id');
$store_id = $config->get('config_store_id');
$template = $config->get('config_template');

if ($store_id == 0) {
    $soconfig_general = $config->get('soconfig_general');
    $soconfig_social = $config->get('soconfig_social');
} else {
    $soconfig_general = $config->get('soconfig_general_store');
    $soconfig_social = $config->get('soconfig_social_store');
	
/* GENERAL */
	$text_layout = array(
		'cpanel',
		'backtop',
		'copyright',
		'socials_status',
		'footerpayment_status',
		'footerpayment',
		'customblock_status',
	);
	foreach ($text_layout as $text) {
		if (isset($soconfig_general[$store_id][$text])) {$soconfig_general[$text] = $soconfig_general[$store_id][$text];}
	}
		if (isset($soconfig_general[$lang][$store_id]["footer_socials_title"])) 	{$soconfig_general[$lang]["footer_socials_title"]  = $soconfig_general[$lang][$store_id]["footer_socials_title"];}
	if (isset($soconfig_general[$lang][$store_id]["footer_socials"])) 			{$soconfig_general[$lang]["footer_socials"]  = $soconfig_general[$lang][$store_id]["footer_socials"];}
	if (isset($soconfig_general[$lang][$store_id]["custom_html_title"])) 		{$soconfig_general[$lang]["custom_html_title"]  = $soconfig_general[$lang][$store_id]["custom_html_title"];}
	if (isset($soconfig_general[$lang][$store_id]["customblock_html"])) 		{$soconfig_general[$lang]["customblock_html"]  = $soconfig_general[$lang][$store_id]["customblock_html"];}

/* SOCIAL ACCOUNT */
	$text_Social = array(
		'social_status',
		'facebook',
		'twitter',
		'video_code',
	);
	foreach ($text_Social as $text) {
		if (isset($soconfig_social[$store_id][$text])) 		{$soconfig_social[$text] = $soconfig_social[$store_id][$text];}
	}
}

?>
	<?php if (trim($content_block4)) : ?>
	<section id="yt_mailing">
		<div class="container">
			<div class="row">
			<div class="col-sm-3 novosti">
				<h2>НОВОСТИ</h2>
				Подпишись на рассылку
			</div>
				<div class="col-sm-6">
				 <?php echo $content_block4; ?>
				</div>
				<div class="col-sm-3">
					<!-- Social widgets -->
	<?php if (!isset($soconfig_social["social_status"]) || $soconfig_social["social_status"] != 0) : ?>
	<section class="social-widgets visible-lg">
			
			<div class=" facebook items">
				<a href="https://www.facebook.com/gorshki/" class="tab-icon" style="left: -17px; float:right;"><span class="fa fa-facebook"></span></a>
			</div>			
		
	</section>
	<?php endif; ?>
	<!-- //end Social widgets -->
				</div>
			</div>
		</div> 
	</section>
	<?php endif; ?>
	
	<footer class="footer-container">
		<section class="footer-top-block ">
			<div class="container content">
				<div class="row">

<?php if (isset($soconfig_general["socials_status"]) && $soconfig_general["socials_status"] != 0) : ?>
					<div class="col-lg-15 col-sm-12 collapsed-block footer-links">
						<div class="module clearfix">
							<?php if (isset($soconfig_general[$lang]["footer_socials_title"]) && $soconfig_general[$lang]["footer_socials_title"] != '' ) : ?>
							<h3 class="modtitle">
								<?php echo $soconfig_general[$lang]["footer_socials_title"];?>
							</h3>
							<?php endif;?>
							<div  class="modcontent 0" >
								<?php
								if (isset($soconfig_general[$lang]["footer_socials"]) && $soconfig_general[$lang]["footer_socials"] != '' && is_string($soconfig_general[$lang]["footer_socials"])) :
									echo html_entity_decode($soconfig_general[$lang]["footer_socials"], ENT_QUOTES, 'UTF-8');
								endif;
								?>
							</div>
						</div>
					</div>
					<?php endif; ?>
				
					<div class=" col-lg-15 col-sm-6 col-md-3 box-account">
						<div class="module clearfix">
							<h3 class="modtitle"><?php echo $text_account; ?></h3>
							<div  class="modcontent" >
								<ul class="menu">
									<li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
									<li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
									<li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
									<li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
								</ul>
							</div>
						</div>
					</div>
					<?php if ($informations) : ?>
						<div class="col-lg-15 col-sm-6 col-sm-6 col-md-3 box-information">
							<div class="module clearfix">
								<h3 class="modtitle"><?php echo $text_information; ?></h3>
								<div  class="modcontent" >
									<ul class="menu">
										<?php foreach ($informations as $information) { ?>
										<li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
										<?php } ?>
									</ul>
								</div>
							</div>
						</div>
					<?php endif; ?>

					<div class="col-lg-15 col-sm-6 col-md-3 box-service">
						<div class="module clearfix">
							<h3 class="modtitle"><?php echo $text_service; ?></h3>
							<div  class="modcontent" >
								<ul class="menu">
									<li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
									<li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
									<li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
								</ul>
							</div>
						</div>
					</div>
					
					
				</div>
			</div>
		</section>
		<?php 
		
		if (trim($content_block5)) : ?>
	<!-- 	<section class="footer-midde-block1">
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
					<?php echo $content_block5; ?>
					</div>
				</div>
			</div> 
		</section> -->
		<?php endif; ?>
		<?php if (trim($content_block6)) : ?>
		<section class="footer-midde-block2">
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
					<?php echo $content_block6; ?>
					</div>
				</div>
			</div> 
		</section>
		<?php endif; ?>
		<div class="footer-bottom-block <?php echo (isset($soconfig_general['homepage_mode']) && $soconfig_general['homepage_mode'] == 'boxed' ? 'boxed_home' : ''); ?>">
			<div class=" <?php echo (isset($soconfig_general['homepage_mode']) && $soconfig_general['homepage_mode'] == 'boxed' ? 'boxed_home' : 'container'); ?>">
				<div class="row">
					<div class="col-sm-5 copyright-text">
						<?php echo (!isset($soconfig_general["copyright"]) || !is_string($soconfig_general["copyright"]) ? $powered : html_entity_decode($soconfig_general["copyright"], ENT_QUOTES, 'UTF-8'));?>
					</div>

					<?php if (isset($soconfig_general["footerpayment_status"]) && $soconfig_general["footerpayment_status"] != 0) : ?>
					<div class="col-sm-7">
						<?php
							if (isset($soconfig_general["footerpayment"]) && $soconfig_general["footerpayment"] != '' && is_string($soconfig_general["footerpayment"])) {
								echo html_entity_decode($soconfig_general["footerpayment"], ENT_QUOTES, 'UTF-8');
							}
						?>
					</div>
					<?php endif; ?>

				</div>

			</div>
		</div>
	</footer>
    <!-- //end Footer -->
	
	<?php if(isset($soconfig_general["backtop"]) && $soconfig_general["backtop"] == 1):?>
		<div class="back-to-top"><i class="fa fa-angle-up"></i></div>
		<p id="gl_path" class="hidden"><?php echo $template; ?></p>
	<?php endif; ?>
	
	<?php if( $soconfig_general["cpanel"] ):?>
		<?php include('catalog/view/theme/'.$template.'/template/common/cpanel.php'); ?>
	<?php endif; ?>
	
	

    </div>
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-WPX4FXH"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->



</body>
</html>