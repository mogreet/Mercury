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

package android.mercury.user;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import android.mercury.Response;

/** 
 * 
 * The Uncache object contains the response from an {@link mercury#uncache} request to the MoMs API.
 */
public class Uncache extends Response {
	
	private String number;

	/**
	 * Creation of a new Uncache response to the MOMs API.
	 * @param newXmlDoc XML DOM Document.
	 */
	public Uncache(Document newXmlDoc) {
		super(newXmlDoc);
		if (!super.responseIsValid())
			throw new RuntimeException(super.getMessage());
		try {
			newXmlDoc.getDocumentElement().normalize();
			NodeList nodeList = newXmlDoc.getElementsByTagName("response");
			
			for (int i = 0; i < nodeList.getLength(); i++) {

				Node node = nodeList.item(i);

				Element fstElmnt = (Element) node;
				NodeList numberList = fstElmnt.getElementsByTagName("number");
				Element numberElem = (Element) numberList.item(0);
				numberList = numberElem.getChildNodes();
				
				this.number = numberElem.getTextContent();
			}
		} catch (Exception e){
			throw new RuntimeException("\nAn error occurred while parsing the XML data for the UNCACHE call :"+e.getMessage());
		}
	}
	
	/**
	 * @return Giving the number of the uncached phone.
	 */
	public String getNumber() {
		return this.number;
	}

}
