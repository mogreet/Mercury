/**
* Copyright 2011 Nicolas Payot
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

package com.mogreet.mercury.user;

import com.mogreet.mercury.*;
import java.util.*;
import org.w3c.dom.*;
import javax.xml.xpath.*;

/**
* The Transactions object contains the response from a {@link Mercury#transactions} request to the Moms API.
*/
public class Transactions extends Response {

	private HashMap<String, HashMap<Integer, HashMap<String, String>>> campaigns;

	/**
	* Creates a new Transactions response object.
	* @param xmlDoc XML DOM document that is returned by all the requests.
	*/
	public Transactions(Document xmlDoc) {
		super(xmlDoc);
		if (!super.responseIsValid())
			throw new RuntimeException(super.getMessage());
		try {
			XPath xpath = XPathFactory.newInstance().newXPath();
			XPathExpression expr;
			String tmp = "/response/campaign/@id | /response/campaign/@name | ";
			tmp += "/response/campaign/transaction/@datestamp | /response/campaign/transaction/@hash | /response/campaign/transaction/@message_id | ";
			tmp += "/response/campaign/transaction/to | /response/campaign/transaction/from";
			expr = xpath.compile(tmp);
			NodeList nodes = (NodeList)(expr.evaluate(xmlDoc, XPathConstants.NODESET));
			
			campaigns = new HashMap<String, HashMap<Integer, HashMap<String, String>>>();
			String campaignsIdName = null;
			String datestamp = null;
			String hash = null;
			HashMap<String, String> transactionsInfo = null;
			
			for (int i = 0; i < nodes.getLength(); ++i) {
				if (nodes.item(i).getNodeName().equals("id")) {
					campaignsIdName = nodes.item(i).getNodeValue();
				} else if (nodes.item(i).getNodeName().equals("name")) {
					campaignsIdName += " " + nodes.item(i).getNodeValue();
					if (campaigns.get(campaignsIdName) == null)
						campaigns.put(campaignsIdName, new HashMap<Integer, HashMap<String, String>>());
				} else if (nodes.item(i).getNodeName().equals("datestamp")) {
					datestamp = nodes.item(i).getNodeValue();
				} else if (nodes.item(i).getNodeName().equals("hash")) {
					hash = nodes.item(i).getNodeValue();
				} else if (nodes.item(i).getNodeName().equals("message_id")) {
					HashMap<Integer, HashMap<String, String>> transactions = campaigns.get(campaignsIdName);
					transactions.put(Integer.parseInt(nodes.item(i).getNodeValue()), new HashMap<String, String>());
					transactionsInfo = transactions.get(Integer.parseInt(nodes.item(i).getNodeValue()));
					transactionsInfo.put("datestamp", datestamp);
					transactionsInfo.put("hash", hash);
				} else if (nodes.item(i).getNodeName().equals("to")) {
					transactionsInfo.put("to_number", ((Attr)nodes.item(i).getAttributes().item(0)).getValue());
					transactionsInfo.put("to_name", nodes.item(i).getFirstChild().getNodeValue());
				} else if (nodes.item(i).getNodeName().equals("from")) {
					transactionsInfo.put("from_number", ((Attr)nodes.item(i).getAttributes().item(0)).getValue());
					transactionsInfo.put("from_name", nodes.item(i).getFirstChild().getNodeValue());
				}
			}
		} catch (XPathExpressionException e) {
			throw new RuntimeException("\nAn error occured while parsing the XML data for the TRANSACTIONS call: " + e.getMessage());
		}
	}
	
	/**
	* @return The list of all the campaigns ID.
	*/
	public ArrayList<Integer> getCampaignsIdList() {
		ArrayList<Integer> campaignsIdList = new ArrayList<Integer>(); 
		for (Map.Entry<String, HashMap<Integer, HashMap<String, String>>> entry : this.campaigns.entrySet())
			if (!campaignsIdList.contains(Integer.parseInt(entry.getKey().split(" ")[0])))
				campaignsIdList.add(Integer.parseInt(entry.getKey().split(" ")[0]));
		return campaignsIdList;
	}
	
