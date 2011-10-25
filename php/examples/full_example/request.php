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
    } catch (Exception $e) {
        unset($_SESSION['mercury']);
        header('HTTP/1.1 500 Internal Server Error');
    }
    exit();
}

if ($action == 'LOGOUT') {
    unset($_SESSION['mercury']);
    header('Location: index.html');
    exit();
}

if (!isset($_SESSION['mercury'])) {
    header('HTTP/1.1 500 Internal Server Error');
}

try {
    switch (strtoupper($action)) {
        case 'TESTLOGIN':
            if (!isset($_SESSION['mercury'])) {
                header('HTTP/1.1 500 Internal Server Error');
            }
            exit();
        case 'PING':
            $response = $_SESSION['mercury']->ping();
            break;
        case 'SEND':
            $response = $_SESSION['mercury']->send($_POST);
            break;
        case 'LOOKUP':
            $response = $_SESSION['mercury']->lookup($_POST);
            break;
        case 'GETOPT':
            $response = $_SESSION['mercury']->getopt($_POST);
            break;
        case 'SETOPT':
            $response = $_SESSION['mercury']->setopt($_POST);
            break;
        case 'UNCACHE':
            $response = $_SESSION['mercury']->uncache($_POST);
            break;
        case 'INFO':
            $response = $_SESSION['mercury']->info($_POST);
            break;
        case 'TRANSACTIONS':
            $response = $_SESSION['mercury']->transactions($_POST);
            break;
        default: // unknown action
            printError("Unknown action");
            exit;
    }
    printResponse($response);
} catch (Exception $e) {
    printError($e->getMessage());
}

/**
 * Prints the response into <div class='success'></div>
 * @param response the response
 */
function printResponse(Response &$response) 
{
    echo "<div class='success'><pre>";
    print_r($response->getResults());
    echo "</pre></div";
}

/**
 * Prints an error message into <div class='error'></div>
 * @param error_message the error message
 */
function printError($error_message) 
{
    echo "<div class='error'>Error: $error_message</div>";
}

?>
