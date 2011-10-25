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

include_once(dirname(__FILE__) . '/../../src/Mercury.class.php');
include_once(dirname(__FILE__) . '/../../src/Response.class.php');


session_start();
extract($_POST);

unset($_POST['action']);
session_regenerate_id(true); // increase session protection 

$action = strtoupper($action);

if ($action == 'LOGIN' && isset($client_id, $token)) {
    $_SESSION['mercury'] = new Mercury($client_id, $token);
    try {
        $response = $_SESSION['mercury']->ping();
        header('Location: app.php'); 
    } catch (Exception $e) {
        unset($_SESSION['mercury']);
        header('Location: index.php');
    }
    exit();
}

if ($action == 'SEND') {
    try {
        $response = $_SESSION['mercury']->send($_POST);
        $results = $response->getResults();
    } catch (Exception $e) {
        $errors = $e->getMessage();
    }
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
    <form method="POST" action="app.php">
    <table>
        <tr><td>Campaign ID</td><td><input type="text" name="campaign_id" /></td></tr>
        <tr><td>To</td><td><input type="text" name="to" /></td></tr>
        <tr><td>From</td><td><input type="text" name="from" /></td></tr>
        <tr><td>Message</td><td><input type="text" name="message" /></td></tr>
        <tr><td>Content ID</td><td><input type="text" name="content_id" /></td></tr>
        <tr><td>Content URL</td><td><input type="text" name="content_url" /></td></tr>
        <tr><td>Callback</td><td><input type="text" name="callback" /></td></tr>
        <tr><td>UDP</td><td><input type="text" name="udp" /></td></tr>

        <input type="hidden" name="action" value="send" />
        <tr><td><input type="submit" value="Submit" id="submit" /></td></tr>
    </table>
    </form>

    <div id="results"><pre><?php print_r($results); ?></pre></div>
    <div id="errors"><?php echo $errors; ?></div>
</body>
</html>
