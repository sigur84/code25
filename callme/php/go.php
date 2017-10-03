<?php
// global backend settings
require('smtp.php');
require('sms.php');
header ('Content-Type: text/html; charset=utf-8');

$to = 'Sales@gorshki.com.ua';

$HTTP_HOST = parse_url('http://'.$_SERVER['HTTP_HOST']);
$HTTP_HOST = str_replace(array ('http://','www.'), '', $HTTP_HOST['host']);

$from = 'noreply@'.$HTTP_HOST;

function say($success = false, $reason = '') 
{
	$res = ($success) ? 'true' : 'false';
	if ($success)
	{
		exit ('{"sent": '.$res.', "reason": "'.$reason.'"}');
	} else {
		exit ('{"sent": '.$res.', "reason": "'.$reason.'"}');
	}
}

function createMessage($data, $sms, $captions) {
	$tmp = '';
	foreach ($data as $item) {
		if ($sms) {
			if ($item['sms'] == 'true') {
				if ($captions == 'true') {
					$tmp .= $item['smsKey'].': '.$item['smsValue'].' ';
				}
				else {
					$tmp .= $item['smsValue'].' ';
				}
			}
		} else {
			if($item['value'] == 'http://gorshki.com.ua/') {}
			$tmp .= '<p><b>'.$item['key'].'</b><br>'.$item['value'].'</p>';
		}
	}
	return $tmp;
}

if (!empty($_POST)) {
	$ip = $_SERVER['REMOTE_ADDR'];
	$subject = 'Перезвоните мне';
	$data = $_POST['data'];
	$sms = $_POST['sms'];
	$message = createMessage($data, false, false);
	$smsBody = createMessage($data, true, $sms['captions']);
	$message = '<div style="margin:10px 0 0;background:#fffce8;border:1px solid #cecece;padding:0 10px">'.$message.'</div>';
	$headers = "Content-type: text/html; charset=utf-8\r\n"; 
	$headers .= "From: gorshki.com.ua <".$from.">\r\n";
	$smtp = $_POST['smtp'];

	if ($sms['send']) {
		if ($sms['cut']) {
			$smsBody = substr($smsBody, 0, 160);
		}
		sendSMS( $smsBody );
	}

	if ($to) {
		if ($smtp == 'true') {
			$sent = smtpmail('', $to, $subject, $message, '');
			say( $sent[0], $sent[1].' smtp' );
		} else {
			$subject = '=?UTF-8?B?'.base64_encode($subject).'?=';
			mail($to, $subject, $message, $headers);
			say( true, 'php' );
		}
	} else {
		say( false, 'No email settings' );
	}

} else {
	say( false, 'No data posted' );
}
?>