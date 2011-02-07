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

import com.mogreet.mercury.system.*;
import com.mogreet.mercury.transaction.*;
import com.mogreet.mercury.user.*;

import java.util.*;
import java.net.*;
import java.io.*;
import org.xml.sax.*;
import org.w3c.dom.*;
import javax.xml.parsers.*;
import javax.net.ssl.*;
import java.security.*;

/**
* The Mercury is an object that allows to execute three types of requests (system, user and transaction) to the Moms API.
*/
public class Mercury {
	
	private static final String PING_URL         = "https://api.mogreet.com/moms/system.ping";
	private static final String SEND_URL         = "https://api.mogreet.com/moms/transaction.send";
	private static final String LOOKUP_URL       = "https://api.mogreet.com/moms/transaction.lookup";
	private static final String GETOPT_URL       = "https://api.mogreet.com/moms/user.getopt";
	private static final String SETOPT_URL       = "https://api.mogreet.com/moms/user.setopt";
	private static final String UNCACHE_URL      = "https://api.mogreet.com/moms/user.uncache";
	private static final String INFO_URL         = "https://api.mogreet.com/moms/user.info";
	private static final String TRANSACTIONS_URL = "https://api.mogreet.com/moms/user.transactions";

	private int clientId;
	private String token;
	
	/**
	* Constructs a new Mercury.
	* @param clientId Client ID
	* @param token Token
	*/
	public Mercury(int clientId, String token) {
		this.clientId = clientId;
		this.token    = token;
	} 

	/**
	* Returns a XML DOM document which content is the XML response of the processed request.
	* @param url Client ID
	* @param params Parameters string formatted as URL parameters (param1=value1&param2=value2&param3=value3&...)
	* @param reqName Request's name
	* @return A XML DOM document
	*/
	private Document processRequest(String url, String params, String reqName) {
		Document xmlDoc = null;
		try {			
			URL urlObj = new URL(url);
			// Opens connection
		    HttpsURLConnection conn = (HttpsURLConnection)urlObj.openConnection();
		    conn.setDoOutput(true);
	
			// Sends data
		    OutputStreamWriter out = new OutputStreamWriter(conn.getOutputStream());
		    out.write(params);
			// Flushes the stream 
		    out.flush();
	
			// Read response data			
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			InputSource is = new InputSource(in);

			// Creates XML DOM object
			try {
				DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
				builderFactory.setNamespaceAware(true);
				DocumentBuilder builder = builderFactory.newDocumentBuilder();
				xmlDoc = builder.parse(is);
			} catch (SAXException e) {
				throw new RuntimeException("\nAn error occured while creating the XML DOM object: "+e.getMessage());
			} catch (IOException e) {
				throw new RuntimeException("\nAn error occured while creating the XML DOM object: "+e.getMessage());
			} catch (ParserConfigurationException e) {
				throw new RuntimeException("\nAn error occured while creating the XML DOM object: "+e.getMessage());
			}
			
			out.close();
			in.close();
			
			return xmlDoc;
			
		} catch (MalformedURLException e) {
			throw new RuntimeException("\nThe " + reqName + " request URL is incorrect: "+e.getMessage());
		} catch (IOException e) {
			throw new RuntimeException("\nAn error occured while sending the " + reqName + " request: " + e.getMessage());
		}
	}
	
	/**
	* Returns a URL format string created with HashMap key-value pairs.
	* @param hash List of parameters (param_name-param_value pairs)
	* @return URL format string: param1=value1&param2=value2&param3=value3&...
	*/
	private String setParams(HashMap<String, String> hash) {
		String params;
		try {
			params = "client_id="+clientId+"&token="+URLEncoder.encode(token, "UTF-8");
			if ((hash != null) && (!hash.isEmpty()))
				for (Map.Entry<String, String> entry : hash.entrySet())
					params += "&" + URLEncoder.encode(entry.getKey(), "UTF-8") + "=" + URLEncoder.encode(entry.getValue(), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e.getMessage());
		}
		return params;
	}
	
	/**
	* Checks if the parameters in paramsList are the keys in hash.
	* @param hash List of parameters (param_name-param_value pairs)
	* @param paramsList Array of parameters names
	* @return True if all parameters in the list are the keys in hash, else false
	*/
	private boolean checkInputParams(String[] paramsList, HashMap<String, String> hash) {
		for (int i=0; i<paramsList.length; ++i)
			if (!hash.containsKey(paramsList[i]))
				return false;
		return true;
	}
	
	/**
	* Tests connectivity to the Moms API servers.<br />
	* <pre>
	* <b>Code sample:</b> 
	* Ping myPing = myMercury.ping();
	* </pre> 
	* @return A new Ping response object
	*/
	public Ping ping() {
		String params   = setParams(null);
		Document xmlDoc = processRequest(PING_URL, params, "PING");
		return new Ping(xmlDoc);
	}

