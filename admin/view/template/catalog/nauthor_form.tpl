<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-author" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
  
	<?php echo $newspanel; ?>
	
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($error_keyword) { ?>
       <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_keyword; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
       </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-author" class="form-horizontal">
        <div id="tab-general">
		  <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-keyword"><?php echo $entry_keyword; ?></label>
            <div class="col-sm-10">
              <input type="text" name="keyword" value="<?php echo $keyword; ?>" id="input-keyword" class="form-control" />
                <?php if ($error_keyword) { ?>
                  <div class="text-danger"><?php echo $error_keyword; ?></div>
                <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
            <div class="col-sm-10">
              <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
              <input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-adminid"><?php echo $entry_adminid; ?></label>
            <div class="col-sm-10">
			  <input type="text" name="adminid" value="<?php echo $adminid; ?>" id="input-adminid" class="form-control" />
            </div>
          </div>
		  <ul class="nav nav-tabs" id="language">
                <?php foreach ($languages as $language) { ?>
                <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                <?php } ?>
          </ul>
          <div class="tab-content">
			<?php foreach ($languages as $language) { ?>
                <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_ctitle; ?></label>
						<div class="col-sm-10">
							<input type="text" name="nauthor_description[<?php echo $language['language_id']; ?>][ctitle]" value="<?php echo isset($nauthor_description[$language['language_id']]) ? $nauthor_description[$language['language_id']]['ctitle'] : ''; ?>" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_meta_description; ?></label>
						<div class="col-sm-10">
							<textarea name="nauthor_description[<?php echo $language['language_id']; ?>][meta_description]" rows="5" class="form-control"><?php echo isset($nauthor_description[$language['language_id']]) ? $nauthor_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_meta_keyword; ?></label>
						<div class="col-sm-10">
							<textarea name="nauthor_description[<?php echo $language['language_id']; ?>][meta_keyword]"  class="form-control" rows="5"><?php echo isset($nauthor_description[$language['language_id']]) ? $nauthor_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_description; ?></label>
						<div class="col-sm-10">
							<textarea name="nauthor_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($nauthor_description[$language['language_id']]) ? $nauthor_description[$language['language_id']]['description'] : ''; ?></textarea>
						</div>
					</div>
				</div>
			<?php } ?>
        </div>
      </form>
    </div>
  </div>
</div>
</div>
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
$('#description<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
<?php } ?>
//--></script>
<script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script>
<?php echo $footer; ?>