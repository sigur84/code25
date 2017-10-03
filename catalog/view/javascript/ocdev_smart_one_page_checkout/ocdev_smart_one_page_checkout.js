// masked blocks start
function masked(element, status) {
	if (status == true) {
		$('<div/>')
		.attr('class','smopc-loadmask')
		.prependTo(element);
		$('<div class="smopc-loadmask-loading" />').insertAfter($('.smopc-loadmask'));
	} else {
		$('.smopc-loadmask').remove();
		$('.smopc-loadmask-loading').remove();
	}
}
// masked blocks end

// validate quantity input start
function validate_input(input) {
  input.value = input.value.replace(/[^\d,]/g, '');
}
// validate quantity input end

$(document).on('change', '#guest input[name=\'payment_address\']', function() {
	$('#payment-new').slideToggle();
});

$(document).on('change', '#guest input[name=\'shipping_address\']', function() {
	$('#guest-shipping').slideToggle();
});

$(document).on('change', '#guest-shipping input[name=\'shipping_address\']', function() {
	$('#shipping-new').slideToggle();
});