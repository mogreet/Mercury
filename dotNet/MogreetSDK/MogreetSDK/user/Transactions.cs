using System;
using System.Xml;
using System.Security;
using System.Collections.Generic;

namespace MogreetSDK.user
{
    /// <summary>
    /// The Transactions object contains the response from a <see cref="MogreetSDK.Mercury.transactions"/> request to the Moms API.
    /// </summary>
    /// <exception cref='Exception'>
    /// Represents errors that occur during application execution.
    /// </exception>
    public class Transactions : Response
    {
        private Dictionary<string, Dictionary<int, Dictionary<string, string>>> campaigns;

        /// <summary>
        /// Initializes a new instance of the <see cref="SDK.Transactions"/> class.
        /// </summary>
        /// <param name='xmlDoc'>
        /// Xml document that is returned by all the requests.
        /// </param>
        /// <exception cref='Exception'>
        /// Represents errors that occur during application execution.
        /// </exception>
        public Transactions(XmlDocument xmlDoc)
            : base(xmlDoc)
        {
            if (!(base.responseIsValid()))
                throw new Exception(base.getMessage());
            try
            {
                XmlNodeList campList = mXmlDoc.SelectNodes("//response/campaign");
                XmlNodeList transList = mXmlDoc.SelectNodes("//response/campaign/transaction");

                this.campaigns = new Dictionary<string, Dictionary<int, Dictionary<string, string>>>();
                string campaignsIdName = null;
                string datestamp = null;
                string hash = null;
                Dictionary<string, string> transactionsInfo = null;

                for (int i = 0; i < campList.Count; i++)
                {
                    //recovers attributes
                    campaignsIdName = (campList.Item(i).Attributes.Item(0)).Value;
                    campaignsIdName += " " + (campList.Item(i).Attributes.Item(1)).Value;
                    if (!this.campaigns.ContainsKey(campaignsIdName))
                        this.campaigns.Add(campaignsIdName, new Dictionary<int, Dictionary<string, string>>());

                    datestamp = (transList.Item(i).Attributes.Item(0)).Value;
                    hash = (transList.Item(i).Attributes.Item(1)).Value;

                    Dictionary<int, Dictionary<string, string>> transactions = this.campaigns[campaignsIdName];
                    transactions.Add(Int32.Parse((transList.Item(i).Attributes.Item(2)).InnerText), new Dictionary<string, string>()); //messageID

                    transactionsInfo = transactions[Int32.Parse((transList.Item(i).Attributes.Item(2)).InnerText)];
                    transactionsInfo.Add("datestamp", datestamp);
                    transactionsInfo.Add("hash", hash);
                    transactionsInfo.Add("to_number", (transList.Item(i).LastChild.Attributes.Item(0)).Value);
                    transactionsInfo.Add("to_name", transList.Item(i).LastChild.InnerText);
                    transactionsInfo.Add("from_number", (transList.Item(i).FirstChild.Attributes.Item(0)).Value);
                    transactionsInfo.Add("from_name", transList.Item(i).FirstChild.InnerText);
                }
            }
            catch (XmlException e)
            {
                throw new Exception("\nAn error occured while parsing the XML data for the TRANSACTIONS call: " + e.Message);
            }
        }

        /// <summary>
        /// Gets the list of all the campaigns ID.
        /// </summary>
        /// <returns>
        /// The list of all the campaigns ID.
        /// </returns>
        public List<int> getCampaignsIdList()
        {
            List<int> campaignsIdList = new List<int>();
            List<string> keys = new List<string>(this.campaigns.Keys);
            for (int i = 0; i < keys.Count; i++)
            {
                campaignsIdList.Add(Int32.Parse(keys[i].Split(' ')[0]));
            }
            return campaignsIdList;
        }

        /// <summary>
        /// Gets the list of the names for the specified campaign ID (a campaign can have more than one name).
        /// </summary>
        /// <returns>
        /// The list of the names for the specified campaign ID (a campaign can have more than one name).
        /// </returns>
        /// <param name='campaignId'>
        /// Campaign ID.
        /// </param>
        public List<string> getCampaignNames(int campaignId)
        {
            List<string> campaignsName = new List<string>();
            List<string> keys = new List<string>(this.campaigns.Keys);
            int totalLength = 0;
            int idLength = 0;
            int length;
            for (int i = 0; i < keys.Count; i++)
            {
                if (campaignId.Equals(Int32.Parse(keys[i].Split(' ')[0])))
                    totalLength = keys[i].Length;
                idLength = ((keys[i].Split(' ')[0]).Length + 1);
                length = totalLength - idLength;
                campaignsName.Add(keys[i].Substring(idLength, length));
            }
            return campaignsName;
        }

