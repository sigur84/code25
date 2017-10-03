<?php

// @category  : OpenCart
// @module    : Smart One Page Checkout
// @author    : OCdevWizard <ocdevwizard@gmail.com> 
// @copyright : Copyright (c) 2015, OCdevWizard
// @license   : http://license.ocdevwizard.com/Licensing_Policy.pdf

class Smopc {

	public function get() {

		if ($_SERVER['REQUEST_METHOD'] == 'POST') {
			foreach ($_POST as $key => $value) {
				$_SESSION['smopc_data']['post'][$key] = $value; 
			}
		}

		if ($_SERVER['REQUEST_METHOD'] == 'GET') {
			foreach ($_GET as $key => $value) {
				$_SESSION['smopc_data']['get'][$key] = $value; 
			}
		}

		$result = (isset($_SESSION['smopc_data'])) ? $_SESSION['smopc_data'] : array();

		return $result;
	}
}
?>