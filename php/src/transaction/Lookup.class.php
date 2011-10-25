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
* is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Mercury.  If not, see <http://www.gnu.org/licenses/>.
*/

include_once(dirname(__FILE__) . '/../Response.class.php');

/**
* The Lookup object contains the response from a Mercury.lookup request to the Moms API. 
*/
class Lookup extends Response
{
    /** Campaign id */
    private $campaign_id;
    /** From number */
    private $from_number;
    /** From name */
    private $from_name;
    /** To number */
    private $to_number;
    /** To name */
    private $to_name;
    /** Content id */
    private $content_id;
    /** Status */
    private $status;
    /** History: associative array timestamp => array of events names */
    private $history;

    /** 
    * Construct the Info object by parsing the XML.
    * @param xml_doc the DOM XML document
    * @exception if the response is not valid
    */
    public function __construct(DOMDocument $xml_doc) 
    {
        parent::__construct($xml_doc);

        $xpath = new DOMXPath($xml_doc);

        $this->campaign_id = $xpath->evaluate('/response/campaign_id')->item(0)->nodeValue;
        $this->from_number = $xpath->evaluate('/response/from')->item(0)->nodeValue;
        $this->from_name = $xpath->evaluate('/response/from_name')->item(0)->nodeValue;
        $this->to_number = $xpath->evaluate('/response/to')->item(0)->nodeValue;
        $this->to_name = $xpath->evaluate('/response/to_name')->item(0)->nodeValue;
        $this->content_id = $xpath->evaluate('/response/content_id')->item(0)->nodeValue;
        $this->status = $xpath->evaluate('/response/status')->item(0)->nodeValue;

        $events = $xpath->query('/response/history/event');
        $this->history = array();

        foreach ($events as $event) {
            $timestamp = $event->getAttribute('timestamp');
            if (array_key_exists($timestamp, $this->history)) {
                array_push($this->history[$timestamp], $event->nodeValue);
            } else {
                $this->history[$timestamp] = array($event->nodeValue);
            }
        }

        if (!isset($this->campaign_id, $this->from_number, $this->from_name, $this->to_number, $this->to_name, 
                    $this->content_id, $this->content_id, $this->status, $this->status, $this->history)) {
            throw new Exception("Invalid Lookup response.");
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
    * @return The list of all the timestamps events of the requested transaction. 
    */
    public function &getTimestampsList() 
    {
        return array_keys($this->history);
    }

    /**
    * @return The list of all the events of the requested transaction. 
    */
    public function &getEventsList() 
    {
        $result = array();
        foreach ($this->history as $events) {
            foreach($events as $event) {
                array_push($result, $event);
            }
        }
        return $result;
    }

    /**
    * @return The list of the events that occured at the specified timestamp of the requested transaction. 
    * @exception if the specified timestamp does not exist.
    */
    public function &getEvents($timestamp) {
        $results = array();
        foreach ($this->history as $ts => $events) {
            if ($ts == $timestamp) {
                foreach($events as $event) {
                    array_push($results, $event);
                }
            }
        }
        return $result;
    }

    /**
    * Gets all results from the Lookup request.
    * @return an associative array containing all results
    */
    public function getResults() {
        return array_merge(
                parent::getResults(),
                array(
                    "Campaign id" => $this->campaign_id,
                    "From number" => $this->from_number,
                    "From name" => $this->from_name,
                    "To number" => $this->to_number,
                    "To name" => $this->to_name,
                    "Content id" => $this->content_id,
                    "Status" => $this->status,
                    "History" => $this->history
                    )
                );
    }
}

?>
