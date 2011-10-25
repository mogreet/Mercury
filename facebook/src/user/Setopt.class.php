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
* The Setopt object contains the response from a {@link Mercury#setopt} request to the Moms API.
*/
class Setopt extends Response 
{
    /** Campaign id*/
    private $campaign_id;
    /** Campaign status code */
    private $campaign_status_code;
    /** Campaign status */
    private $campaign_status;
    /** Number */
    private $number;

    /** 
    * Construct the Setopt object by parsing the XML.
    * @param xml_doc the DOM XML document
    * @exception if the response is not valid
    */
    public function __construct(DOMDocument $xml_doc) 
    {
        parent::__construct($xml_doc);

        $xpath = new DOMXPath($xml_doc);
        $this->campaign_id = $xpath->evaluate('/response/campaign/@id')->item(0)->nodeValue;
        $this->campaign_status_code = $xpath->evaluate('/response/campaign/status/@code')->item(0)->nodeValue;
        $this->campaign_status = $xpath->evaluate('/response/campaign/status')->item(0)->nodeValue;
        $this->number = $xpath->evaluate('/response/number')->item(0)->nodeValue;

        if (!isset($this->campaign_id, $this->campaign_status_code, $this->campaign_status, $this->number)) {
            throw new Exception('An error occured while parsing the XML data for the SETOPT call.');
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
    * Gets all results from the Setopt request.
    * @return an associative array containing all results
    */
    public function getResults() 
    {
        return array_merge(
                parent::getResults(),
                array(
                    "Campaign id" => $this->campaign_id,
                    "Campaign status code" => $this->campaign_status_code,
                    "Campaign status" => $this->campaign_status,
                    "Number" => $this->number
                    )
                );
    }
}

?>
