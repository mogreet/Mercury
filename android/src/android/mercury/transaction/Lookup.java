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

import java.util.*;

import javax.xml.xpath.*;

import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import android.mercury.Response;

/**
* The Lookup object contains the response from a {@link Mercury#lookup} request to the Moms API.
*/
public class Lookup extends Response{
	
	private int campaignId;
	private String fromNumber;
	private String fromName;
	private String toName;
	private String toNumber;
	private int contentId;
	private String status;
	private HashMap<String, ArrayList<String>> history;

	/**
	 * Creation of a new Lookup response to the MOMs API.
	 * @param xmlDoc XML DOM Document
	 */
	public Lookup(Document xmlDoc) {
		super(xmlDoc);
		if (!super.responseIsValid())
			throw new RuntimeException(super.getMessage());
		try {
			XPath xpath = XPathFactory.newInstance().newXPath();
			XPathExpression expr;
	
			expr = xpath.compile("/response/campaign_id/text()");
			this.campaignId = ((Double)(expr.evaluate(xmlDoc, XPathConstants.NUMBER))).intValue();
	
			expr = xpath.compile("/response/from/text()");
			this.fromNumber = (String)(expr.evaluate(xmlDoc, XPathConstants.STRING));
	
			expr = xpath.compile("/response/from_name/text()");
			this.fromName = (String)(expr.evaluate(xmlDoc, XPathConstants.STRING));
	
			expr = xpath.compile("/response/to/text()");
			this.toNumber = (String)(expr.evaluate(xmlDoc, XPathConstants.STRING));
	
			expr = xpath.compile("/response/to_name/text()");
			this.toName = (String)(expr.evaluate(xmlDoc, XPathConstants.STRING));
	
			expr = xpath.compile("/response/content_id/text()");
			this.contentId = ((Double)(expr.evaluate(xmlDoc, XPathConstants.NUMBER))).intValue();
	
			expr = xpath.compile("/response/status/text()");
			this.status = (String)(expr.evaluate(xmlDoc, XPathConstants.STRING));
	
			expr = xpath.compile("/response/history/event");
			NodeList events = (NodeList)(expr.evaluate(xmlDoc, XPathConstants.NODESET));
			this.history = new HashMap<String, ArrayList<String>>();
	
			for (int i = 0; i < events.getLength(); ++i) {
				String timestamp = ((Attr)events.item(i).getAttributes().item(0)).getValue();
				String event = events.item(i).getFirstChild().getNodeValue();
				setHistory(timestamp, event);
			}
		} catch (XPathExpressionException e) {
			throw new RuntimeException("\nAn error occured while parsing the XML data for the LOOKUP call: " + e.getMessage());
		}
	}
	
	/**
	 * @return Set the history HasMap with timestamp as a key and a list of events corresponding to the timestamp.
	 * @param key A timestamp.
	 * @param value An event.
	 */
	private void setHistory(String key, String value) {
		if (!this.history.containsKey(key)) {
			ArrayList<String> list = new ArrayList<String>();
			list.add(value);
			this.history.put(key, list);
		} else {
			ArrayList<String> list = (ArrayList<String>)this.history.get(key);
			list.add(value);
		}
	}
	
	/**
	 * @return The campaign ID of the requested transaction.
	 */
	public int getCampaignId() {
		return this.campaignId;
	}
	
	/**
	 * @return The sender number of the requested transaction.
	 */
	public String getFromNumber() {
		return this.fromNumber;
	}
	
	/**
	 * @return The sender name of the requested transaction.
	 */
	public String getFromName() {
		return this.fromName;
	}
	
	/**
	 * @return The receiver name of the requested transaction.
	 */
	public String getToName() {
		return this.toName;
	}
	
	/**
	 * @return The receiver number of the requested transaction.
	 */
	public String getToNumber() {
		return this.toNumber;
	}

	/**
	 * @return The content ID of the requested transaction.
	 */
	public int getContentId() {
		return this.contentId;
	}

	/**
	 * @return The status label of the requested transaction.
	 */
	public String getStatus() {
		return this.status;
	}

	/**
	 * @return The history of the requested transaction.
	 */
	public HashMap<String, ArrayList<String>> getHistory() {
		return this.history;
	}
	
	/**
	 * @return The list of all the timestamp events of the requested transaction.
	 */
	public ArrayList<String> getTimestampsList() {
		ArrayList<String> timestamps = new ArrayList<String>();
		timestamps.addAll(this.history.keySet());
		return timestamps;
	}
	
	/**
	 * @return The list of all the events of the requested transaction.
	 */
	public ArrayList<String> getEventsList() {
		ArrayList<String> event = new ArrayList<String>();
		for (Map.Entry<String, ArrayList<String>> entry : this.history.entrySet()) {
			for (String evt : (ArrayList<String>)entry.getValue()) {
				event.add(evt);
			}
		}
		return event;
	}
	
	/**
	 * @param timestamp String
	 * @return The list of the events that occurred at the specified timestamp of the requested transaction.
	 * Null if the specified timestamp does not exist.
	 */
	public ArrayList<String> getEventList(String timestamp) {
		return this.history.get(timestamp);
	}
}
