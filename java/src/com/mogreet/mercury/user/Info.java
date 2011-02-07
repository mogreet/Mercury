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
* The Info object contains the response from an {@link Mercury#info} request to the Moms API.
*/
public class Info extends Response {
		
	private String number;
	private int carrierId;
	private String carrier;
	private int handsetId;
	private String handset;
	
	/**
	* Creates a new Info response object.
	* @param xmlDoc XML DOM document that is returned by all the requests.
	*/
	public Info(Document xmlDoc) {
		super(xmlDoc);
		if (!super.responseIsValid())
			throw new RuntimeException(super.getMessage());
		try {
			XPath xpath = XPathFactory.newInstance().newXPath();
			XPathExpression expr;

			expr = xpath.compile("/response/number/text()");
			this.number = (String)(expr.evaluate(xmlDoc, XPathConstants.STRING));
			
			expr = xpath.compile("/response/carrier/@id");
			this.carrierId = ((Double)(expr.evaluate(xmlDoc, XPathConstants.NUMBER))).intValue();
			
			expr = xpath.compile("/response/carrier/text()");
			this.carrier = (String)(expr.evaluate(xmlDoc, XPathConstants.STRING));
			
			expr = xpath.compile("/response/handset/@id");
			this.handsetId = ((Double)(expr.evaluate(xmlDoc, XPathConstants.NUMBER))).intValue();
			
			expr = xpath.compile("/response/handset/text()");
			this.handset = (String)(expr.evaluate(xmlDoc, XPathConstants.STRING));

		} catch (XPathExpressionException e) {
			throw new RuntimeException("\nAn error occured while parsing the XML data for the INFO call: " + e.getMessage());
		}
	}
	
	/**
	* @return The requested number.
	*/
	public String getNumber() {
		return this.number;
	}
	
	/**
	* @return The carrier ID for the requested number.
	*/
	public int getCarrierId() {
		return this.carrierId;
	}
	
	/**
	* @return The carrier name for the requested number.
	*/
	public String getCarrier() {
		return this.carrier;
	}
	
	/**
	* @return The handset ID for the requested number.
	*/
	public int getHandsetId() {
		return this.handsetId;
	}
	
	/**
	* @return The handset name for the requested name.
	*/
	public String getHandset() {
		return this.handset;
	}
}