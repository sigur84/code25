<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-featured" data-toggle="tooltip" title="<?php echo $entry_button_save; ?>" class="btn btn-primary"><?php echo $entry_button_save?></button>
				<a class="btn btn-success" onclick="$('#action').val('saveedit');$('#form-featured').submit();" data-toggle="tooltip" title="<?php echo $entry_button_save_and_stay; ?>" ><?php echo $entry_button_save_and_stay?></a>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $entry_button_cancel; ?>" class="btn btn-danger"><?php echo $entry_button_cancel?></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
			<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>
		<?php if (isset($success) && !empty($success)) { ?>
			<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
			<div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_layout; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>
    <div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
		</div>
		<div class="panel-body">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-featured" class="form-horizontal">
				<div class="form-group"> <!--Module Name -->
					<input type="hidden" name="action" id="action" value=""/>
					<input type="hidden" name="moduleid" value="<?php echo $moduleid; ?>" />
					<label class="col-sm-3 control-label" for="input-name"><?php echo $entry_name; ?> <b style="color:#f00">*</b></label>
						<div class="col-sm-9">
							<div class="col-sm-5">
								<input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
							</div>
							<?php if ($error_name) { ?>
								<div class="text-danger col-sm-12"><?php echo $error_name; ?></div>
							<?php }else{ ?>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_name_desc ?></i>
							<?php } ?>
						</div>
				</div>
				<div class="form-group"> <!--Header title-->
					<label class="col-sm-3 control-label" for="input-head_name"><?php echo $entry_head_name; ?> <b style="color:#f00">*</b></label>
					<div class="col-sm-9">
						<div class="col-sm-5">
							<?php
								$i = 0;
								foreach ($languages as $language) { $i++; ?>
							<input type="text" name="module_description[<?php echo $language['language_id']; ?>][head_name]" placeholder="<?php echo $entry_head_name; ?>" id="input-head-name-<?php echo $language['language_id']; ?>" value="<?php echo isset($module_description[$language['language_id']]['head_name']) ? $module_description[$language['language_id']]['head_name'] : ''; ?>" class="form-control <?php echo ($i>1) ? ' hide ' : ' first-name'; ?>" />
							<?php
									 if($i == 1){ ?>
							<input type="hidden" class="form-control" id="input-head_name" placeholder="Module Head Name" value="<?php echo isset($module_description[$language['language_id']]['head_name']) ? $module_description[$language['language_id']]['head_name'] : ''; ?>" name="head_name">
							<?php }
									 ?>
							<?php } ?>
						</div>
						<div class="col-sm-3">
							<select  class="form-control" id="language">
								<?php foreach ($languages as $language) { ?>
								<option value="<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></option>
								<?php } ?>
							</select>
						</div>
						<?php if ($error_head_name) { ?>
						<div class="text-danger col-sm-12"><?php echo $error_head_name; ?></div>
						<?php }else { ?>
						<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_head_name_desc ?></i>
						<?php } ?>

					</div>
				</div>
				<div class="form-group"> <!--Display header title -->
					<label class="col-sm-3 control-label" for="input-disp_title_module"><?php echo $entry_display_title_module; ?></label>
					<div class="col-sm-9">
						<div class="col-sm-5">
							<select name="disp_title_module" id="input-disp_title_module" class="form-control">
								<?php if ($disp_title_module) { ?>
								<option value="1" selected="selected"><?php echo $text_yes; ?></option>
								<option value="0"><?php echo $text_no; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_yes; ?></option>
								<option value="0" selected="selected"><?php echo $text_no; ?></option>
								<?php } ?>
							</select>
						</div>
						<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_display_title_module_desc ?></i>
					</div>
				</div>
				<div class="form-group"> <!--Status -->
					<label class="col-sm-3 control-label" for="input-status"><?php echo $entry_status; ?></label>
					<div class="col-sm-9">
						<div class="col-sm-5">
							<select name="status" id="input-status" class="form-control">
								<?php if ($status) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>
						</div>
						<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_status_desc ?></i>
					</div>
				</div>
				
			<div class="tab-pane">
				<ul class="nav nav-tabs" id="so_youtech">
					<li>
						<a href="#so_module_module" data-toggle="tab">
							<?php echo $entry_module ?>
						</a>
					</li>
					<li>
						<a href="#so_module_blog_option" data-toggle="tab">
							<?php echo $entry_blog_option ?>
						</a>
					</li>
					<li>
						<a href="#so_module_image_option" data-toggle="tab">
							<?php echo $entry_image_option ?>
						</a>
					</li>
					<li>
						<a href="#virtuemart_effect_option" data-toggle="tab">
							<?php echo $entry_effect_option ?>
						</a>
					</li>
				</ul>
				<div class="tab-content">
			<!-- ----------------------------------------------------------------------- -->
					<div class="tab-pane" id="so_module_module"> <!--General Option -->
						<div class="form-group"> <!--Class suffix -->
							<label class="col-sm-3 control-label" for="input-class_suffix"><?php echo $entry_class_suffix; ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<input type="text" name="class_suffix" value="<?php echo $class_suffix; ?>" id="input-class_suffix" class="form-control" />
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_class_suffix_desc ?></i>
							</div>
						</div>
						<div class="form-group"> <!--Open link -->
							<label class="col-sm-3 control-label" for="input-open_link"><?php echo $entry_open_link ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<select name="item_link_target" id="input-open_link" class="form-control">
										<?php 
											foreach($item_link_targets as $option_id => $option_value)
											{
												$selected = ($option_id == $item_link_target) ? 'selected' :'';
										?>
												<option value="<?php echo $option_id ?>" <?php echo $selected ?> ><?php echo $option_value ?></option>
										<?php
											}
										?>
									</select>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_open_link_desc ?></i>
							</div>
						</div>
						<div class="form-group"> <!--Limit -->
							<label class="col-sm-3 control-label" for="input-limit"><?php echo $entry_limit; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<input type="text" name="limit" value="<?php echo $limit; ?>" id="input-limit" class="form-control" />
								</div>
								<?php if ($error_limit) { ?>
									<div class="text-danger col-sm-12"><?php echo $error_limit; ?></div>
								<?php }else{ ?>
									<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_limit_desc ?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="input-button_page"><?php echo $entry_button_page ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<select name="button_page" id="input-button_page" class="form-control">
										<?php
											foreach($button_pages as $option_id => $option_value)
										{
										$selected = ($option_id == $button_page) ? 'selected' :'';
										?>
										<option value="<?php echo $option_id ?>" <?php echo $selected ?> ><?php echo $option_value ?></option>
										<?php
											}
										?>
									</select>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_button_page_desc ?></i>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="input-column_1200"><?php echo $entry_column ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<select name="nb_column0" id="input-column_1200" class="form-control">
										<?php
										foreach($nb_columns as $option_id => $option_value)
										{
										$selected = ($option_id == $nb_column0) ? 'selected' :'';
										?>
										<option value="<?php echo $option_id ?>" <?php echo $selected ?> ><?php echo $option_value ?></option>
										<?php
											}
										?>
									</select>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_nb_column0_desc?></i>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="input-column_992"><?php echo $entry_column ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<select name="nb_column1" id="input-column_992" class="form-control">
										<?php
										foreach($nb_columns as $option_id => $option_value)
										{
										$selected = ($option_id == $nb_column1) ? 'selected' :'';
										?>
										<option value="<?php echo $option_id ?>" <?php echo $selected ?> ><?php echo $option_value ?></option>
										<?php
											}
										?>
									</select>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_nb_column1_desc?></i>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label" for="input-column_768_992"><?php echo $entry_column ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<select name="nb_column2" id="input-column_768_992" class="form-control">
										<?php
										foreach($nb_columns as $option_id => $option_value)
										{
										$selected = ($option_id == $nb_column2) ? 'selected' :'';
										?>
										<option value="<?php echo $option_id ?>" <?php echo $selected ?> ><?php echo $option_value ?></option>
										<?php
											}
										?>
									</select>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_nb_column2_desc?></i>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label" for="input-column_480_767"><?php echo $entry_column ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<select name="nb_column3" id="input-column_480_767" class="form-control">
										<?php
										foreach($nb_columns as $option_id => $option_value)
										{
										$selected = ($option_id == $nb_column3) ? 'selected' :'';
										?>
										<option value="<?php echo $option_id ?>" <?php echo $selected ?> ><?php echo $option_value ?></option>
										<?php
											}
										?>
									</select>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_nb_column3_desc?></i>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="input-column_0_479"><?php echo $entry_column ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<select name="nb_column4" id="input-column_0_479" class="form-control">
										<?php
										foreach($nb_columns as $option_id => $option_value)
										{
										$selected = ($option_id == $nb_column4) ? 'selected' :'';
										?>
										<option value="<?php echo $option_id ?>" <?php echo $selected ?> ><?php echo $option_value ?></option>
										<?php
											}
										?>
									</select>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_nb_column4_desc?></i>
							</div>
						</div>
						<div class="form-group"> <!--Type show-->
							<label class="col-sm-3 control-label" for="input-type_show"><?php echo $entry_type_show ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<select name="type_show" id="input-type_show" class="form-control">
										<?php
										foreach($type_shows as $option_id => $type)
										{
										$selected = ($option_id == $type_show) ? 'selected' :'';
										?>
										<option value="<?php echo $option_id ?>" <?php echo $selected ?> ><?php echo $type ?></option>
										<?php
											}
										?>
									</select>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_type_show_desc ?></i>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="input-nb_row"><?php echo $entry_nb_row ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<select name="nb_row" id="input-nb_row" class="form-control">
										<?php
										foreach($nb_rows as $option_id => $option_value)
										{
										$selected = ($option_id == $nb_row) ? 'selected' :'';
										?>
										<option value="<?php echo $option_id ?>" <?php echo $selected ?> ><?php echo $option_value ?></option>
										<?php
											}
										?>
									</select>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_nb_row_desc?></i>
							</div>
						</div>
					</div>
			
			<!-- ----------------------------------------------------------------------- -->
					<div class="tab-pane" id="so_module_blog_option"> <!--blog Option -->
						<div class="form-group"> <!--Display Title -->
							<label class="col-sm-3 control-label" for="input-display_title"><?php echo $entry_display_title; ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($display_title) { ?>
										<input type="radio" name="display_title" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="display_title" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$display_title) { ?>
										<input type="radio" name="display_title" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="display_title" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_display_title_desc ?></i>
							</div>
						</div>
						<div class="form-group"> <!--Title Maxlength -->
							<label class="col-sm-3 control-label" for="input-title_maxlength"><?php echo $entry_title_maxlength; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<input type="text" name="title_maxlength" value="<?php echo $title_maxlength; ?>" id="input-title_maxlength" class="form-control" />
								</div>
								<?php if ($error_title_maxlength) { ?>
									<div class="text-danger col-sm-12"><?php echo $error_title_maxlength; ?></div>
								<?php }else{ ?>
									<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_title_maxlength_desc ?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group"> <!--Display Description -->
							<label class="col-sm-3 control-label" for="input-display_description"><?php echo $entry_display_description; ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($display_description) { ?>
										<input type="radio" name="display_description" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="display_description" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$display_description) { ?>
										<input type="radio" name="display_description" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="display_description" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_display_description_desc ?></i>
							</div>
						</div>
						<div class="form-group"> <!--Description Maxlength -->
							<label class="col-sm-3 control-label" for="input-description_maxlength"><?php echo $entry_description_maxlength; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<input type="text" name="description_maxlength" value="<?php echo $description_maxlength; ?>" id="input-description_maxlength" class="form-control" />
								</div>
								<?php if ($error_description_maxlength) { ?>
									<div class="text-danger col-sm-12"><?php echo $error_description_maxlength; ?></div>
								<?php }else{ ?>
									<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_description_maxlength_desc ?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group"> <!--Display Author -->
							<label class="col-sm-3 control-label" for="input-display_author"><?php echo $entry_display_author; ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($display_author) { ?>
										<input type="radio" name="display_author" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="display_author" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$display_author) { ?>
										<input type="radio" name="display_author" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="display_author" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_display_author_desc ?></i>
							</div>
						</div>
						<div class="form-group"> <!--Display comment -->
							<label class="col-sm-3 control-label" for="input-display_comment"><?php echo $entry_display_comment; ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($display_comment) { ?>
										<input type="radio" name="display_comment" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="display_comment" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$display_comment) { ?>
										<input type="radio" name="display_comment" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="display_comment" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_display_comment_desc ?></i>
							</div>
						</div>
						<div class="form-group"> <!--Display view -->
							<label class="col-sm-3 control-label" for="input-display_view"><?php echo $entry_display_view; ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($display_view) { ?>
										<input type="radio" name="display_view" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="display_view" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$display_view) { ?>
										<input type="radio" name="display_view" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="display_view" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_display_view_desc ?></i>
							</div>
						</div>
						<div class="form-group"> <!--Display date added -->
							<label class="col-sm-3 control-label" for="input-display_date_added"><?php echo $entry_display_date_added; ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($display_date_added) { ?>
										<input type="radio" name="display_date_added" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="display_date_added" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$display_date_added) { ?>
										<input type="radio" name="display_date_added" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="display_date_added" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_display_date_added_desc ?></i>
							</div>
						</div>
						<div class="form-group"> <!--Display Readmore -->
							<label class="col-sm-3 control-label" for="input-display_readmore"><?php echo $entry_display_readmore; ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($display_readmore) { ?>
										<input type="radio" name="display_readmore" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="display_readmore" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$display_readmore) { ?>
										<input type="radio" name="display_readmore" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="display_readmore" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_display_readmore_desc ?></i>
							</div>
						</div>
						<div class="form-group"> <!--Readmore text -->
							<label class="col-sm-3 control-label" for="input-readmore_text"><?php echo $entry_readmore_text; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<input type="text" name="readmore_text" value="<?php echo $readmore_text; ?>" id="input-readmore_text" class="form-control" />
								</div>
								<?php if ($error_readmore_text) { ?>
									<div class="text-danger col-sm-12"><?php echo $error_readmore_text; ?></div>
								<?php }else{ ?>
									<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_readmore_text_desc ?></i>
								<?php } ?>
							</div>
						</div>
						
					</div>
			<!-- ----------------------------------------------------------------------- -->
					<div class="tab-pane" id="so_module_image_option">  <!--Image Option -->
						<div class="form-group"> <!--blog Image -->
							<label class="col-sm-3 control-label" for="input-blog_image"><?php echo $entry_blog_image; ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($blog_image) { ?>
										<input type="radio" name="blog_image" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="blog_image" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$blog_image) { ?>
										<input type="radio" name="blog_image" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="blog_image" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_blog_image_desc ?></i>
							</div>
						</div>
						<div class="form-group"> <!--blog Get Image From Tab Image -->
							<label class="col-sm-3 control-label" for="input-blog_get_featured_image"><?php echo $entry_blog_get_featured_image; ?></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($blog_get_featured_image) { ?>
										<input type="radio" name="blog_get_featured_image" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="blog_get_featured_image" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$blog_get_featured_image) { ?>
										<input type="radio" name="blog_get_featured_image" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="blog_get_featured_image" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_blog_get_featured_image_desc ?></i>
							</div>
						</div>
						<div class="form-group"> <!--blog Width -->
							<label class="col-sm-3 control-label" for="input-width"><?php echo $entry_width; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<input type="text" name="width" value="<?php echo $width; ?>" id="input-width" class="form-control" />
								</div>
								<?php if ($error_width) { ?>
									<div class="text-danger col-sm-12"><?php echo $error_width; ?></div>
								<?php }else { ?>
									<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_width_desc ?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group"> <!--blog height -->
							<label class="col-sm-3 control-label" for="input-height"><?php echo $entry_height; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<input type="text" name="height" value="<?php echo $height; ?>" id="input-height" class="form-control" />
								</div>								
								<?php if ($error_height) { ?>
									<div class="text-danger col-sm-12"><?php echo $error_height; ?></div>
								<?php }else{ ?>
									<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_height_desc ?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group"> <!--Placeholder Path -->
							<label class="col-sm-3 control-label" for="input-blog_placeholder_path"><?php echo $entry_blog_placeholder_path; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-9">
								<div class="col-sm-5">
									<input type="text" name="blog_placeholder_path" value="<?php echo $blog_placeholder_path; ?>" id="input-blog_placeholder_path" class="form-control" />
								</div>	
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_blog_placeholder_path_desc ?></i>
							</div>
						</div>
					</div>
			<!-- ----------------------------------------------------------------------- -->
					<!-- ----------------------------------------------------------------------- -->
					<div class="tab-pane" id="virtuemart_effect_option">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-margin"><?php echo $entry_margin; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<input type="text" name="margin" value="<?php echo $margin; ?>" id="input-margin" class="form-control" />
								</div>
								<?php if ($error_margin) { ?>
								<div class="text-danger col-sm-12"><?php echo $error_margin; ?></div>
								<?php }else{ ?>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_margin_desc?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-slideBy"><?php echo $entry_slideBy; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<input type="text" name="slideBy" value="<?php echo $slideBy; ?>" id="input-slideBy" class="form-control" />
								</div>
								<?php if ($error_slideBy) { ?>
								<div class="text-danger col-sm-12"><?php echo $error_slideBy; ?></div>
								<?php }else{ ?>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_slideBy_desc?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-autoplay"><?php echo $entry_autoplay; ?></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<select name="autoplay" id="input-autoplay" class="form-control">
										<?php if ($autoplay) { ?>
										<option value="1" selected="selected"><?php echo $text_yes; ?></option>
										<option value="0"><?php echo $text_no; ?></option>
										<?php } else { ?>
										<option value="1"><?php echo $text_yes; ?></option>
										<option value="0" selected="selected"><?php echo $text_no; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-autoplay_timeout"><?php echo $entry_autoplay_timeout; ?> <b style="color:#f00">*</b></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<input type="text" name="autoplay_timeout" value="<?php echo $autoplay_timeout; ?>" id="input-autoplay_timeout" class="form-control" />
								</div>
								<?php if (!empty($error_autoplay_timeout)) { ?>
								<div class="text-danger col-sm-12"><?php echo $error_autoplay_timeout; ?></div>
								<?php }else { ?>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_autoplay_timeout_desc ?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-pausehover"><?php echo $entry_pausehover; ?></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<select name="pausehover" id="input-pausehover" class="form-control">
										<?php if ($pausehover) { ?>
										<option value="1" selected="selected"><?php echo $text_yes; ?></option>
										<option value="0"><?php echo $text_no; ?></option>
										<?php } else { ?>
										<option value="hover"><?php echo $text_yes; ?></option>
										<option value="0" selected="selected"><?php echo $text_no; ?></option>
										<?php } ?>
									</select>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_pausehover_desc ?></i>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-autoplaySpeed"><?php echo $entry_autoplaySpeed; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<input type="text" name="autoplaySpeed" value="<?php echo $autoplaySpeed; ?>" id="input-autoplaySpeed" class="form-control" />
								</div>
								<?php if ($error_autoplaySpeed) { ?>
								<div class="text-danger col-sm-12"><?php echo $error_autoplaySpeed; ?></div>
								<?php }else{ ?>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_autoplaySpeed_desc?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-smartSpeed"><?php echo $entry_smartSpeed; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<input type="text" name="smartSpeed" value="<?php echo $smartSpeed; ?>" id="input-smartSpeed" class="form-control" />
								</div>
								<?php if ($error_smartSpeed) { ?>
								<div class="text-danger col-sm-12"><?php echo $error_smartSpeed; ?></div>
								<?php }else{ ?>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_smartSpeed_desc?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-startPosition"><?php echo $entry_startPosition; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<input type="text" name="startPosition" value="<?php echo $startPosition; ?>" id="input-startPosition" class="form-control" />
								</div>
								<?php if ($error_startPosition) { ?>
								<div class="text-danger col-sm-12"><?php echo $error_startPosition; ?></div>
								<?php }else{ ?>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_startPosition_desc?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-mouseDrag"><?php echo $entry_mouseDrag; ?></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($mouseDrag) { ?>
										<input type="radio" name="mouseDrag" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="mouseDrag" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$mouseDrag) { ?>
										<input type="radio" name="mouseDrag" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="mouseDrag" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_mouseDrag_desc ?></i>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-touchDrag"><?php echo $entry_touchDrag; ?></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($touchDrag) { ?>
										<input type="radio" name="touchDrag" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="touchDrag" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$touchDrag) { ?>
										<input type="radio" name="touchDrag" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="touchDrag" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_touchDrag_desc ?></i>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-effect"><?php echo $entry_effect; ?></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<select name="effect" id="input-effect" class="form-control">
										<?php
										foreach($effects as $option_id => $option_value)
										{
										$selected = ($option_id == $effect) ? 'selected' :'';
										?>
										<option value="<?php echo $option_id ?>" <?php echo $selected ?> ><?php echo $option_value ?></option>
										<?php
											}
										?>
									</select>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-dots"><?php echo $entry_dots; ?></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($dots) { ?>
										<input type="radio" name="dots" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="dots" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$dots) { ?>
										<input type="radio" name="dots" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="dots" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_dots_desc ?></i>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-dotsSpeed"><?php echo $entry_dotsSpeed; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<input type="text" name="dotsSpeed" value="<?php echo $dotsSpeed; ?>" id="input-dotsSpeed" class="form-control" />
								</div>
								<?php if ($error_dotsSpeed) { ?>
								<div class="text-danger col-sm-12"><?php echo $error_dotsSpeed; ?></div>
								<?php }else{ ?>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_dotsSpeed_desc?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-navs"><?php echo $entry_navs; ?></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<label class="radio-inline">
										<?php if ($navs) { ?>
										<input type="radio" name="navs" value="1" checked="checked" />
										<?php echo $text_yes; ?>
										<?php } else { ?>
										<input type="radio" name="navs" value="1" />
										<?php echo $text_yes; ?>
										<?php } ?>
									</label>
									<label class="radio-inline">
										<?php if (!$navs) { ?>
										<input type="radio" name="navs" value="0" checked="checked" />
										<?php echo $text_no; ?>
										<?php } else { ?>
										<input type="radio" name="navs" value="0" />
										<?php echo $text_no; ?>
										<?php } ?>
									</label>
								</div>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_navs_desc ?></i>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-navSpeed"><?php echo $entry_navspeed; ?> <b style="font-weight:bold; color:#f00">*</b></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<input type="text" name="navSpeed" value="<?php echo $navSpeed; ?>" id="input-navSpeed" class="form-control" />
								</div>
								<?php if ($error_navSpeed) { ?>
								<div class="text-danger col-sm-12"><?php echo $error_navSpeed; ?></div>
								<?php }else{ ?>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_navspeed_desc?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-duration"><?php echo $entry_duration; ?> <b style="color:#f00">*</b></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<input type="text" name="duration" value="<?php echo $duration; ?>" id="input-duration" class="form-control" />
								</div>
								<?php if ($error_duration) { ?>
								<div class="text-danger col-sm-12"><?php echo $error_duration; ?></div>
								<?php }else { ?>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_duration_desc ?></i>
								<?php } ?>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-delay"><?php echo $entry_delay; ?> <b style="color:#f00">*</b></label>
							<div class="col-sm-10">
								<div class="col-sm-5">
									<input type="text" name="delay" value="<?php echo $delay; ?>" id="input-delay" class="form-control" />
								</div>
								<?php if (!empty($error_delay)) { ?>
								<div class="text-danger col-sm-12"><?php echo $error_delay; ?></div>
								<?php }else { ?>
								<i class="col-sm-12" style="font-weight:normal; color:#ccc"><?php echo $entry_delay_desc ?></i>
								<?php } ?>
							</div>
						</div>


					</div>
					<!-- --------------------------------------------------------------- -->
				</div>
			</div>
        </form>
      </div>
    </div>	
  </div>
 
<script type="text/javascript"><!--
	$('#so_youtech a:first').tab('show');
	$('#language').change(function(){
		var that = $(this), opt_select = $('option:selected', that).val() , _input = $('#input-head-name-'+opt_select);
		$('[id^="input-head-name-"]').addClass('hide');
		_input.removeClass('hide');
	});
	$('.first-name').change(function(){
		$('input[name="head_name"]').val($(this).val());
	});
//--></script>
</div>
<?php echo $footer; ?>