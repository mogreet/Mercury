<?php

/**
* Copyright 2011 Jonathan Perichon <jonathan.perichon@gmail.com>
*
* This file is part of Mercury.
*
* Mercury is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Mercury is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Mercury.  If not, see <http://www.gnu.org/licenses/>.
*/

include_once('facebook-php-sdk/facebook.php');
$facebook = new Facebook(array(
    'appId' => '138551006241246',
    'secret' => 'c1e8ce102cdc1d26fef0b6ba479c0759',
));
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Demo</title>
	<script src="js/jquery-1.6.2.js"></script>
	<script src="js/script.js"></script>
	<script src="ui/jquery.ui.core.js"></script>
	<script src="ui/jquery.ui.widget.js"></script>
	<script src="ui/jquery.ui.tabs.js"></script>
	<script src="ui/jquery.ui.button.js"></script>

	<link rel="stylesheet" href="ui/redmond/jquery-ui-1.8.16.custom.css">
        <link rel="stylesheet" href="ui/demo.css">
    </head>
<body>

<?php
$jperichon = $facebook->api('/jonathan.perichon');
echo '<h1>Hello, my name on facebook is ' . $jperichon['name'] . ' and my locale is ' . $jperichon['locale'] . '.</h1>';
?>
</body>
</html>
