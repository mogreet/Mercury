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

package com.mogreet.mercury;

import org.w3c.dom.*;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import javax.xml.transform.dom.*;
import java.io.*;
import java.util.*;
import javax.xml.xpath.*;
import java.lang.Math.*;

/**
* Response is the super class for all the kind of responses that can be obtained from the Moms API requests.
* It contains common methods for the subclasses.
*/
public class Response {
	
	private Document xmlDoc;
	
	private int responseCode;
	private String responseStatus;
	private String message;
	
	/**
	* Constructs a new Response object.
	* @param xmlDoc XML DOM document that is returned by all the requests.
	*/
	protected Response(Document xmlDoc) {
		this.xmlDoc = xmlDoc;
		this.setResponseCodeStatusMessage();
	}
	
	/**
	* Set the different attributes of the response class using XPath to parse the XML DOM document.
	*/
	private void setResponseCodeStatusMessage() {
		try {
			XPath xpath = XPathFactory.newInstance().newXPath();
			XPathExpression expr;
			
			expr = xpath.compile("/response/@status");
			this.responseStatus = (String)(expr.evaluate(this.xmlDoc, XPathConstants.STRING));
			
			expr = xpath.compile("/response/@code");
			this.responseCode = ((Double)(expr.evaluate(this.xmlDoc, XPathConstants.NUMBER))).intValue();
			
			expr = xpath.compile("/response/message/text()");
			this.message = (String)(expr.evaluate(this.xmlDoc, XPathConstants.STRING));
			
		} catch (XPathExpressionException e) {
			throw new RuntimeException("\nAn error occured while getting the response code, status and message: " + e.getMessage());
		}
	}
	
	/**
	* Checks if the response code is 1.
	* @return True if the response code is 1, false if it is not
	*/
	protected boolean responseIsValid() {
		if (this.responseCode == 1)
			return true;
		else
			return false;
	}
	
	/**
	* @return The response code.
	*/
	public int getResponseCode() {
		return this.responseCode;
	}
	
	/**
	* @return The response status.
	*/
	public String getResponseStatus() {
		return this.responseStatus;
	}
	
	/**
	* @return The response message.
	*/
	public String getMessage() {
		return this.message;
	}
	
	/**
	* @return The response XML string.
	*/
	public String getXMLString() {
		try {
			TransformerFactory factory = TransformerFactory.newInstance();
			Transformer transformer    = factory.newTransformer();
			StringWriter writer        = new StringWriter();
			Result result              = new StreamResult(writer);
			Source source              = new DOMSource(xmlDoc);
			transformer.transform(source, result);
			writer.close();
			return writer.toString();
		} catch (TransformerException e) {
			throw new RuntimeException("\nAn error occured while getting the XML string: " + e.getMessage());
		} catch (IOException e) {
			throw new RuntimeException("\nAn error occured while getting the XML string: " + e.getMessage());
		}
	}
}