/**
* Copyright 2011 Julien Salvi for Mogreet 
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
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Mercury. If not, see <http://www.gnu.org/licenses/>.
*/

package android.mercury.transaction;

import javax.xml.xpath.XPath;

import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;

import android.mercury.Response;

/**
* The Send object contains the response from a {@link Mercury#send} request to the Moms API.
*/
public class Send extends Response{
	
	private int messageId;
	private String hash;

	/**
	 * Creation of a new Send response to the MOMs API.
	 * @param newXmlDoc
	 */
	public Send(Document xmlDoc) {
		super(xmlDoc);
		if (!super.responseIsValid())
			throw new RuntimeException(super.getMessage());
		try {
			XPath xpath = XPathFactory.newInstance().newXPath();
			XPathExpression expr;

			expr = xpath.compile("/response/message_id/text()");
			this.messageId = ((Double)(expr.evaluate(xmlDoc, XPathConstants.NUMBER))).intValue();

			expr = xpath.compile("/response/hash/text()");
			this.hash = (String)(expr.evaluate(xmlDoc, XPathConstants.STRING));

		} catch (XPathExpressionException e) {
			throw new RuntimeException("\nAn error occured while parsing the XML data for the SEND call: " + e.getMessage());
		}
	}

	/**
	 * @return The message ID.
	 */
	public int getMessageId() {
		return this.messageId;
	}

	/**
	 * @return The hash.
	 */
	public String getHash() {
		return this.hash;
	}
}
