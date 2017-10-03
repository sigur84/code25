<div class="ulogin_form">
    <?php if (empty($uloginid)) { ?>
        <div data-ulogin="display=panel;fields=first_name,last_name,email;optional=phone,city,country,nickname,sex,photo_big,bdate,photo;providers=vkontakte,odnoklassniki,facebook,twitter,instagram,google;hidden=;redirect_uri=<?php echo $redirect_uri; ?>;callback=<?php echo $callback; ?>"></div>
    <?php } else { ?>
        <div data-uloginid="<?php echo $uloginid; ?>" data-ulogin="redirect_uri=<?php echo $redirect_uri; ?>;callback=<?php echo $callback; ?>"></div>
    <?php } ?>
</div>
<div style="clear:both"></div>

<script src="//ulogin.ru/js/ulogin.js"></script>
