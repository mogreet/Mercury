using System;
using System.Xml;
using System.IO;
using System.Web;
using System.Collections.Generic;
using MogreetSDK.system;
using MogreetSDK.transaction;
using MogreetSDK.user;

namespace MogreetSDK
{
    /// <summary>
	/// The Mercury is an object that allows to execute three types of requests 
	/// (system, user and transaction) to the Moms API.
    /// </summary>
	public class Mercury
	{
		private static string PING_URL = "https://api.mogreet.com/moms/system.ping?";
		private static string SEND_URL = "https://api.mogreet.com/moms/transaction.send?";
		private static string LOOKUP_URL = "https://api.mogreet.com/moms/transaction.lookup?";
		private static string GETOPT_URL = "https://api.mogreet.com/moms/user.getopt?";
		private static string SETOPT_URL = "https://api.mogreet.com/moms/user.setopt?";
		private static string UNCACHE_URL = "https://api.mogreet.com/moms/user.uncache?";
		private static string INFO_URL = "https://api.mogreet.com/moms/user.info?";
		private static string TRANSACTIONS_URL = "https://api.mogreet.com/moms/user.transactions?";

		private int mClientId;
		private string mToken;
		
		/// <summary>
		/// Initializes a new instance of the <see cref="SDK.Mercury"/> class.
		/// </summary>
		/// <param name='clientId'>
		/// Client identifier.
		/// </param>
		/// <param name='token'>
		/// Token.
		/// </param>
		public Mercury (int clientId, string token)
		{
			mClientId=clientId;
			mToken=token;
		}	
	
		/// <summary>
		/// Returns a XML document which content is the 
		/// XML response of the processed request.
		/// </summary>
		/// <returns>
		///  A XML document.
		/// </returns>
		/// <param name='url'>
		/// URL.
		/// </param>
		/// <param name='parameters'>
		/// Parameters.
		/// </param>
		/// <param name='reqName'>
		/// Request's name.
		/// </param>
		/// <exception cref='Exception'>
		/// Represents errors that occur during application execution.
		/// </exception>
		private XmlDocument processRequest(string url, string parameters, string reqName)
		{
			XmlDocument xmlDoc = new XmlDocument();
			try{
			
				//Creates Url
				string mUrl = url + parameters;
				
				//Creates xmlDocument
				xmlDoc.Load(mUrl);
				
				return xmlDoc;
				
			} catch (IOException e) {
				throw new Exception("\nThe " + reqName + " request URL is incorrect: "+e.Message);
			} 
		}
		 /// <summary>
		 /// Returns a URL format string created with Dictionary key-value pairs.
		 /// </summary>
		 /// <returns>
		 /// URL format string: param1=value1&param2=value2&param3=value3&...
		 /// </returns>
		 /// <param name='d'>
		 /// List of parameters (param_name-param_value pairs).
		 /// </param>
		 /// <exception cref='Exception'>
		 /// Represents errors that occur during application execution.
		 /// </exception>
		private string setParams(Dictionary<string,string> d){
			string parameters;
			try{
				parameters = "client_id="+ mClientId + "&token=" + HttpUtility.UrlEncode(mToken);
				if( d != null)
				{
					foreach (KeyValuePair<string, string> pair in d)
					{
							parameters += "&" + HttpUtility.UrlEncode(pair.Key) + "=" + HttpUtility.UrlEncode(pair.Value);
					}
				
				}
			} catch (Exception e) {
				throw new Exception(e.Message);	
			}
			return parameters;
		}
		
		/// <summary>
		/// Tests connectivity to the Moms API servers.<br />
		/// <pre>
		/// <b>Code sample:</b> 
		/// Ping myPing = myMercury.ping();
		/// </pre>
		/// </summary>
		/// <returns>
		/// A new Ping response object.
		/// </returns>
		public Ping ping() {
			string parameters = setParams(null);
			XmlDocument xmlDoc = processRequest(PING_URL, parameters, "PING");
			return new Ping(xmlDoc);
		}
		
