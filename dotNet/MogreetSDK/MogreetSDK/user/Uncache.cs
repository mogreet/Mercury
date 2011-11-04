using System;
using System.Xml;
using System.Security;
using System.Collections.Generic;

namespace MogreetSDK.user
{
    /// <summary>
    /// The Uncache object contains the response from an <see cref="MogreetSDK.Mercury.uncache"/> request to the Moms API.
    /// </summary>
    /// <exception cref='Exception'>
    /// Represents errors that occur during application execution.
    /// </exception>
    public class Uncache : Response
    {
        private string number;

        /// <summary>
        /// Initializes a new instance of the <see cref="SDK.Uncache"/> class.
        /// </summary>
        /// <param name='xmlDoc'>
        /// Xml document that is returned by all the requests.
        /// </param>
        /// <exception cref='Exception'>
        /// Represents errors that occur during application execution.
        /// </exception>
        public Uncache(XmlDocument xmlDoc)
            : base(xmlDoc)
        {
            if (!(base.responseIsValid()))
                throw new Exception(base.getMessage());
            try
            {
                XmlNode numr = mXmlDoc.SelectSingleNode("//response/number/text()");
                this.number = numr.Value;
                Console.WriteLine("number: " + this.number);
            }
            catch (XmlException e)
            {
                throw new Exception("\nAn error occured while parsing the XML data for the UNCACHE call: " + e.Message);
            }
        }

        /// <summary>
        /// Gets the number of the uncached phone.
        /// </summary>
        /// <returns>
        /// The number of the uncached phone.
        /// </returns>
        public string getNumber()
        {
            return this.number;
        }
    }
}