	/**
	* Initiates a transaction and delivery of an SMS or MMS.
	* <pre>
	* <b>Code sample:</b> 
	* HashMap<String, String> params = new HashMap<String, String>();
	* params.put("campaign_id", "xxxx");
	* params.put("to", "xxxxxxxxxx");
	* params.put("from", "xxxxxxxxxx");
	* params.put("message", "Hello, World!");
	* params.put("content_id", "xxxx")
	* Send mySend = myMercury.send(params);
	* </pre>
	* @param hash A HashMap object that must contain the following keys with their corresponding value:
	* <ul>
	*	<li> "campaign_id" &rarr; "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
	*	<li> "to" &rarr; "...": <i>A 10-digit mobile phone number.</i>
	* 	<li> "from" &rarr; "...": <i>A 10-digit mobile phone number.</i>
	* 	<li> "message" &rarr; "...": <i>Depending on your campaign set up, the message presented to the "to" user.</i>
	* 	<li> "content_id" &rarr; "...": <i>An ID associated to the content being sent (optional - depending on your campaign set up, this parameter may be required).</i>
	*	<li> OR "content_url" &rarr; "...": <i>underdevelopment - for users who host their own content</i>
	* </ul>
	* The HashMap can also contain the following optionnal key-value pairs: 
	* <ul>
	*	<li> "to_name" &rarr; "...": <i>A name associated to the "to" mobile number (if not included will be set to "to" mobile number).</i>
	* 	<li> "from_name" &rarr; "...": <i>A name associated to the "from" mobile number (if not included will be set to "from" mobile number).</i>
	* 	<li> "udp_*" &rarr; "...": <i>User Defined Parameter. Clients can pass in any number of udp_* parameters for message flow customization.</i>
	* </ul>
	* @return A new Send response object
	*/
	public Send send(HashMap<String, String> hash) {
		String[] paramsListWithContentID = {"campaign_id", "to", "from", "message", "content_id"};
		String[] paramsListWithContentURL = {"campaign_id", "to", "from", "message", "content_url"};
		if (!(this.checkInputParams(paramsListWithContentID, hash) || this.checkInputParams(paramsListWithContentURL, hash)))
			throw new IllegalArgumentException("Error: input parameter(s) missing in the SEND call.");
		
		String params   = setParams(hash);
		Document xmlDoc = processRequest(SEND_URL, params, "SEND");
		return new Send(xmlDoc);
	}
	
	/**
	* Returns the info, status and history of the requested transaction.
	* <pre>
	* <b>Code sample:</b> 
	* HashMap<String, String> params = new HashMap<String, String>();
	* params.put("message_id", "xxxx");
	* params.put("hash", "xxxx");
	* Lookup myLookup = myMercury.lookup(params);
	* </pre>
	* @param hash A HashMap object that must contains the following keys with their corresponding value:
	* <ul>
	*	<li> "message_id" &rarr; "...": <i>An ID returned from a {@link #send} or from {@link #transactions} method.</i>
	*	<li> "hash" &rarr; "...": <i>A hash returned from a {@link #send} or from a {@link #transactions} method.</i>
	* </ul>
	* @return A new Lookup response object
	*/
	public Lookup lookup(HashMap<String, String> hash) {
		String[] paramsList = {"message_id", "hash"};
		if (!this.checkInputParams(paramsList, hash)) 
			throw new IllegalArgumentException("Error: input parameter(s) missing in the LOOKUP call.");
				
		String params   = setParams(hash);	
		Document xmlDoc = processRequest(LOOKUP_URL, params, "LOOKUP");
		return new Lookup(xmlDoc);
	}
	
	/**
	* Returns the opt in status of any mobile number.
	* <pre>
	* <b>Code sample:</b> 
	* HashMap<String, String> params = new HashMap<String, String>();
	* params.put("number", "xxxxxxxxxx");
	* Getopt myGetopt = myMercury.getopt(params);
	* </pre>
	* @param hash A HashMap object that must contains the following keys with their corresponding value:
	* <ul>
	*	<li> "number" &rarr; "...": <i>A 10-digit mobile phone number.</i>
	* </ul>
	* The HashMap can also contain the following optionnal key-value pairs:
	* <ul>
	*	<li> "campaign_id" &rarr; "...": <i>A campaign id to search on, if excluded, returns all opt in statuses for the client's campaigns.</i>
	* </ul>
	* @return A new Getopt response object
	*/
	public Getopt getopt(HashMap<String, String> hash) {
		String[] paramsList = {"number"};
		if (!this.checkInputParams(paramsList, hash)) 
			throw new IllegalArgumentException("Error: input parameter(s) missing in the GETOPT call.");
		
		String params   = setParams(hash);
		Document xmlDoc = processRequest(GETOPT_URL, params, "GETOPT");
		return new Getopt(xmlDoc);
	}
	
