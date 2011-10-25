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
* The Getopt object contains the response from a Mercury.getopt request to the Moms API
*/
class Getopt extends Response 
{
    /** Campaigns: array of associative arrays containing the id, the code and the status of a campaign */
    private $campaigns;

    /** 
    * Construct the Getopt object by parsing the XML.
    * @param xml_doc the DOM XML document
    * @exception if the response is not valid
    */
    public function __construct(DOMDocument $xml_doc) 
    {
        parent::__construct($xml_doc);

        $xpath = new DOMXPath($xml_doc);
        $this->campaigns = array();

        $campaigns = $xpath->query('/response/campaign');
        foreach ($campaigns as $campaign) {
            $id = $campaign->getAttribute('id');
            $code = $campaign->getElementsByTagName('status')->item(0)->getAttribute('code');
            $status = $campaign->getElementsByTagName('status')->item(0)->nodeValue;

            if (!isset($id, $code, $status)) {
                throw new Exception("Invalid Getopt reponse");
            }
            $hash = array('id' => $id, 'code' => $code, 'status' => $status);
            array_push($this->campaigns, $hash);
        }
    }

    /**
    * Gets the list of all the campaigns id
    * @return an array containing all campaigns ids
    */
    public function &getCampaignsIdList() 
    {
        $campaigns_ids = array();
        foreach($this->campaigns as $campaign) {
            $id = $campaign['id'];
            if (!in_array($id, $campaigns_ids)) {
                array_push($campaigns_ids, $campaign['id']);
            }
        }
        return $campaigns_ids;
    }

    /**
    * Gets the status code of a campaign.
    * @param campaign_id the campaign's id
    * @exception if there is no matching campaign
    * @return the status code of the campaign
    */
    public function &getCampaignStatusCode($campaign_id) 
    {
        foreach($this->campaigns as $campaign) {
            if ($campaign['id'] == $campaign_id) {
                return $campaign['code'];
            }
        }
        throw new Exception("There is no campaign with id=$campaign_id");
    }
    
    /**
    * Gets the campaign status of a campaign.
    * @param campaign_id the campaign's id
    * @exception if there is no matching campaign
    * @return the status of the campaign
    */
    public function &getCampaignStatus($campaign_id) 
    {
        foreach($this->campaigns as $campaign) {
            if ($campaign['id'] == $campaign_id) {
                return $campaign['status'];
            }
        }
        throw new Exception("There is no campaign with id=$campaign_id");
    }
    
    /**
    * Gets all results from the Getopt request.
    * @return an associative array containing all results
    */
    public function getResults() 
    {
        return array_merge(
                parent::getResults(), 
                array("Campaigns" => $this->campaigns)
                );
    }
}

?>
