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

include_once(dirname(__FILE__) . '/Response.class.php');
include_once(dirname(__FILE__) . '/system/Ping.class.php');
include_once(dirname(__FILE__) . '/transaction/Lookup.class.php');
include_once(dirname(__FILE__) . '/transaction/Send.class.php');
include_once(dirname(__FILE__) . '/user/Getopt.class.php');
include_once(dirname(__FILE__) . '/user/Info.class.php');
include_once(dirname(__FILE__) . '/user/Setopt.class.php');
include_once(dirname(__FILE__) . '/user/Transactions.class.php');
include_once(dirname(__FILE__) . '/user/Uncache.class.php');

/**
* Handler for XML parser.
* Disables warning and throw an exception instead
*/
function HandleXmlError($errno, $errstr, $errfile, $errline)
{
    if ($errno==E_WARNING && (substr_count($errstr,"DOMDocument::loadXML()")>0)) {
        throw new DOMException($errstr);
    } else {
        return false;
    }
}


/**
* A Mercury object allows to execute three types of requests (system, user and transaction) to the Moms API. 
*/
class Mercury 
{
    /** Request url for PING */
    const PING_URL = 'https://api.mogreet.com/moms/system.ping';
    /** Request url for SEND */
    const SEND_URL = 'https://api.mogreet.com/moms/transaction.send';
    /** Request url for LOOKUP */
    const LOOKUP_URL = 'https://api.mogreet.com/moms/transaction.lookup';
    /** Request url for GETOPT */
    const GETOPT_URL = 'https://api.mogreet.com/moms/user.getopt';
    /** Request url for SETOPT */
    const SETOPT_URL = 'https://api.mogreet.com/moms/user.setopt';
    /** Request url for UNCACHE */
    const UNCACHE_URL = 'https://api.mogreet.com/moms/user.uncache';
    /** Request url for INFO */
    const INFO_URL = 'https://api.mogreet.com/moms/user.info';
    /** Request url for TRANSACTIONS */
    const TRANSACTIONS_URL = 'https://api.mogreet.com/moms/user.transactions';

    /** Client id */
    private $client_id;
    /** Token */
    private $token;

    /**
    * Constructor
    * @param client_id the client's id
    * @param token the client's token
    */
    public function __construct($client_id, $token)
    {
        $this->client_id = $client_id;
        $this->token = $token;
    }

    /**
    * Processes a request
    * @param url the url of the request
    * @param params the array containing all the parameters of the request
    * @exception if a problem occurs while executing the request
    */
    private function processRequest($url, array &$params, $req_name) 
    {
        if (!($ch = curl_init())) {
            throw new Exception("A problem occured during the $req_name request");
        }
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        // setting parameters
        $params['client_id'] = $this->client_id;
        $params['token'] = $this->token;
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($params));

        if (!($data = curl_exec($ch))) {
            throw new Exception("A problem occured during the $req_name request");
        }
        curl_close($ch);

        $xml_doc = new DOMDocument();
        set_error_handler('HandleXmlError');
        $xml_doc->loadXml($data);    
        restore_error_handler();

