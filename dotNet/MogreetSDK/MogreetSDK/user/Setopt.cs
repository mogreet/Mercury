using System;
using System.Xml;
using System.Security;
using System.Collections.Generic;

namespace MogreetSDK.user
{
    /// <summary>
    /// The Setopt object contains the response from a <see cref="MogreetSDK.Mercury.setopt"/> request to the Moms API.
    /// </summary>
    /// <exception cref='Exception'>
    /// Represents errors that occur during application execution.
    /// </exception>
    public class Setopt : Response
    {

        private int campaignId;
        private int campaignStatusCode;
        private string campaignStatus;

        /// <summary>
        /// Initializes a new instance of the <see cref="SDK.Setopt"/> class.
        /// </summary>
        /// <param name='xmlDoc'>
        /// Xml document that is returned by all the requests.
        /// </param>
        /// <exception cref='Exception'>
        /// Represents errors that occur during application execution.
        /// </exception>
        public Setopt(XmlDocument xmlDoc)
            : base(xmlDoc)
        {
            if (!(base.responseIsValid()))
                throw new Exception(base.getMessage());
            try
            {
                // Creates XML Reader
                XmlNode camid = mXmlDoc.SelectSingleNode("//response/campaign/@id");
                this.campaignId = Int32.Parse(camid.InnerText);
                Console.WriteLine("campaignId: " + this.campaignId);

                XmlNode camstc = mXmlDoc.SelectSingleNode("//response/campaign/status/@code");
                this.campaignStatusCode = Int32.Parse(camstc.InnerText);
                Console.WriteLine("campaignStatusCode: " + this.campaignStatusCode);

                XmlNode camst = mXmlDoc.SelectSingleNode("//response/campaign/status/text()");
                this.campaignStatus = camst.Value;
                Console.WriteLine("campaignStatus: " + this.campaignStatus);

            }
            catch (XmlException e)
            {
                throw new Exception("\nAn error occured while parsing the XML data for the SETOPT call: " + e.Message);
            }
        }

        /// <summary>
        /// Gets the campaign identifier.
        /// </summary>
        /// <returns>
        /// The campaign identifier.
        /// </returns>
        public int getCampaignId()
        {
            return this.campaignId;
        }

        /// <summary>
        /// Gets the campaign status code.
        /// </summary>
        /// <returns>
        /// The campaign status code.
        /// </returns>
        public int getCampaignStatusCode()
        {
            return this.campaignStatusCode;
        }

        /// <summary>
        /// Gets the campaign status label.
        /// </summary>
        /// <returns>
        /// The campaign status label.
        /// </returns>
        public string getCampaignStatus()
        {
            return this.campaignStatus;
        }
    }
}
