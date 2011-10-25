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
            $transactions = $xpath->query('./transaction', $campaign);

            $arrTrans = array();
            foreach($transactions as $transaction) {
                $transaction_infos = array();
                $transaction_infos['datestamp'] = $xpath->evaluate('./@datestamp', $transaction)->item(0)->nodeValue;
                $transaction_infos['hash'] = $xpath->evaluate('./@hash', $transaction)->item(0)->nodeValue;
                $transaction_infos['to'] = $xpath->evaluate('./to', $transaction)->item(0)->nodeValue;
                $transaction_infos['to_number'] = $xpath->evaluate('./to/@number', $transaction)->item(0)->nodeValue;
                $transaction_infos['from_number'] = $xpath->evaluate('./from/@number', $transaction)->item(0)->nodeValue;
                $transaction_infos['from_name'] = $xpath->evaluate('./from', $transaction)->item(0)->nodeValue;
                
                foreach($transaction_infos as $info) {
                    if (!isset($info)) {
                        throw new Exception("An error occured while parsing the XML data for the TRANSACTIONS call");
                    }
                }
                $message_id = $xpath->evaluate('./@message_id', $transaction)->item(0)->nodeValue;
                if (!isset($message_id)) {
                    throw new Exception("An error occured while parsing the XML data for the TRANSACTIONS call");
                }
                if (array_key_exists($message_id, $arrTrans)) {
                    array_push($arrTrans[$message_id], $transaction_infos);
                } else {
                    $arrTrans[$message_id] = array($transaction_infos);
                }
            }

            $campaignsIdName = $campaign->getAttribute('id') . ' ' . $campaign->getAttribute('name');
            if (!isset($campaignsIdName)) {
                throw new Exception("An error occured while parsing the XML data for the TRANSACTIONS call");
            }
            if (array_key_exists($campaignsIdName, $this->campaigns)) {
                array_push($this->campaigns[$campaignsIdName], $arrTrans);
            } else {
                $this->campaigns[$campaignsIdName] = array($arrTrans);
            }
        }
    }

    /**
    * @return The list of all the campaigns ID.
    */
    public function &getCampaignsIdList() 
    {
        $campaigns_ids = array();
        foreach($this->campaigns as $campaign => $value) {
            $array = split(" ", $campaign);
            $id = $array[0];
            if (!in_array($id, $campaigns_ids)) {
                array_push($campaigns_ids, $id);
            }
        }
        return $campaigns_id_list;
    }

    /**
    * @return The list of all the campaigns names.
    */
    public function &getCampaignsNames() 
    {
        $campaigns_names = array($campaign_id);
        foreach($this->campaigns as $campaign => $value) {
            $array = split(" ", $campaign);
            $id = $array[0];
            if ($id == $campaign_id) {
                array_push($campaigns_names, $id);
            }
        }
        return $campaigns_names;
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