		/// <summary>
		/// Initiates a transaction and delivery of an SMS or MMS.
		/// <pre>
		/// <b>Code sample:</b> 
		/// Dictionary<String, String> parameters = new Dictionary<String, String>();
		/// parameters.Add("campaign_id", "xxxx");
		/// parameters.Add("to", "xxxxxxxxxx");
		/// parameters.Add("from", "xxxxxxxxxx");
		/// parameters.Add("message", "Hello, World!");
		/// parameters.Add("content_id", "xxxx")
		/// myMercury.send(parameters);
		/// </pre>
		/// </summary>
		/// <param name='d'>
		/// A Dictionary object that must contain the following keys with their corresponding value:
		/// <ul>
		///	<li> "campaign_id" -> "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
        ///	<li> "to" -> "...": <i>A 10-digit mobile phone number.</i>
        ///	<li> "from" -> "...": <i>A 10-digit mobile phone number.</i>
		/// <li> "message" -> "...": <i>Depending on your campaign set up, the message presented to the "to" user.</i>
		///	<li> "content_id" -> "...": <i>An ID associated to the content being sent (optional - depending on your campaign set up, this parameter may be required).</i>
		///	<li> OR "content_url" -> "...": <i>underdevelopment - for users who host their own content</i>
		/// </ul>
		/// The Dictionary can also contain the following optionnal key-value pairs: 
		/// <ul>
		///	<li> "to_name" -> "...": <i>A name associated to the "to" mobile number (if not included will be set to "to" mobile number).</i>
		/// <li> "from_name" -> "...": <i>A name associated to the "from" mobile number (if not included will be set to "from" mobile number).</i>
		/// <li> "udp_*" -> "...": <i>User Defined Parameter. Clients can pass in any number of udp_* parameters for message flow customization.</i>
		/// </ul>
		/// </param>
		/// <exception cref='Exception'>
		/// Represents errors that occur during application execution.
		/// </exception>
		public Send send(Dictionary<string,string> d){
			if (!(d.ContainsKey("campaign_id")) || !(d.ContainsKey("to")) || !(d.ContainsKey("from")) || !(d.ContainsKey("message")) || !(d.ContainsKey("content_id"))){ 
				if (!(d.ContainsKey("message_id")) || !(d.ContainsKey("to")) || !(d.ContainsKey("from")) || !(d.ContainsKey("message")) || !(d.ContainsKey("content_url")))
					throw new Exception("Error: input parameter(s) missing in the SEND call.");
			}
			string parameters = setParams(d);	
			XmlDocument xmlDoc = processRequest(SEND_URL, parameters, "SEND");
			return new Send(xmlDoc);
		}
		
		/// <summary>
		/// Returns the info, status and history of the requested transaction.
		/// <pre>
		/// <b>Code sample:</b>
		/// Dictionary<string,string> d = new Dictionary<string, string>();
		///	d.Add ("message_id","xxxx");
		///	d.Add("hash","xxxx");
		///	myMercury.lookup(d);
		/// </pre>
		/// </summary>
		/// <param name='d'>
		/// A Dictionary object that must contains the following keys with their corresponding value:
		/// <ul>
		///	<li> "message_id" -> "...": <i>An ID returned from a {@link #send} or from <see cref="send"/>  method.</i>
		/// <li> "hash" -> "...": <i>A hash returned from a {@link #send} or from a <see cref="send"/> method.</i>
	 	/// </ul>
		/// </param>
		/// <exception cref='Exception'>
		/// Represents errors that occur during application execution.
		/// </exception>
		/// <returns>
		/// A new Lookup response object
		/// </returns>
		public Lookup lookup (Dictionary<string,string> d) {
			if (!(d.ContainsKey("message_id")) || !(d.ContainsKey("hash"))) 
				throw new Exception("Error: input parameter(s) missing in the LOOKUP call.");
					
			string parameters = setParams(d);	
			XmlDocument xmlDoc = processRequest(LOOKUP_URL, parameters, "LOOKUP");
			return new Lookup(xmlDoc);
		}
		
		/// <summary>
		/// Returns the opt in status of any mobile number.
		/// <pre>
		/// <b>Code sample:</b> 
		/// Dictionary<string, string> parameters = new Dictionary<string, string>();
		/// parameters.Add("number", "xxxxxxxxxx");
		/// myMercury.getopt(parameters);
		/// </pre>
		/// </summary>
		/// <param name='d'>
		/// A Dictionary object that must contains the following keys with their corresponding value:
		/// <ul>
		///	<li> "number" -> "...": <i>A 10-digit mobile phone number.</i>
		/// </ul>
		/// The Dictionary can also contain the following optionnal key-value pairs:
		/// <ul>
		///	<li> "campaign_id" -> "...": <i>A campaign id to search on, if excluded, returns all opt in statuses for the client's campaigns.</i>
		/// </ul>
		/// </param>
		/// <exception cref='Exception'>
		/// Represents errors that occur during application execution.
		/// </exception>
		/// <returns>
		/// A new Getopt response object
		/// </returns>
		public Getopt getopt(Dictionary<string,string> d){
			if (!(d.ContainsKey("number"))) 
				throw new Exception("Error: input parameter(s) missing in the GETOPT call.");
			
			string parameters = setParams(d);	
			XmlDocument xmlDoc = processRequest(GETOPT_URL, parameters, "GETOPT");
			return new Getopt(xmlDoc);
			
		}
		
