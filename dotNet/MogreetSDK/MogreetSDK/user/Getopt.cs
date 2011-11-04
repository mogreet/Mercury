using System;
using System.Xml;
using System.Security;
using System.Collections.Generic;

namespace MogreetSDK.user
{
    /// <summary>
    /// The Getopt object contains the response from a <see cref="MogreetSDK.Mercury.getopt"/> request to the Moms API.
    /// </summary>
    /// <exception cref='Exception'>
    /// Represents errors that occur during application execution.
    /// </exception>
    public class Getopt : Response
    {
        private Dictionary<int, Dictionary<string, string>> campaigns;
        private int campaignId;
        private string code;
        private string status = "";

        /// <summary>
        /// Initializes a new instance of the <see cref="SDK.Getopt"/> class.
        /// </summary>
        /// <param name='xmlDoc'>
        /// Xml document that is returned by all the requests.
        /// </param>
        /// <exception cref='Exception'>
        /// Represents errors that occur during application execution.
        /// </exception>
        public Getopt(XmlDocument xmlDoc)
            : base(xmlDoc)
        {
            if (!(base.responseIsValid()))
                throw new Exception(base.getMessage());
            try
            {

                XmlNodeList nodes = mXmlDoc.SelectNodes("//response/campaign");
                this.campaigns = new Dictionary<int, Dictionary<string, string>>();

                for (int i = 0; i < nodes.Count; i++)
                {
                    //recovers attributes
                    campaignId = Int32.Parse((nodes.Item(i).Attributes.Item(0)).InnerText);
                    code = (nodes.Item(i).FirstChild.Attributes.Item(0)).Value;
                    status = nodes.Item(i).InnerText;

                    //inserts elements in Dictionarys
                    Dictionary<string, string> campaignsDic = new Dictionary<string, string>();
                    campaignsDic.Add(code, status);
                    this.campaigns.Add(campaignId, campaignsDic);

                    //prints elements
                    Console.WriteLine("campaignId: " + campaignId);
                    Console.WriteLine("code: " + code);
                    Console.WriteLine("status: " + status);
                }

                getCampaignIdList();
                Console.WriteLine(getCampaignStatusCode(10655));
                Console.WriteLine(getCampaignStatus(10655));


            }
            catch (XmlException e)
            {
                throw new Exception("\nAn error occured while parsing the XML data for the GETOPT call: " + e.Message);
            }
        }

        /// <summary>
        /// Gets the list of all the campaigns id.
        /// </summary>
        /// <returns>
        /// The list of all the campaigns id.
        /// </returns>
        public List<int> getCampaignIdList()
        {
            List<int> campaignsIdList = new List<int>(this.campaigns.Keys);
            return campaignsIdList;
        }

        /// <summary>
        /// Gets the campaign status code.
        /// </summary>
        /// <returns>
        /// The status code of the specified campaign.
        /// 0 if the specified campaign ID does not exist.
        /// </returns>
        /// <param name='campaignId'>
        /// Campaign ID.
        /// </param>
        public int getCampaignStatusCode(int campaignId)
        {
            if (this.campaigns.ContainsKey(campaignId))
            {
                foreach (var pair in campaigns[campaignId])
                    return Int32.Parse(pair.Key);
            }
            return 0;
        }

        /// <summary>
        /// Gets the campaign status.
        /// </summary>
        /// <returns>
        /// The status label of the specified campaign.
        /// Null if the specified campaign ID does not exist.
        /// </returns>
        /// <param name='campaignId'>
        /// Campaign ID.
        /// </param>
        public string getCampaignStatus(int campaignId)
        {
            if (this.campaigns.ContainsKey(campaignId))
            {
                foreach (var pair in campaigns[campaignId])
                    return pair.Value;
            }
            return null;
        }
    }
}
