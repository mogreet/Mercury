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
import org.w3c.dom.*;
import javax.xml.xpath.*;
import java.lang.Math.*;

/**
* The Setopt object contains the response from a {@link Mercury#setopt} request to the Moms API.
*/
public class Setopt extends Response {
		
	private int campaignId;
	private int campaignStatusCode;
	private String campaignStatus;
	
	/**
	* Creates a new Setopt response object.
	* @param xmlDoc XML DOM document that is returned by all the requests.
	*/
	public Setopt(Document xmlDoc) {
		super(xmlDoc);
		if (!super.responseIsValid())
			throw new RuntimeException(super.getMessage());
		try {
			XPath xpath = XPathFactory.newInstance().newXPath();
			XPathExpression expr;

			expr = xpath.compile("/response/campaign/@id");
			this.campaignId = ((Double)(expr.evaluate(xmlDoc, XPathConstants.NUMBER))).intValue();

			expr = xpath.compile("/response/campaign/status/@code");
			this.campaignStatusCode = ((Double)(expr.evaluate(xmlDoc, XPathConstants.NUMBER))).intValue();
			
			expr = xpath.compile("/response/campaign/status/text()");
			this.campaignStatus = (String)(expr.evaluate(xmlDoc, XPathConstants.STRING));
			
		} catch (XPathExpressionException e) {
			throw new RuntimeException("\nAn error occured while parsing the XML data for the SETOPT call: " + e.getMessage());
		}
	}
	
	/**
	* @return The campaign ID.
	*/
	public int getCampaignId() {
		return this.campaignId;
	}
	
	/**
	* @return The campaign status code.
	*/
	public int getCampaignStatusCode() {
		return this.campaignStatusCode;
	}
	
	/**
	* @return The campaign status label.
	*/
	public String getCampaignStatus() {
		return this.campaignStatus;
	}
}