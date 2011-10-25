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

include_once(dirname(__FILE__) . '/../Response.class.php');

/**
* The Send object contains the response from a {@link Mercury#send} request to the Moms API.
*/
class Send extends Response 
{
    /** Message id */
    private $message_id;
    /** Hash */
    private $hash;

    /** 
    * Construct the Send object by parsing the XML.
    * @param xml_doc the DOM XML document
    * @exception if the response is not valid
    */
    public function __construct(DOMDocument $xml_doc) 
    {
        parent::__construct($xml_doc);

        $xpath = new DOMXPath($xml_doc);
        $this->message_id = $xpath->evaluate('/response/message_id')->item(0)->nodeValue;
        $this->hash = $xpath->evaluate('/response/hash')->item(0)->nodeValue;

        if (!isset($this->message_id, $this->hash)) {
            throw new Exception('An error occured while parsing the XML data for the SEND call');
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
    * Gets all results from the Lookup request.
    * @return an associative array containing all results
    */
    public function getResults() 
    {
        return array_merge(
                parent::getResults(),
                array(
                    "Message id" => $this->message_id,
                    "Hash" => $this->hash
                    )
                );
    }
}
