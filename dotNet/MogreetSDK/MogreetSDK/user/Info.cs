using System;
using System.Xml;
using System.Security;
using System.Collections.Generic;

namespace MogreetSDK.user
{
    /// <summary>
    /// The Info object contains the response from an <see cref="MogreetSDK.Mercury.info"/> request to the Moms API.
    /// </summary>
    /// <exception cref='Exception'>
    /// Represents errors that occur during application execution.
    /// </exception>
    public class Info : Response
    {
        private string number;
        private int carrierId;
        private string carrier;
        private int handsetId;
        private string handset;

        /// <summary>
        /// Initializes a new instance of the <see cref="SDK.Info"/> class.
        /// </summary>
        /// <param name='xmlDoc'>
        /// Xml document that is returned by all the requests.
        /// </param>
        /// <exception cref='Exception'>
        /// Represents errors that occur during application execution.
        /// </exception>
        public Info(XmlDocument xmlDoc)
            : base(xmlDoc)
        {
            if (!(base.responseIsValid()))
                throw new Exception(base.getMessage());
            try
            {
                // Creates XML Reader
                XmlNode numr = mXmlDoc.SelectSingleNode("//response/number/text()");
                this.number = numr.Value;
                Console.WriteLine("number: " + this.number);

                XmlNode caridr = mXmlDoc.SelectSingleNode("//response/carrier/@id");
                this.carrierId = Int32.Parse(caridr.InnerText);
                Console.WriteLine("carrierId: " + this.carrierId);

                XmlNode carr = mXmlDoc.SelectSingleNode("//response/carrier/text()");
                this.carrier = carr.Value;
                Console.WriteLine("carrier: " + this.carrier);

                XmlNode hsidr = mXmlDoc.SelectSingleNode("//response/handset/@id");
                this.handsetId = Int32.Parse(hsidr.InnerText);
                Console.WriteLine("handsetId: " + this.handsetId);

                XmlNode hsr = mXmlDoc.SelectSingleNode("//response/handset/text()");
                this.handset = hsr.Value;
                Console.WriteLine("handset: " + this.handset);

            }
            catch (XmlException e)
            {
                throw new Exception("\nAn error occured while parsing the XML data for the INFO call: " + e.Message);
            }
        }

        /// <summary>
        /// Gets the number.
        /// </summary>
        /// <returns>
        /// The requested number.
        /// </returns>
        public string getNumber()
        {
            return this.number;
        }

        /// <summary>
        /// Gets the carrier identifier.
        /// </summary>
        /// <returns>
        /// The carrier ID for the requested number.
        /// </returns>
        public int getCarrierId()
        {
            return this.carrierId;
        }

        /// <summary>
        /// Gets the carrier.
        /// </summary>
        /// <returns>
        /// The carrier name for the requested number.
        /// </returns>
        public string getCarrier()
        {
            return this.carrier;
        }

        /// <summary>
        /// Gets the handset identifier.
        /// </summary>
        /// <returns>
        /// The handset ID for the requested number.
        /// </returns>
        public int getHandsetId()
        {
            return this.handsetId;
        }

        /// <summary>
        /// Gets the handset.
        /// </summary>
        /// <returns>
        /// The handset name for the requested name.
        /// </returns>
        public string getHandset()
        {
            return this.handset;
        }
    }
}
