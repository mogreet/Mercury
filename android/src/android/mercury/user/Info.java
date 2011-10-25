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
	 * @param newXmlDoc XML DOM document used for the requests.
	 */
	public Info(Document newXmlDoc) {
		super(newXmlDoc);
		if (!super.responseIsValid())
			throw new RuntimeException(super.getMessage());
		try {
			
			NodeList nodeList = newXmlDoc.getElementsByTagName("response");
			
			for (int i = 0; i < nodeList.getLength(); i++) {

				Node node = nodeList.item(i);

				Element first = (Element) node;

				NodeList numList = first.getElementsByTagName("number");
				Element numElem = (Element) numList.item(0);
				numList = numElem.getChildNodes();
				
				NodeList carrierList = first.getElementsByTagName("carrier");
				Element carrierElem = (Element) carrierList.item(0);
				carrierList = carrierElem.getChildNodes();
				
				NodeList handsetList = first.getElementsByTagName("handset");
				Element handsetElem = (Element) handsetList.item(0);
				handsetList = handsetElem.getChildNodes();
				
				this.number = numElem.getTextContent();
				this.carrier = carrierElem.getTextContent();
				this.carrierId = Integer.parseInt(carrierElem.getAttribute("id"));
				this.handset = handsetElem.getTextContent();
				this.handsetId = Integer.parseInt(handsetElem.getAttribute("id"));
				
			}
			
		} catch (Exception e){
			throw new RuntimeException("\nAn error occurred while parsing the XML data for the INFO call :"+e.getMessage());
		}
	}
	
	/**
	 * @return Getting the requested number.
	 */
	public String getNumber() {
		return this.number;
	}
	
	/**
	 * @return Getting the carrier ID for the requested number.
	 */
	public int getCarrierId() {
		return this.carrierId;
	}
	
	/**
	 * @return Getting the carrier of the requested number.
	 */
	public String getCarrier() {
		return this.carrier;
	}
	
	/**
	 * @return Getting the handset ID for the requested number
	 */
	public int getHandsetId() {
		return this.handsetId;
	}
	
	/**
	 * @return Getting the handset for the requested number
	 */
	public String getHandset() {
		return this.handset;
	}

}