        return $xml_doc;
    }

    /**
    * Checks if all the required parameters have been set
    * @param params array of all required parameters names
    * @param hash associative array containing actual parameters
    * @return true if all the required parameters have been set, false otherwise
    */
    private function checkInputParams(array &$params, array &$hash) 
    {
        $values = array_keys($hash);
        foreach ($params as $param) {
            if (!in_array($param, $values)) {
                return false;
            }
        }
        return true;
    }

    /**
    * Tests connectivity to the Moms API servers.
    * <pre>
    * <b>Code Sample: </b>
    * $ping = $myMercury->ping();
    * </pre>
    * @return the Ping response object
    * @exception if a required parameter is missing
    */
    public function ping() 
    {
        $params = array();
        $xml_doc = $this->processRequest(self::PING_URL, &$params, 'PING');
        return new Ping($xml_doc);
    }

    /**
    * Initiates a transaction and delivery of an SMS or MMS.
    * <pre>
    * <b>Code Sample: </b>
    * $params = array();
    * $params['campaign_id'] = 'xxx';
    * $params['to'] = 'xxx';
    * $params['from'] = 'xxx';
    * $params['message'] = 'xxx';
    * $params['content_id'] = 'xxx';
    * $send = $myMercury->send(params);
    * </pre>
    * @param hash An associative array that must contain the following keys with their corresponding value:
    * <ul>
    *	<li> "campaign_id" &rarr; "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
    *	<li> "to" &rarr; "...": <i>A 10-digit mobile phone number.</i>
    * 	<li> "from" &rarr; "...": <i>A 10-digit mobile phone number.</i>
    * 	<li> "message" &rarr; "...": <i>Depending on your campaign set up, the message presented to the "to" user.</i>
    * 	<li> "content_id" &rarr; "...": <i>An ID associated to the content being sent (optional - depending on your campaign set up, this parameter may be required).</i>
    *	<li> OR "content_url" &rarr; "...": <i>underdevelopment - for users who host their own content</i>
    * </ul>
    * The HashMap can also contain the following optionnal key-value pairs: 
    * <ul>
    *	<li> "to_name" &rarr; "...": <i>A name associated to the "to" mobile number (if not included will be set to "to" mobile number).</i>
    * 	<li> "from_name" &rarr; "...": <i>A name associated to the "from" mobile number (if not included will be set to "from" mobile number).</i>
    * 	<li> "udp_*" &rarr; "...": <i>User Defined Parameter. Clients can pass in any number of udp_* parameters for message flow customization.</i>
    * </ul>
    * @return A Send response object
    * @exception if a required parameter is missing
    */  
    public function send(array &$hash) 
    {
        $params = array('campaign_id', 'to', 'message');

        if (!$this->checkInputParams(&$params, &$hash)) {
            throw new Exception('missing parameter(s)');
        }

        $xml_doc = $this->processRequest(self::SEND_URL, $hash, 'SEND');
        return new Send($xml_doc);
    }

    /**
    * Returns the info, status and history of the requested transaction.
    * <pre>
    * <b>Code sample:</b>
    * $params = array();
    * $params['message_id'];
    * $params['hash'] = 'xxx';
    * $params['message_id'] = 'xxx';
    * $lookup = $myMercury->lookup(params);
    * </pre>
    * @param hash an associative array that must contains the following keys with their corresponding value:
    * <ul>
    *	<li> "message_id" &rarr; "...": <i>An ID returned from a {@link #send} or from {@link #transactions} method.</i>
    *	<li> "hash" &rarr; "...": <i>A hash returned from a {@link #send} or from a {@link #transactions} method.</i>
    * </ul>
    * @return a Lookup response object
    * @exception if a required parameter is missing
    */
    public function lookup(array $hash) 
    {
        $params = array('message_id', 'hash');
        if (!$this->checkInputParams(&$params, &$hash)) {
            throw new Exception('missing parameter(s)');
        }

        $xml_doc = $this->processRequest(self::LOOKUP_URL, $hash, 'LOOKUP');
        return new Lookup($xml_doc);
    }

    /**
    * Returns the opt in status of any mobile number.
    * <pre>
    * <b>Code sample:</b>
    * $getopt = $myMercury->getopt(array( 'number' => 'xxx'));
    * </pre>
    * @param hash A HashMap object that must contains the following keys with their corresponding value:
    * <ul>
    *	<li> "number" &rarr; "...": <i>A 10-digit mobile phone number.</i>
    * </ul>
    * The HashMap can also contain the following optionnal key-value pairs:
    * <ul>
    *	<li> "campaign_id" &rarr; "...": <i>A campaign id to search on, if excluded, returns all opt in statuses for the client's campaigns.</i>
    * </ul>
    * @return A Getopt response object
    * @exception if a required parameter is missing    
    */
    public function getopt(array $hash) 
    {
        $params = array('number');
        if (!$this->checkInputParams(&$params, &$hash)) {
            throw new Exception('missing parameter(s)');
        }

        $xml_doc = $this->processRequest(self::GETOPT_URL, $hash, 'GETOPT');
        return new Getopt($xml_doc);
    }

    /**
    * Sets the opt in status of any mobile number.
    * <pre>
    * <b>Code sample:</b> 
    * $setopt = $myMercury->setopt(array( 'number' => 'xxx', 'campaign_id' => 'xxx', 'status_code' => 'xxx'));
    * </pre>
    * @param hash A HashMap object that must contains the following keys with their corresponding value:
    * <ul>
    *	<li> "number" &rarr; "...": <i>A 10-digit mobile phone number.</i>
    *	<li> "campaign_id" &rarr; "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
    *	<li> "status_code" &rarr; "...": <i>See the bellow table for available codes to use here.</i>
    * </ul>
    * <table border="1">
    * 	<tr>
    * 		<td>Status</td>
    * 		<td>Status code</td>
    *		<td>Description</td>
    * 	</tr>
    * 	<tr>
    * 		<td>OPTEDIN</td>
    * 		<td>1</td>
    *		<td>User is opted into the campaign</td>
    * 	</tr>
    * 	<tr>
    * 		<td>OPTEDOUT</td>
    * 		<td>-2</td>
    *		<td>User is opted out of the campaign</td>
    * 	</tr>
    * </table>
    * <br />
    * @return A Setopt response object
    * @exception if a required parameter is missing    
    */
    public function setopt(array $hash) 
    {
        $params = array('number', 'campaign_id', 'status_code');
        if (!$this->checkInputParams(&$params, &$hash)) {
            throw new Exception('missing parameter(s)');
        }

        $xml_doc = $this->processRequest(self::SETOPT_URL, $hash, 'SETOPT');
        return new Setopt($xml_doc);
    }

    /**
    * Clears the user carrier and handset info from the Mogreet cache.
    * <pre>
    * <b>Code sample:</b> 
    * $uncache = $myMercury->uncache(array( 'number' => 'xxx' ));
    * </pre>
    * @param hash A HashMap object that must contains the following key with its corresponding value:
    * <ul>
    *	<li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
    * </ul>
    * @return A Uncache response object
    * @exception if a required parameter is missing
    */
    public function uncache(array $hash) 
    {
        $params = array('number');
        if (!$this->checkInputParams(&$params, &$hash)) {
            throw new Exception('missing parameter(s)');
        }

        $xml_doc = $this->processRequest(self::UNCACHE_URL, $hash, 'UNCACHE');
        return new Uncache($xml_doc);
    }

    /**
    * Returns the user carrier and handset info if available.
    * <pre>
    * <b>Code sample:</b> 
    * $info = $myMercury->info(array( 'number' => 'xxx' ));
    * </pre>
    * @param hash A HashMap object that must contains the following key with its corresponding value:
    * <ul>
    *	<li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
    * </ul>
    * @return A new Info response object
    * @exception if a required parameter is missing
    */
    public function info(array $hash) 
    {
        $params = array('number');
        if (!$this->checkInputParams(&$params, &$hash)) {
            throw new Exception('missing parameter(s)');
        }

        $xml_doc = $this->processRequest(self::INFO_URL, $hash, 'INFO');
        return new Info($xml_doc);
    }

    /**
    * Returns the user's transactions (open and closed).
    * <pre>
    * <b>Code sample:</b> 
    * $transactions = $myMercury->transactions(array( 'number' => 'xxx' ));
    * </pre>
    * @param hash A HashMap object that must contains the following key with its corresponding value:
    * <ul>
    *	<li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
    * </ul>
    * The HashMap can also contain the following optionnal key-value pairs:
    * <ul>
    *	<li> "campaign_id" &rarr; "...": <i>A campaign id to search on, if excluded, returns all transactions for the client's campaigns.</i>
    *	<li> "start_date" &rarr; "...": <i>Narrow search by adding a date to start searching on (YYYY-MM-DD).</i>
    *	<li> "end_date" &rarr; "...": <i>Narrow search by adding a date to stop searching on (YYYY-MM-DD).</i>
    * </ul>
    * @return A Transactions response object
    * @exception if a required parameter is missing
    */
    public function transactions(array $hash) 
    {
        $params = array('number');
        if (!$this->checkInputParams(&$params, &$hash)) {
            throw new Exception('missing parameter(s)');
        }
        $xml_doc = $this->processRequest(self::TRANSACTIONS_URL, $hash, 'TRANSACTIONS');
        return new Transactions($xml_doc);
    }
}
?>