	/**
	* @return The list of the names for the specified campaign ID (a campaign can have more than one name).
	*/
	public ArrayList<String> getCampaignNames(int campaignId) {
		ArrayList<String> campaignsName = new ArrayList<String>();
		for (Map.Entry<String, HashMap<Integer, HashMap<String, String>>> entry : this.campaigns.entrySet())
			if (Integer.parseInt(entry.getKey().split(" ")[0]) == campaignId)
				campaignsName.add(entry.getKey().split(" ")[1]);
		return campaignsName;
	}
	
	/**
	* @return The list of all the transactions ID.
	*/
	public ArrayList<Integer> getTransactionsIdList() {
		ArrayList<Integer> transactionsIdList = new ArrayList<Integer>();
		for (Map.Entry<String, HashMap<Integer, HashMap<String, String>>> entry : this.campaigns.entrySet())
			transactionsIdList.addAll(entry.getValue().keySet());
		return transactionsIdList;
	}
	
	/**
	* @return The list of the transactions ID for the specified campaign ID.
	*/
	public ArrayList<Integer> getTransactionsIdListFrom(int campaignId) {
		ArrayList<Integer> transactionsIdList = new ArrayList<Integer>();
		for (Map.Entry<String, HashMap<Integer, HashMap<String, String>>> entry : this.campaigns.entrySet())
			if (Integer.parseInt(entry.getKey().split(" ")[0]) == campaignId)
				transactionsIdList.addAll(entry.getValue().keySet());
		return transactionsIdList;
	}
	
	/**
	* @return The value for the specified key.
	*/
	private String getValue(int campaignId, int transactionId, String key) {
		for (Map.Entry<String, HashMap<Integer, HashMap<String, String>>> entry : this.campaigns.entrySet())
			if (Integer.parseInt(entry.getKey().split(" ")[0]) == campaignId)
				if (entry.getValue().get(transactionId) != null)
					return entry.getValue().get(transactionId).get(key);
		return null;
	}
	
	/**
	* @return The hash corresponding to the specified campaign ID and transaction ID.
	* Null if the campaign ID or the transaction ID does not exist.
	*/
	public String getHash(int campaignId, int transactionId) {
		return getValue(campaignId, transactionId, "hash");
	}
	
	/**
	* @return The datestamp corresponding to the specified campaign ID and transaction ID. 
	* Null if the campaign ID or the transaction ID does not exist.
	*/
	public String getDatestamp(int campaignId, int transactionId) {
		return getValue(campaignId, transactionId, "datestamp");
	}
	
	/**
	* @return The sender's number corresponding to the specified campaign ID and transaction ID.
	* Null if the campaign ID or the transaction ID does not exist.
	*/
	public String getFromNumber(int campaignId, int transactionId) {
		return getValue(campaignId, transactionId, "from_number");
	}
	
	/**
	* @return The sender's name corresponding to the specified campaign ID and transaction ID.
	* Null if the campaign ID or the transaction ID does not exist.
	*/
	public String getFromName(int campaignId, int transactionId) {
		return getValue(campaignId, transactionId, "from_name");
	}
	
	/**
	* @return The receiver's number corresponding to the specified campaign ID and transaction ID.
	* Null if the campaign ID or the transaction ID does not exist.
	*/
	public String getToNumber(int campaignId, int transactionId) {
		return getValue(campaignId, transactionId, "to_number");
	}
	
	/**
	* @return The receiver's name corresponding to the specified campaign ID and transaction ID.
	* Null if the campaign ID or the transaction ID does not exist.
	*/
	public String getToName(int campaignId, int transactionId) {
		return getValue(campaignId, transactionId, "to_name");
	}
}