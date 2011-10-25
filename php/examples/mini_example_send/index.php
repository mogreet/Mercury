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


session_start();
session_regenerate_id(true); // increase session protection 

if (isset($_SESSION['mercury'])) {
    header('Location: app.php');
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Mercury for PHP</title>
</head>

<body>
    <form action="app.php" method="POST">
    <table>
        <tr><td>Client ID</td><td><input type="text" name="client_id" id="client_id" /></td></tr>
        <tr><td>Token</td><td><input type="text" name="token" id="token" /></td></tr>
        <input type="hidden" name="action" value="login" />
        <tr><td><input type="submit" value="Submit" id="submit" /></td></tr>
    </table>
    </form>
</body>
</html>