        /// <summary>
        /// Gets the list of the transactions ID for the specified campaign ID.
        /// </summary>
        /// <returns>
        /// The list of the transactions ID for the specified campaign ID.
        /// </returns>
        /// <param name='campaignId'>
        /// Campaign ID.
        /// </param>
        public List<int> getTransactionsIdListFrom(int campaignId)
        {
            List<int> transactionsIdList = new List<int>();
            List<string> keys = new List<string>(this.campaigns.Keys);
            List<int> tmp;
            for (int i = 0; i < keys.Count; i++)
            {
                if (campaignId.Equals(Int32.Parse(keys[i].Split(' ')[0])))
                {
                    tmp = new List<int>(this.campaigns[keys[i]].Keys);
                    foreach (int k in tmp)
                    {
                        transactionsIdList.Add(k);
                    }
                }
            }
            return transactionsIdList;
        }

        /// <summary>
        /// Gets the value for the specified key.
        /// </summary>
        /// <returns>
        /// The value for the specified key.
        /// </returns>
        /// <param name='campaignId'>
        /// Campaign ID.
        /// </param>
        /// <param name='transactionId'>
        /// Transaction ID.
        /// </param>
        /// <param name='key'>
        /// Key.
        /// </param>
        public string getValue(int campaignId, int transactionId, string key)
        {
            List<string> keys = new List<string>(this.campaigns.Keys);
            for (int i = 0; i < keys.Count; i++)
            {
                if (campaignId.Equals(Int32.Parse(keys[i].Split(' ')[0])))
                {
                    if (!(this.campaigns[keys[i]][transactionId].Equals(null)))
                        return this.campaigns[keys[i]][transactionId][key];
                }
            }
            return null;
        }

        /// <summary>
        /// Gets the hash.
        /// </summary>
        /// <returns>
        /// The hash corresponding to the specified campaign ID and transaction ID.
        /// Null if the campaign ID or the transaction ID does not exist.
        /// </returns>
        /// <param name='campaignId'>
        /// Campaign ID.
        /// </param>
        /// <param name='transactionId'>
        /// Transaction ID.
        /// </param>
        public string getHash(int campaignId, int transactionId)
        {
            return getValue(campaignId, transactionId, "hash");
        }

        /// <summary>
        /// Gets the datestamp.
        /// </summary>
        /// <returns>
        /// The datestamp corresponding to the specified campaign ID and transaction ID. 
        /// Null if the campaign ID or the transaction ID does not exist.
        /// </returns>
        /// <param name='campaignId'>
        /// Campaign ID.
        /// </param>
        /// <param name='transactionId'>
        /// Transaction ID.
        /// </param>
        public string getDatestamp(int campaignId, int transactionId)
        {
            return getValue(campaignId, transactionId, "datestamp");
        }

        /// <summary>
        /// Gets the sender's number
        /// </summary>
        /// <returns>
        /// The sender's number corresponding to the specified campaign ID and transaction ID.
        /// Null if the campaign ID or the transaction ID does not exist.
        /// </returns>
        /// <param name='campaignId'>
        /// Campaign ID.
        /// </param>
        /// <param name='transactionId'>
        /// Transaction ID.
        /// </param>
        public string getFromNumber(int campaignId, int transactionId)
        {
            return getValue(campaignId, transactionId, "from_number");
        }

        /// <summary>
        /// Gets the sender's name
        /// </summary>
        /// <returns>
        /// The sender's name corresponding to the specified campaign ID and transaction ID.
        /// Null if the campaign ID or the transaction ID does not exist.
        /// </returns>
        /// <param name='campaignId'>
        /// Campaign ID.
        /// </param>
        /// <param name='transactionId'>
        /// Transaction ID.
        /// </param>
        public string getFromName(int campaignId, int transactionId)
        {
            return getValue(campaignId, transactionId, "from_name");
        }

        /// <summary>
        /// Gets the receiver's number
        /// </summary>
        /// <returns>
        /// The receiver's number corresponding to the specified campaign ID and transaction ID.
        /// Null if the campaign ID or the transaction ID does not exist.
        /// </returns>
        /// <param name='campaignId'>
        /// Campaign ID.
        /// </param>
        /// <param name='transactionId'>
        /// Transaction ID.
        /// </param>
        public string getToNumber(int campaignId, int transactionId)
        {
            return getValue(campaignId, transactionId, "to_number");
        }

        /// <summary>
        /// Gets the receiver's name
        /// </summary>
        /// <returns>
        /// The receiver's name corresponding to the specified campaign ID and transaction ID.
        /// Null if the campaign ID or the transaction ID does not exist.
        /// </returns>
        /// <param name='campaignId'>
        /// Campaign ID.
        /// </param>
        /// <param name='transactionId'>
        /// Transaction ID.
        /// </param>
        public string getToName(int campaignId, int transactionId)
        {
            return getValue(campaignId, transactionId, "to_name");
        }
    }
}
