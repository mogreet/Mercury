using System;
using System.Xml;
using System.Security;
using System.Collections.Generic;

namespace MogreetSDK.transaction
{
    /// <summary>
    /// The Lookup object contains the response from a <see cref="MogreetSDK.Mercury.lookup"/> request to the Moms API.
    /// </summary>
    /// <exception cref='Exception'>
    /// Represents errors that occur during application execution.
    /// </exception>
    public class Lookup : Response
    {
        private int campaignId;
        private string fromNumber;
        private string fromName;
        private string toNumber;
        private string toName;
        private int contentId;
        private string status;
        private Dictionary<string, List<string>> history;

        /// <summary>
        /// Initializes a new instance of the <see cref="SDK.Lookup"/> class.
        /// </summary>
        /// <param name='xmlDoc'>
        /// Xml document that is returned by all the requests.
        /// </param>
        /// <exception cref='Exception'>
        /// Represents errors that occur during application execution.
        /// </exception>
        public Lookup(XmlDocument xmlDoc)
            : base(xmlDoc)
        {
            if (!(base.responseIsValid()))
                throw new Exception(base.getMessage());
            try
            {
                // Creates XML Reader
                XmlNode campidr = mXmlDoc.SelectSingleNode("//response/campaign_id/text()");
                this.campaignId = Int32.Parse(campidr.InnerText);
                Console.WriteLine("campaignId: " + this.campaignId);

                XmlNode fromr = mXmlDoc.SelectSingleNode("//response/from/text()");
                this.fromNumber = fromr.Value;
                Console.WriteLine("From Number: " + this.fromNumber);

                XmlNode fromnr = mXmlDoc.SelectSingleNode("//response/from_name/text()");
                this.fromName = fromnr.Value;
                Console.WriteLine("From Name: " + this.fromName);

                XmlNode tor = mXmlDoc.SelectSingleNode("//response/to/text()");
                this.toNumber = tor.Value;
                Console.WriteLine("To Number: " + this.toNumber);

                XmlNode tonr = mXmlDoc.SelectSingleNode("//response/to_name/text()");
                this.toName = tonr.Value;
                Console.WriteLine("To Name: " + this.toName);

                XmlNode contidr = mXmlDoc.SelectSingleNode("//response/content_id/text()");
                this.contentId = Int32.Parse(contidr.InnerText);
                Console.WriteLine("Content Id: " + this.contentId);

                XmlNode statr = mXmlDoc.SelectSingleNode("//response/status/text()");
                this.status = statr.Value;
                Console.WriteLine("Status: " + this.status);

                XmlNodeList events = mXmlDoc.SelectNodes("//response/history/event");
                this.history = new Dictionary<string, List<string>>();



                for (int i = 0; i < events.Count; i++)
                {
                    string timestamp = (events.Item(i).Attributes.Item(0)).Value;
                    string eventr = events.Item(i).FirstChild.Value;
                    setHistory(timestamp, eventr);
                }

            }
            catch (XmlException e)
            {
                throw new Exception("\nAn error occured while parsing the XML data for the LOOKUP call: " + e.Message);
            }
        }

        /// <summary>
        /// Sets the history Dictionary with a timestamp as a key and a 
        /// list of events corresponding to the timestamp.
        /// </summary>
        /// <param name='key'>
        /// A timestamp.
        /// </param>
        /// <param name='value'>
        /// An event.
        /// </param>
        private void setHistory(string key, string value)
        {
            if (!this.history.ContainsKey(key))
            {
                List<string> list = new List<string>();
                list.Add(value);
                this.history.Add(key, list);
                Console.WriteLine("timestamp " + key + " event " + value);

            }
            else
            {
                List<string> list = this.history[key];
                list.Add(value);
                Console.WriteLine("timestamp " + key + " event " + value);

            }
        }

        /// <summary>
        /// Gets the campaign identifier of the requested transaction.
        /// </summary>
        /// <returns>
        /// The campaign identifier.
        /// </returns>
        public int getCampaignId()
        {
            return this.campaignId;
        }

        /// <summary>
        /// Gets from number of the requested transaction. 
        /// </summary>
        /// <returns>
        /// The from number.
        /// </returns>
        public string getFromNumber()
        {
            return this.fromNumber;
        }

        /// <summary>
        /// Gets the name of the from of the requested transaction. 
        /// </summary>
        /// <returns>
        /// The from name.
        /// </returns>
        public string getFromName()
        {
            return this.fromName;
        }

        /// <summary>
        /// Gets to number of the requested transaction.  
        /// </summary>
        /// <returns>
        /// The to number.
        /// </returns>
        public string getToNumber()
        {
            return this.toNumber;
        }

        /// <summary>
        /// Gets the name of the to of the requested transaction. 
        /// </summary>
        /// <returns>
        /// The to name.
        /// </returns>
        public string getToName()
        {
            return this.toName;
        }

        /// <summary>
        /// Gets the content identifier of the requested transaction. 
        /// </summary>
        /// <returns>
        /// The content identifier.
        /// </returns>
        public int getContentId()
        {
            return this.contentId;
        }

        /// <summary>
        /// Gets the status of the requested transaction. 
        /// </summary>
        /// <returns>
        /// The status.
        /// </returns>
        public string getStatus()
        {
            return this.status;
        }

        /// <summary>
        /// Gets the timestamp list of the requested transaction. 
        /// </summary>
        /// <returns>
        /// The timestamp list.
        /// </returns>
        public List<string> getTimestampList()
        {
            List<string> timestamps = new List<string>(this.history.Keys);
            return timestamps;
        }

        /// <summary>
        /// Gets the events list of the requested transaction. 
        /// </summary>
        /// <returns>
        /// The events list.
        /// </returns>
        public List<string> getEventsList()
        {
            List<string> events = new List<string>();
            List<string> timestamps = new List<string>(this.history.Keys);
            foreach (string k in timestamps)
            {
                List<string> eventsTemp = new List<string>(this.history[k]);
                for (int i = 0; i < eventsTemp.Count; i++)
                {
                    events.Add(eventsTemp[i]);
                }
            }
            return events;
        }

        /// <summary>
        /// Gets the list of the events that occured at the specified timestamp of the requested transaction.
        /// </summary>
        /// <returns>
        /// The events, Null if the specified timestamp does not exist.
        /// </returns>
        /// <param name='timestamp'>
        /// Timestamp.
        /// </param>
        public List<string> getEvents(string timestamp)
        {
            List<string> events = new List<string>(this.history[timestamp]);
            return events;
        }
    }
}
