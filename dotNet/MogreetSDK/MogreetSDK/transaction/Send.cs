using System;
using System.Xml;
using System.Security;
using System.Collections.Generic;

namespace MogreetSDK.transaction
{
    /// <summary>
    /// The Send object contains the response from a <see cref="MogreetSDK.Mercury.send"/> request to the Moms API.
    /// </summary>
    /// <exception cref='Exception'>
    /// Represents errors that occur during application execution.
    /// </exception>
    public class Send : Response
    {
        private int messageId;
        private string hash;

        /// <summary>
        /// Initializes a new instance of the <see cref="SDK.Send"/> class.
        /// </summary>
        /// <param name='xmlDoc'>
        /// Xml document that is returned by all the requests.
        /// </param>
        /// <exception cref='Exception'>
        /// Represents errors that occur during application execution.
        /// </exception>
        public Send(XmlDocument xmlDoc)
            : base(xmlDoc)
        {
            if (!(base.responseIsValid()))
                throw new Exception(base.getMessage());
            try
            {
                // Creates XML Reader
                XmlNode messr = mXmlDoc.SelectSingleNode("//response/message_id/text()");
                this.messageId = Int32.Parse(messr.InnerText);
                Console.WriteLine("messageId: " + this.messageId);

                XmlNode hashr = mXmlDoc.SelectSingleNode("//response/hash/text()");
                this.hash = hashr.Value;
                Console.WriteLine("hash: " + this.hash);

            }
            catch (XmlException e)
            {
                throw new Exception("\nAn error occured while parsing the XML data for the SEND call: " + e.Message);
            }

        }

        /// <summary>
        /// Gets the message identifier.
        /// </summary>
        /// <returns>
        /// The message identifier.
        /// </returns>
        public int getMessageId()
        {
            return this.messageId;
        }

        /// <summary>
        /// Gets the hash.
        /// </summary>
        /// <returns>
        /// The hash.
        /// </returns>
        public string getHash()
        {
            return this.hash;
        }
    }
}
