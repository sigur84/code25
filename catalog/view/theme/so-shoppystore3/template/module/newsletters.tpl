<script>
		function subscribe()
		{
			var emailpattern = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
			var email = $('#txtemail').val();
			if(email != "")
			{
				if(!emailpattern.test(email))
				{
					alert("Invalid Email");
					return false;
				}
				else
				{
					$.ajax({
						url: 'index.php?route=module/newsletters/news',
						type: 'post',
						data: 'email=' + $('#txtemail').val(),
						dataType: 'json',
						
									
						success: function(json) {
						
						alert(json.message);
						
						}
						
					});
					return false;
				}
			}
			else
			{
				alert("Email Is Require");
				$(email).focus();
				return false;
			}
			

		}
	</script>
	
<div class="newsletter">

		<div class="group-form">
				<form action="#" method="post">
					<div class="form-group required">
							<div class="input-box">
							  <input type="email" name="txtemail" id="txtemail" value="" placeholder="<?php echo $email_text;?>" class="form-control input-lg"  /> 
							</div>
							<div class="subcribe">
									<button type="submit" class="btn btn-default btn-lg" onclick="return subscribe();"><?php echo $Subscribe_text?></button>  
									
							</div>
					</div>
					
				</form>
		</div>
		<div class="group-content">
				<h2><?php echo $heading_title1; ?></h2>
				<p class="page-heading-sub" data-scroll-reveal="enter bottom and move 40px over 0.6s">
						<?php echo $description1; ?>
										
				</p>
		</div>

</div>
