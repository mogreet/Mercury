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

/**
* Response is the super class for all the kind of responses that can be obtained from the Moms API requests.
* It contains common methods for the subclasses.
*/
abstract class Response 
{
    /** DOM document object containing the XML response*/
    private $xml_doc;

    /** Response code read in the XML response */
    private $response_code;

    /** Response status */
    private $response_status;

    /** Message */
    private $message;
    
    /** 
    * Construct the Response object by parsing the XML.
    * @param xml_doc the DOM XML document
    * @exception if the response is not valid
    */
    protected function __construct(DOMDocument $xml_doc) 
    {
        $this->xml_doc = $xml_doc;

        $xpath = new DOMXPath($this->xml_doc);
        $this->response_status = $xpath->evaluate('/response/@status')->item(0)->nodeValue;
        $this->response_code = $xpath->evaluate('/response/@code')->item(0)->nodeValue;
        $this->message = $xpath->evaluate('/response/message')->item(0)->nodeValue;

        if (!isset($this->response_code, $this->response_status, $this->message)) {
            throw new Exception('An error occured while getting the response code, status and message.');
        }
        if (!$this->responseIsValid()) {
            throw new Exception("The response is not valid - $this->message (code $this->response_code)");
        }
    }

    /**
    * Magic getters
    * @return the value of the class member
    * @exception if no such class member exists
    */
    public function __get($attr) 
    {
        if(isset($this->$attr)) {
            return $this->$attr;
        } else {
            throw new Exception('Unknown attribute' . $attr);
        }
    }
    
    /**
    * Tests if the response is valid or not
    * @return true if the response is valid, false otherwise
    */
    protected function responseIsValid() 
    {
        return ($this->response_code == 1) ? true : false;
    }

    /**
    * Gets the DOM document as a string
    * @return the DOM document as a string
    */
    public function getXMLString() 
    {
        $output = $this->xml_doc->saveXML();
        if (!$output) {
            throw new Exception('An error occured while getting the XML string.');
        }        
        return htmlentities($output);
    }

    /**
    * Gets all results.
    * @return an associative array containing all results
    */
    public function getResults() 
    {
        return array(
                "Response code" => $this->response_code,
                "Response status" => $this->response_status,
                "Message" => $this->message
                );
    }
}

?>
