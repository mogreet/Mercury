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
import java.lang.Math.*;

/**
* The Getopt object contains the response from a {@link Mercury#getopt} request to the Moms API.
*/
public class Getopt extends Response {
	
	private HashMap<Integer, HashMap<String, String>> campaigns;
	
	/**
	* Creates a new Getopt response object.
	* @param xmlDoc XML DOM document that is returned by all the requests.
	*/
	public Getopt(Document xmlDoc) {
		super(xmlDoc);
		if (!super.responseIsValid())
			throw new RuntimeException(super.getMessage());
		try {
			XPath xpath = XPathFactory.newInstance().newXPath();
			XPathExpression expr = xpath.compile("/response/campaign/@id | /response/campaign/status/@code | /response/campaign/status/text()");
			
			NodeList nodes = (NodeList)expr.evaluate(xmlDoc, XPathConstants.NODESET);
			this.campaigns = new HashMap<Integer, HashMap<String, String>>();
			int campaignId = 0;
			for (int i = 0; i < nodes.getLength(); ++i) {
				if (nodes.item(i).getNodeName().equals("id")) {
					campaignId = Integer.parseInt(nodes.item(i).getNodeValue());
					this.campaigns.put(campaignId, new HashMap<String, String>());
				}	
				else {
					HashMap<String, String> status = this.campaigns.get(campaignId);
					if (nodes.item(i).getNodeName().equals("code"))
						status.put("code", nodes.item(i).getNodeValue());
					else 
						status.put("status", nodes.item(i).getNodeValue());
				}
			}
		} catch (XPathExpressionException e) {
			throw new RuntimeException("\nAn error occured while parsing the XML data for the GETOPT call: " + e.getMessage());
		}
	}
	
	/**
	* @return The list of all the campaigns id.
	*/
	public ArrayList<Integer> getCampaignsIdList() {
		ArrayList<Integer> campaignsIdList = new ArrayList<Integer>(); 
		campaignsIdList.addAll(this.campaigns.keySet());
		return campaignsIdList;
	}
	
	/**
	* @param campaignId campaign ID
	* @return The status code of the specified campaign.
	* 0 if the specified campaign ID does not exist.
	*/
	public int getCampaignStatusCode(int campaignId) {
		HashMap<String, String> campaign = this.campaigns.get(campaignId);
		if (campaign != null)
			return Integer.parseInt(campaign.get("code"));
		return 0;
	}
	
	/**
	* @param campaignId campaign ID
	* @return The status label of the specified campaign.
	* Null if the specified campaign ID does not exist.
	*/
	public String getCampaignStatus(int campaignId) {
		HashMap<String, String> campaign = this.campaigns.get(campaignId);
		if (campaign != null)
			return campaign.get("status");
		return null;
	}
}