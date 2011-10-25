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
* The Info object contains the response from an Mercury.info request to the Moms API 
*/
class Info extends Response 
{
    /** Number */
    private $number;
    /** Carrier id */
    private $carrier_id;
    /** Carrier */
    private $carrier;
    /** Handset id */
    private $handset_id;
    /** Handset */
    private $handset;

    /** 
    * Construct the Info object by parsing the XML.
    * @param xml_doc the DOM XML document
    * @exception if the response is not valid
    */
    public function __construct(DOMDocument $xml_doc) 
    {
        parent::__construct($xml_doc);

        $xpath = new DOMXPath($xml_doc);
        $this->number = $xpath->evaluate('/response/number')->item(0)->nodeValue;
        $this->carrier_id = $xpath->evaluate('/response/carrier/@id')->item(0)->nodeValue;
        $this->carrier = $xpath->evaluate('/response/carrier')->item(0)->nodeValue;
        $this->handset_id = $xpath->evaluate('/response/handset/@id')->item(0)->nodeValue;
        $this->handset = $xpath->evaluate('/response/handset')->item(0)->nodeValue;

        if (!isset($this->number, $this->carrier_id, $this->carrier, $this->handset_id, $this->handset)) {
            throw new Exception("Invalid Info response.");
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
    * Gets all results from the Info request.
    * @return an associative array containing all results
    */
    public function getResults() 
    {
        return array_merge(
                parent::getResults(),
                array(
                    "Number" => $this->number,
                    "Carrier id" => $this->carrier_id,
                    "Carrier" => $this->carrier,
                    "Handset id" => $this->handset_id,
                    "Handset" => $this->handset,
                    )
                );
    }
}

?>
