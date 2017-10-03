<div class="smopc-panel smopc-panel-default" id="login">
	<div class="smopc-panel-heading">
		<h4 class="smopc-panel-title"><i class="fa fa-sign-in"></i> <?php echo $heading_login_block; ?> <a class="smopc-pull-right" href="<?php echo $forgotten; ?>"><small><?php echo $text_forgotten; ?> <i class="fa fa-question"></i></small></a></h4>
	</div>
	<div class="smopc-panel-collapse">
		<div class="smopc-panel-body" >
			<p><?php echo $text_i_am_returning_customer; ?></p>
			<div class="smopc-form-group">
				<label class="smopc-control-label" for="input-email"><?php echo $entry_email; ?></label>
				<input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="smopc-form-control" />
			</div>
			<div class="smopc-form-group">
				<label class="smopc-control-label" for="input-password"><?php echo $entry_password; ?></label>
				<input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="smopc-form-control" />
			</div>
			<input type="button" value="<?php echo $button_login; ?>" id="button-login" data-loading-text="<?php echo $text_loading; ?>" class="smopc-btn smopc-btn-primary" />
		</div>
	</div>
</div>
<script type="text/javascript"><!--
$(document).delegate('#button-login', 'click', function() {
	masked('#login', true);
	$.ajax({
		url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/login_save',
		type: 'post',
		data: $('#login :input'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-login').button('loading');
		},
		complete: function() {
			$('#button-login').button('reset');
		},
		success: function(json) {
			masked('#login', false);
			$('#login .smopc-alert, #login .smopc-text-danger').remove();
			$('#login .smopc-form-group').removeClass('has-error');

			if (json['redirect']) {
					location = json['redirect'];
			} else if (json['error']) {
				masked('#login', false);
				$('#login .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
				$('#login input[name=\'email\']').parent().addClass('has-error');
				$('#login input[name=\'password\']').parent().addClass('has-error');
			}
		}
	});
});
//--></script>
