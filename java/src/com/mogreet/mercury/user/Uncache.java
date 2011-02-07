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

/**
* The Uncache object contains the response from an {@link Mercury#uncache} request to the Moms API.
*/
public class Uncache extends Response {
		
	private String number;
	
	/**
	* Creates a new Uncache response object.
	* @param xmlDoc XML DOM document that is returned by all the requests.
	*/
	public Uncache(Document xmlDoc) {
		super(xmlDoc);
		if (!super.responseIsValid())
			throw new RuntimeException(super.getMessage());
		try {
			XPath xpath = XPathFactory.newInstance().newXPath();
			XPathExpression expr;
			
			expr = xpath.compile("/response/number/text()");
			this.number = (String)(expr.evaluate(xmlDoc, XPathConstants.STRING));
			
		} catch (XPathExpressionException e) {
			throw new RuntimeException("\nAn error occured while parsing the XML data for the UNCACHE call: " + e.getMessage());
		}
	}
	
	/**
	* @return The number of the uncached phone.
	*/
	public String getNumber() {
		return this.number;
	}
}