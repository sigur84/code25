<div class="smopc-panel-group" id="checkout-gift">
<?php if (isset($coupon)) { ?>
<div class="smopc-panel smopc-panel-default">
  <div class="smopc-panel-heading">
    <h4 class="smopc-panel-title"><a href="#collapse-coupon" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"><i class="fa fa-qrcode"></i> <?php echo $heading_coupon_block; ?> <i class="fa fa-caret-down"></i></a></h4>
  </div>
  <div id="collapse-coupon" class="smopc-panel-collapse collapse">
    <div class="smopc-panel-body">
      <label class="smopc-control-label" for="input-coupon"><?php echo $entry_coupon; ?></label>
      <div class="smopc-input-group">
        <input type="text" name="coupon" value="<?php echo $coupon; ?>" placeholder="<?php echo $entry_coupon; ?>" id="input-coupon" class="smopc-form-control" />
        <span class="smopc-input-group-btn">
        <?php if (!empty($coupon)) { ?>
        <input type="button" value="<?php echo $button_remove_coupon; ?>" id="button-remove-coupon" data-loading-text="<?php echo $text_loading; ?>" class="smopc-btn smopc-btn-danger" />
        <?php } ?>
        <input type="button" value="<?php echo $button_coupon; ?>" id="button-coupon" data-loading-text="<?php echo $text_loading; ?>" class="smopc-btn smopc-btn-primary" />
        </span>
       </div>
    </div>
  </div>
</div>
<?php } ?>
<?php if (isset($voucher)) { ?>
<div class="smopc-panel smopc-panel-default">
  <div class="smopc-panel-heading">
    <h4 class="smopc-panel-title"><a href="#collapse-voucher" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><i class="fa fa-gift"></i> <?php echo $heading_voucher_block; ?> <i class="fa fa-caret-down"></i></a></h4>
  </div>
  <div id="collapse-voucher" class="smopc-panel-collapse collapse">
    <div class="smopc-panel-body">
      <label class="smopc-control-label" for="input-voucher"><?php echo $entry_voucher; ?></label>
      <div class="smopc-input-group">
        <input type="text" name="voucher" value="<?php echo $voucher; ?>" placeholder="<?php echo $entry_voucher; ?>" id="input-voucher" class="smopc-form-control" />
        <span class="smopc-input-group-btn">
        <?php if (!empty($voucher)) { ?>
        <input type="button" value="<?php echo $button_remove_voucher; ?>" id="button-remove-voucher" data-loading-text="<?php echo $text_loading; ?>" class="smopc-btn smopc-btn-danger" />
        <?php } ?>
        <input type="button" value="<?php echo $button_voucher; ?>" id="button-voucher" data-loading-text="<?php echo $text_loading; ?>" class="smopc-btn smopc-btn-primary" />
        </span>
      </div>
    </div>
  </div>
</div>
<?php } ?>
<?php if (isset($reward)) { ?>
<div class="smopc-panel smopc-panel-default">
  <div class="smopc-panel-heading">
    <h4 class="smopc-panel-title"><a href="#collapse-reward" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"><i class="fa fa-university"></i> <?php echo $heading_reward_block; ?> <i class="fa fa-caret-down"></i></a></h4>
  </div>
  <div id="collapse-reward" class="smopc-panel-collapse collapse">
    <div class="smopc-panel-body">
      <label class="smopc-control-label" for="input-reward"><?php echo $entry_reward; ?></label>
      <div class="smopc-input-group">
        <input type="text" name="reward" value="<?php echo $reward; ?>" placeholder="<?php echo $entry_reward; ?>" id="input-reward" class="smopc-form-control" />
        <span class="smopc-input-group-btn">
        <?php if (!empty($reward)) { ?>
        <input type="button" value="<?php echo $button_remove_reward; ?>" id="button-remove-reward" data-loading-text="<?php echo $text_loading; ?>" class="smopc-btn smopc-btn-danger" />
        <?php } ?>
        <input type="submit" value="<?php echo $button_reward; ?>" id="button-reward" data-loading-text="<?php echo $text_loading; ?>" class="smopc-btn smopc-btn-primary" />
        </span>
      </div>
    </div>
  </div>
</div>
<?php } ?>
<?php if (isset($voucher)) { ?>
<script type="text/javascript"><!--
// voucher apply start
$(document).on('click', '#button-voucher', function() {
  $.ajax({
    url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/apply_voucher',
    type: 'post',
    data: 'voucher=' + encodeURIComponent($('input[name=\'voucher\']').val()),
    dataType: 'json',
    beforeSend: function() {
      $('#button-voucher').button('loading');
    },
    complete: function() {
      $('#button-voucher').button('reset');
    },
    success: function(json) {
      $('#collapse-voucher .smopc-alert').remove();
      if (json['error']) {
        $('#collapse-voucher .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
        masked('#checkout-cart, #collapse-voucher .smopc-panel-body', true);
        $.ajax({
          url: 'index.php?route=checkout/ocdev_smart_one_page_checkout',
          dataType: 'html',
          success: function(data) {
            <?php if (isset($checkout_blocks) && in_array('cart', $checkout_blocks)) { ?>$('#checkout-cart').html($(data).find('#checkout-cart > *'));<?php } ?>
            $('#collapse-voucher').html($(data).find('#collapse-voucher > *'));
            masked('#checkout-cart, #collapse-voucher .smopc-panel-body', false);
            $('#collapse-voucher .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-success"><i class="fa fa-exclamation-circle"></i> ' + json['success'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
          }
        });
      }
    }
  });
});
// voucher apply end

// voucher remove start
$(document).on('click', '#button-remove-voucher', function() {
  $.ajax({
    url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/remove_voucher',
    dataType: 'json',
    beforeSend: function() {
      $('#button-remove-voucher').button('loading');
    },
    complete: function() {
      $('#button-remove-voucher').button('reset');
    },
    success: function(json) {
      masked('#checkout-cart, #collapse-voucher .smopc-panel-body', true);
      $.ajax({
        url: 'index.php?route=checkout/ocdev_smart_one_page_checkout',
        dataType: 'html',
        success: function(data) {
          <?php if (isset($checkout_blocks) && in_array('cart', $checkout_blocks)) { ?>$('#checkout-cart').html($(data).find('#checkout-cart > *'));<?php } ?>
          $('#collapse-voucher').html($(data).find('#collapse-voucher > *'));
          masked('#checkout-cart, #collapse-voucher .smopc-panel-body', false);
        }
      });
    }
  });
});
// voucher remove end
//--></script>
<?php } ?>
<?php if (isset($coupon)) { ?>
<script type="text/javascript"><!--
// coupon apply start
$(document).on('click', '#button-coupon', function() {
  $.ajax({
    url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/apply_coupon',
    type: 'post',
    data: 'coupon=' + encodeURIComponent($('input[name=\'coupon\']').val()),
    dataType: 'json',
    beforeSend: function() {
      $('#button-coupon').button('loading');
    },
    complete: function() {
      $('#button-coupon').button('reset');
    },
    success: function(json) {
      $('#collapse-coupon .smopc-alert').remove();
      if (json['error']) {
        $('#collapse-coupon .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
        masked('#checkout-cart, #collapse-coupon .smopc-panel-body', true);
        $.ajax({
          url: 'index.php?route=checkout/ocdev_smart_one_page_checkout',
          dataType: 'html',
          success: function(data) {
            <?php if (isset($checkout_blocks) && in_array('cart', $checkout_blocks)) { ?>$('#checkout-cart').html($(data).find('#checkout-cart > *'));<?php } ?>
            $('#collapse-coupon').html($(data).find('#collapse-coupon > *'));
            masked('#checkout-cart, #collapse-coupon .smopc-panel-body', false);
            $('#collapse-coupon .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-success"><i class="fa fa-exclamation-circle"></i> ' + json['success'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
          }
        });
      }
    }
  });
});
// coupon apply end

// coupon remove start
$(document).on('click', '#button-remove-coupon', function() {
  $.ajax({
    url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/remove_coupon',
    dataType: 'json',
    beforeSend: function() {
      $('#button-remove-coupon').button('loading');
    },
    complete: function() {
      $('#button-remove-coupon').button('reset');
    },
    success: function(json) {
      masked('#checkout-cart, #collapse-coupon .smopc-panel-body', true);
      $.ajax({
        url: 'index.php?route=checkout/ocdev_smart_one_page_checkout',
        dataType: 'html',
        success: function(data) {
          <?php if (isset($checkout_blocks) && in_array('cart', $checkout_blocks)) { ?>$('#checkout-cart').html($(data).find('#checkout-cart > *'));<?php } ?>
          $('#collapse-coupon').html($(data).find('#collapse-coupon > *'));
          masked('#checkout-cart, #collapse-coupon .smopc-panel-body', false);
        }
      });
    }
  });
});
// coupon remove end
//--></script>
<?php } ?>
<?php if (isset($reward)) { ?>
<script type="text/javascript"><!--
// reward apply start
$(document).on('click', '#button-reward', function() {
  $.ajax({
    url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/apply_reward',
    type: 'post',
    data: 'reward=' + encodeURIComponent($('input[name=\'reward\']').val()),
    dataType: 'json',
    beforeSend: function() {
      $('#button-reward').button('loading');
    },
    complete: function() {
      $('#button-reward').button('reset');
    },
    success: function(json) {
      $('#collapse-reward .smopc-alert').remove();
      if (json['error']) {
        $('#collapse-reward .smopc-panel-body').prepend('<div class="smopc-alert alert smopc-alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
      }
      if (json['success']) {
        masked('#checkout-cart, #collapse-reward .smopc-panel-body', true);
        $.ajax({
          url: 'index.php?route=checkout/ocdev_smart_one_page_checkout',
          dataType: 'html',
          success: function(data) {
            <?php if (isset($checkout_blocks) && in_array('cart', $checkout_blocks)) { ?>$('#checkout-cart').html($(data).find('#checkout-cart > *'));<?php } ?>
            $('#collapse-reward').html($(data).find('#collapse-reward > *'));
            masked('#checkout-cart, #collapse-reward .smopc-panel-body', false);
            $('#collapse-reward .smopc-panel-body').prepend('<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> ' + json['success'] + '<button type="button" class="smopc-close" data-dismiss="alert">&times;</button></div>');
          }
        });
      }
    }
  });
});
// reward apply end

// reward remove start
$(document).on('click', '#button-remove-reward', function() {
  $.ajax({
    url: 'index.php?route=checkout/ocdev_smart_one_page_checkout/remove_reward',
    dataType: 'json',
    beforeSend: function() {
      $('#button-remove-reward').button('loading');
    },
    complete: function() {
      $('#button-remove-reward').button('reset');
    },
    success: function(json) {
      masked('#checkout-cart, #collapse-reward .smopc-panel-body', true);
      $.ajax({
        url: 'index.php?route=checkout/ocdev_smart_one_page_checkout',
        dataType: 'html',
        success: function(data) {
          <?php if (isset($checkout_blocks) && in_array('cart', $checkout_blocks)) { ?>$('#checkout-cart').html($(data).find('#checkout-cart > *'));<?php } ?>
          $('#collapse-reward').html($(data).find('#collapse-reward > *'));
          masked('#checkout-cart, #collapse-reward .smopc-panel-body', false);
        }
      });
    }
  });
});
// reward remove end
//--></script>
<?php } ?>
</div>
