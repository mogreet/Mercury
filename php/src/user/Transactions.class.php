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
* The Transactions object contains the response from a {@link Mercury#transactions} request to the Moms API.
*/
class Transactions extends Response 
{
    private $campaigns;

    /** 
    * Construct the Transactions object by parsing the XML.
    * @param xml_doc the DOM XML document
    * @exception if the response is not valid
    */
    public function __construct(DOMDocument $xml_doc) 
    {
        parent::__construct($xml_doc);
        $xpath = new DOMXPath($xml_doc);

        $this->campaigns = array();
        $campaigns = $xpath->query('/response/campaign');
        foreach($campaigns as $campaign) {
            $campaign_id = $campaign->getAttribute('id');
            if (!isset($campaign_id)) {
                throw new Exception("An error occured while parsing the XML data for the TRANSACTIONS call");
            }
            if (in_array($campaign_id, $this->campaigns)) {
                exit;
            }

            $transactions = $xpath->query('./transaction', $campaign);
            $this->campaigns[$campaign_id]["name"] = $campaign->getAttribute('name');

            foreach($transactions as $transaction) {
                $message_id = $xpath->evaluate('./@message_id', $transaction)->item(0)->nodeValue;
                if (!isset($message_id)) {
                    throw new Exception("An error occured while parsing the XML data for the TRANSACTIONS call");
                }

                $this->campaigns[$campaign_id]["transactions"][$message_id]["hash"] = $xpath->evaluate('./@hash', $transaction)->item(0)->nodeValue;
                $this->campaigns[$campaign_id]["transactions"][$message_id]["datestamp"] = $xpath->evaluate('./@datestamp', $transaction)->item(0)->nodeValue;
                $this->campaigns[$campaign_id]["transactions"][$message_id]["to"] = $xpath->evaluate('./to', $transaction)->item(0)->nodeValue;
                $this->campaigns[$campaign_id]["transactions"][$message_id]["to_number"] = $xpath->evaluate('./to/@number', $transaction)->item(0)->nodeValue;
                $this->campaigns[$campaign_id]["transactions"][$message_id]["from"] = $xpath->evaluate('./from', $transaction)->item(0)->nodeValue;
                $this->campaigns[$campaign_id]["transactions"][$message_id]["from_number"] = $xpath->evaluate('./from/@number', $transaction)->item(0)->nodeValue;

                foreach($this->campaigns[$campaign_id]["transactions"][$message_id] as $info) {
                    if (!isset($info)) {
                        throw new Exception("An error occured while parsing the XML data for the TRANSACTIONS call");
                    }
                }
            }
        }
    }

    /**
    * @return The list of all the campaigns ID.
    */
    public function &getCampaignsIdList() 
    {
        return array_keys($this->campaigns);
    }

    /**
    * @return The list of all the campaigns names.
    */
    public function &getCampaignsNames() 
    {
        $campaigns_names = array();
        foreach ($this->campaigns as $campaign_id => $campaign) {
            array_push($campaigns_names, $campaign["name"]);
        }
        return $campaigns_names;
    }

    /**
    * @return the name of the specified campaign
    * @exception if the specified campaign has not been found
    */
    public function &getCampaignName($campaign_id) 
    {
        if (!isset($this->campaigns[$campaign_id]["name"])) {
            throw new Exception("The name of the campaign no $campaign_id has not been found");
        }
        return $this->campaigns[$campaign_id]["name"];
    }
    
    /**
    * @return The list of all the transactions IDs
    */
    public function &getTransactionsIds() 
    {
        $transactions_ids = array();
        foreach ($this->campaigns as $campaign) {
            foreach ($campaign["transactions"] as $transaction_id => $transaction_infos) {
                array_push($transactions_ids, $transaction_id);
            }
        }
        return $transactions_ids;
    }

    /**
    * @return The list of all the transactions IDs for the specified campaign
    * @exception if the specified campaign has not been found
    */
    public function &getTransactionsIdsFrom($campaign_id) {
        return array_keys($this->campaigns[$campaign_id]["transactions"]);
    }

    /**
    * @return The value of the specified key for the specified transaction of the specified campaign
    * @exception if the specified key has not been found
    */
    private function getValue($campaign_id, $transaction_id, $key) {
        if (!isset($this->campaigns[$campaign_id]["transactions"][$transaction_id][$key])) {
           throw new Exception("The $key of the transaction $transaction_id of the campaign $campaign_id");
        }
        return $this->campaigns[$campaign_id]["transactions"][$transaction_id][$key];
    }

    /**
    * @return The hash corresponding to the specified campaign ID and transaction ID.
    * @exception if the specified hash has not been found
    */
    public function getHash($campaign_id, $transaction_id) {
        return $this->getValue($campaign_id, $transaction_id, "hash");    
    }

    /**
    * @return The datestamp corresponding to the specified campaign ID and transaction ID.
    * @exception if the specified datestamp has not been found
    */
    public function getDatestamp($campaign_id, $transaction_id) {
        return $this->getValue($campaign_id, $transaction_id, "datestamp");    
    }

    /**
    * @return The receiver's name corresponding to the specified campaign ID and transaction ID.
    * @exception if the specified receiver's name has not been found
    */
    public function getTo($campaign_id, $transaction_id) {
        return $this->getValue($campaign_id, $transaction_id, "to");    
    }

    /**
    * @return The receiver's number corresponding to the specified campaign ID and transaction ID.
    * @exception if the specified receiver's number has not been found
    */
    public function getToNumber($campaign_id, $transaction_id) {
        return $this->getValue($campaign_id, $transaction_id, "to_number");    
    }

    /**
    * @return The sender's name corresponding to the specified campaign ID and transaction ID.
    * @exception if the specified sender's name has not been found
    */
    public function getFrom($campaign_id, $transaction_id) {
        return $this->getValue($campaign_id, $transaction_id, "from");    
    }

    /**
    * @return The sender's number corresponding to the specified campaign ID and transaction ID.
    * @exception if the specified sender's number has not been found
    */
    public function getFromNumber($campaign_id, $transaction_id) {
        return $this->getValue($campaign_id, $transaction_id, "from_number");    
    }

    /**
    * Gets all results from the Transactions request.
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