	/**
	* Sets the opt in status of any mobile number.
	* <pre>
	* <b>Code sample:</b> 
	* HashMap<String, String> params = new HashMap<String, String>();
	* params.put("number", "xxxxxxxxxx");
	* params.put("campaign_id", "xxxx");
	* params.put("status_code", "xxxx");
	* Setopt mySetopt = myMercury.setopt(params);
	* </pre>
	* @param hash A HashMap object that must contains the following keys with their corresponding value:
	* <ul>
	*	<li> "number" &rarr; "...": <i>A 10-digit mobile phone number.</i>
	*	<li> "campaign_id" &rarr; "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
	*	<li> "status_code" &rarr; "...": <i>See the bellow table for available codes to use here.</i>
	* </ul>
	*
	* <table border="1">
	* 	<tr>
	* 		<td>Status</td>
	* 		<td>Status code</td>
	*		<td>Description</td>
	* 	</tr>
	* 	<tr>
	* 		<td>OPTEDIN</td>
	* 		<td>1</td>
	*		<td>User is opted into the campaign</td>
	* 	</tr>
	* 	<tr>
	* 		<td>OPTEDOUT</td>
	* 		<td>-2</td>
	*		<td>User is opted out of the campaign</td>
	* 	</tr>
	* </table>
	* <br />
	* @return A new Setopt response object
	*/
	public Setopt setopt(HashMap<String, String> hash) {
		String[] paramsList = {"number", "campaign_id", "status_code"};
		if (!this.checkInputParams(paramsList, hash)) 
			throw new IllegalArgumentException("Error: input parameter(s) missing in the SETOPT call.");
			
		String params   = setParams(hash);
		Document xmlDoc = processRequest(SETOPT_URL, params, "SETOPT");
		return new Setopt(xmlDoc);
	}
	
	/**
	* Clears the user carrier and handset info from the Mogreet cache.
	* <pre>
	* <b>Code sample:</b> 
	* HashMap<String, String> params = new HashMap<String, String>();
	* params.put("number", "xxxxxxxxxx");
	* Uncache myUncache = myMercury.uncache(params);
	* </pre>
	* @param hash A HashMap object that must contains the following key with its corresponding value:
	* <ul>
	*	<li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
	* </ul>
	* @return A new Uncache response object
	*/
	public Uncache uncache(HashMap<String, String> hash) {
		String[] paramsList = {"number"};
		if (!this.checkInputParams(paramsList, hash)) 
			throw new IllegalArgumentException("Error: input parameter(s) missing in the UNCACHE call.");
		
		String params   = setParams(hash);
		Document xmlDoc = processRequest(UNCACHE_URL, params, "UNCACHE");
		return new Uncache(xmlDoc);
	}
	
	/**
	* Returns the user carrier and handset info if available.
	* <pre>
	* <b>Code sample:</b> 
	* HashMap<String, String> params = new HashMap<String, String>();
	* params.put("number", "xxxxxxxxxx");
	* Info myInfo = myMercury.info(params);
	* </pre>
	* @param hash A HashMap object that must contains the following key with its corresponding value:
	* <ul>
	*	<li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
	* </ul>
	* @return A new Info response object
	*/
	public Info info(HashMap<String, String> hash) {
		String[] paramsList = {"number"};
		if (!this.checkInputParams(paramsList, hash)) 
			throw new IllegalArgumentException("Error: input parameter(s) missing in the INFO call.");
			
		String params   = setParams(hash);
		Document xmlDoc = processRequest(INFO_URL, params, "INFO");
		return new Info(xmlDoc);
	}
	
	/**
	* Returns the user's transactions (open and closed).
	* <pre>
	* <b>Code sample:</b> 
	* HashMap<String, String> params = new HashMap<String, String>();
	* params.put("number", "xxxxxxxxxx");
	* Transactions myTransactions = myMercury.transactions(params);
	* </pre>
	* @param hash A HashMap object that must contains the following key with its corresponding value:
	* <ul>
	*	<li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
	* </ul>
	* The HashMap can also contain the following optionnal key-value pairs:
	* <ul>
	*	<li> "campaign_id" &rarr; "...": <i>A campaign id to search on, if excluded, returns all transactions for the client's campaigns.</i>
	*	<li> "start_date" &rarr; "...": <i>Narrow search by adding a date to start searching on (YYYY-MM-DD).</i>
	*	<li> "end_date" &rarr; "...": <i>Narrow search by adding a date to stop searching on (YYYY-MM-DD).</i>
	* </ul>
	* @return A new Transactions response object
	*/
	public Transactions transactions(HashMap<String, String> hash) {
		String[] paramsList = {"number"};
		if (!this.checkInputParams(paramsList, hash)) 
			throw new IllegalArgumentException("Error: input parameter(s) missing in the TRANSACTIONS call.");
			
		String params   = setParams(hash);
		Document xmlDoc = processRequest(TRANSACTIONS_URL, params, "TRANSACTIONS");
		return new Transactions(xmlDoc);
	}
}