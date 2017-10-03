<?php
if ($modules) :
    global $config, $loader, $registry;

    $loader->model('custom/general');
    $model = $registry->get('model_custom_general');
    $layout_id = $model->getCurrentLayout();
?>
<aside class="col-lg-3 col-sm-4 col-xs-12 content-aside left_column">
	<?php foreach ($modules as $module) { ?>
		<?php echo $module; ?>
	<?php } ?>
</aside>
<?php endif; ?>
