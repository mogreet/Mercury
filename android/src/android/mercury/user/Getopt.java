/**
* Copyright 2011 Julien Salvi for Mogreet
*
* This file is part of Android Mercury.
*
* Mercury is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Mercury is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Mercury. If not, see <http://www.gnu.org/licenses/>.
*/

package android.mercury.user;

import java.util.*;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import android.mercury.Response;

/**
* The Getopt object contains the response from a {@link Mercury#getopt} request to the Moms API.
*/
public class Getopt extends Response{
	
	private HashMap<Integer, HashMap<String, String>> campaigns;

	/**
	 * Creation of a new Getopt response to the MOMs API.
	 * @param newXmlDoc XML DOM Document.
	 */
	public Getopt(Document newXmlDoc) {
		super(newXmlDoc);
		if (!super.responseIsValid())
			throw new RuntimeException(super.getMessage());
		try {
			XPath xpath = XPathFactory.newInstance().newXPath();
			XPathExpression expr = xpath.compile("/response/campaign/@id | /response/campaign/status/@code | /response/campaign/status/text()");

			NodeList nodes = (NodeList)expr.evaluate(newXmlDoc, XPathConstants.NODESET);
			this.campaigns = new HashMap<Integer, HashMap<String, String>>();
			int campaignId = 0;
			for (int i = 0; i < nodes.getLength(); ++i) {
				if (nodes.item(i).getNodeName().equals("id")) {
					campaignId = Integer.parseInt(nodes.item(i).getNodeValue());
					this.campaigns.put(campaignId, new HashMap<String, String>());
				} else {
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
	 * Get the campaign IDs.
	 * @return An ArrayList that contains all the campaigns ID.
	 */
	public ArrayList<Integer> getCampaignsIdList() {
		ArrayList<Integer> campaignsIdList = new ArrayList<Integer>();
		campaignsIdList.addAll(this.campaigns.keySet());
		return campaignsIdList;
	}
	
	/**
	 * Get the status code of the campaign.
	 * @param campaignId The campaign ID.
	 * @return The campaign status code of the specified campaign. 0 if the campaign ID does not exist.
	 */
	public int getCampaignStatusCode(int campaignId) {
		HashMap<String, String> campaign = this.campaigns.get(campaignId);
		if (campaign != null) {
			return Integer.parseInt(campaign.get("code"));
		} else {
			return 0;
		}
	}
	
	/**
	 * Get the status of the campaign.
	 * @param campaignId The campaign ID.
	 * @return The campaign status of the specified campaign. Null if the campaign ID does not exist.
	 */
	public String getCampaignStatus(int campaignId) {
		HashMap<String, String> campaign = this.campaigns.get(campaignId);
		if (campaign != null) {
			return campaign.get("status");
		} else {
			return null;
		}
	}

}