		/// <summary>
		/// Sets the opt in status of any mobile number.
		/// <pre>
		/// <b>Code sample:</b> 
		/// Dictionary<string, string> parameters = new Dictionary<string, string>();
		/// parameters.Add("number", "xxxxxxxxxx");
		/// parameters.Add("campaign_id", "xxxx");
		/// parameters.Add("status_code", "xxxx");
		/// myMercury.setopt(params);
		/// </pre>
		/// </summary>
		/// <param name='d'>
		/// A Dictionary object that must contains the following keys with their corresponding value:
		/// <ul>
		///	<li> "number" -> "...": <i>A 10-digit mobile phone number.</i>
		///	<li> "campaign_id" -> "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
		///	<li> "status_code" -> "...": <i>See the bellow table for available codes to use here.</i>
		/// </ul> 
		/// <table border="1">
		///	<tr>
		/// 	<td>Status</td>
		/// 	<td>Status code</td>
		///		<td>Description</td>
		/// </tr>
		/// <tr>
		/// 	<td>OPTEDIN</td>
		/// 	<td>1</td>
		///		<td>User is opted into the campaign</td>
		///	</tr>
		///	<tr>
		///		<td>OPTEDOUT</td>
		///		<td>-2</td>
		///		<td>User is opted out of the campaign</td>
		///	</tr>
		/// </table>
		/// <br />
		/// </param>
		/// <exception cref='Exception'>
		/// Represents errors that occur during application execution.
		/// </exception>
		/// <returns>
		/// A new Setopt response object
		/// </returns>
		public Setopt setopt(Dictionary<string,string> d){
			if (!(d.ContainsKey("number")) || !(d.ContainsKey("campaign_id")) || !(d.ContainsKey("status_code"))) 
				throw new Exception("Error: input parameter(s) missing in the SETOPT call.");
			
			string parameters = setParams(d);	
			XmlDocument xmlDoc = processRequest(SETOPT_URL, parameters, "SETOPT");
			return new Setopt(xmlDoc);
		}
		
		/// <summary>
		/// Clears the user carrier and handset info from the Mogreet cache.
		/// <pre>
		/// <b>Code sample:</b> 
		/// Dictionary<string, string> parameters = new Dictionary<string, string>();
		/// parameters.put("number", "xxxxxxxxxx");
		/// myMercury.uncache(parameters);
		/// </pre>
		/// </summary>
		/// <param name='d'>
		/// A Dictionary object that must contains the following key with its corresponding value:
		/// <ul>
		///	<li> "number" -> "...": <i>A 10-digit phone number.</i>
		/// </ul>
		/// </param>
		/// <exception cref='Exception'>
		/// Represents errors that occur during application execution.
		/// </exception>
		/// <returns>
		/// A new Uncache response object
		/// </returns>
		public Uncache uncache(Dictionary<string,string> d){
			if (!(d.ContainsKey("number"))) 
				throw new Exception("Error: input parameter(s) missing in the UNCACHE call.");
			
			string parameters = setParams(d);	
			XmlDocument xmlDoc = processRequest(UNCACHE_URL, parameters, "UNCACHE");
			return new Uncache(xmlDoc);
		}
		
		/// <summary>
		/// Returns the user carrier and handset info if available.
		/// <pre>
		/// <b>Code sample:</b> 
		/// Dictionary<string, string> parameters = new Dictionary<string, string>();
		/// parameters.Add("number", "xxxxxxxxxx");
		/// myMercury.info(parameters);
		/// </pre>
		/// </summary>
		/// <param name='d'>
		/// A Dictionary object that must contains the following keys with their corresponding value:
		/// <ul>
		///	<li> "number" -> "...": <i>A 10-digit mobile phone number.</i>
		/// </ul>
		/// </param>
		/// <exception cref='Exception'>
		/// Represents errors that occur during application execution.
		/// </exception>
		/// <returns>
		/// A new Info response object
		/// </returns>
		public Info info(Dictionary<string,string> d){
			if (!(d.ContainsKey("number"))) 
				throw new Exception("Error: input parameter(s) missing in the INFO call.");
			
			string parameters = setParams(d);	
			XmlDocument xmlDoc = processRequest(INFO_URL, parameters, "INFO");
			return new Info(xmlDoc);
		}
		
		/// <summary>
		/// Returns the user's transactions (open and closed).
		/// <pre>
		/// <b>Code sample:</b> 
		/// Dictionary<string, string> parameters = new Dictionary<string, string>();
		/// parameters.put("number", "xxxxxxxxxx");
		/// myMercury.transactions(parameters);
		/// </pre>
		/// </summary>
		/// <param name='d'>
		/// A Dictionary object that must contains the following key with its corresponding value:
		/// <ul>
		///	<li> "number" -> "...": <i>A 10-digit phone number.</i>
		/// </ul>
		/// The Dictionary can also contain the following optionnal key-value pairs:
		/// <ul>
		///	<li> "campaign_id" -> "...": <i>A campaign id to search on, if excluded, returns all transactions for the client's campaigns.</i>
		///	<li> "start_date" -> "...": <i>Narrow search by adding a date to start searching on (YYYY-MM-DD).</i>
		///	<li> "end_date" -> "...": <i>Narrow search by adding a date to stop searching on (YYYY-MM-DD).</i>
		/// </ul>
		/// </param>
		/// <exception cref='Exception'>
		/// Represents errors that occur during application execution.
		/// </exception>
		/// <returns>
		/// A new Transactions response object
		/// </returns>
		public Transactions transactions(Dictionary<string,string> d){
			if (!(d.ContainsKey("number"))) 
				throw new Exception("Error: input parameter(s) missing in the TRANSACTIONS call.");
			
			string parameters = setParams(d);	
			XmlDocument xmlDoc = processRequest(TRANSACTIONS_URL, parameters, "TRANSACTIONS");
			return new Transactions(xmlDoc);
		}
    }
}
