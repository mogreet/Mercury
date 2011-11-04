using System;
using System.Xml;

namespace MogreetSDK
{
    /// <summary>
    /// Response is the super class for all the kind of responses that can be obtained from the Moms API requests.
    /// It contains common methods for the subclasses.
    /// </summary>

    public class Response
    {
        protected XmlDocument mXmlDoc;
        protected int mResponseCode;
        protected string mResponseStatus;
        protected string mMessage;

        /// <summary>
        /// Constructs a new Response object.
        /// </summary>
        /// <param name="xmlDoc">XML document that is returned by all the requests.</param>
        public Response(XmlDocument xmlDoc)
        {
            mXmlDoc = xmlDoc;
            setResponseCodeStatusMessage();
        }

        /// <summary>
        /// Sets the response code status message using XmlReader to parse de XML Document
        /// </summary>
        /// <exception cref='Exception'>
        /// Represents errors that occur during application execution.
        /// </exception>
        private void setResponseCodeStatusMessage()
        {
            try
            {
                // Creates XML Reader
                XmlNode code = mXmlDoc.SelectSingleNode("//response/@code");
                mResponseCode = Int32.Parse(code.InnerText);
                Console.WriteLine("code: " + mResponseCode);

                XmlNode status = mXmlDoc.SelectSingleNode("//response/@status");
                mResponseStatus = status.Value;
                Console.WriteLine("status: " + mResponseStatus);

                XmlNode message = mXmlDoc.SelectSingleNode("//response/message/text()");
                mMessage = message.Value;
                Console.WriteLine("message: " + mMessage);

            }
            catch (Exception e)
            {
                throw new Exception("\nAn error occured while getting the response code, status and message: " + e.Message);
            }
        }
        /// <summary>
        /// Checks if the response code is 1.
        /// </summary>
        /// <returns>
        /// True if the response code is 1, false if it is not.
        /// </returns>
        protected bool responseIsValid()
        {
            if (Equals(mResponseCode, 1))
                return true;
            return false;
        }
        /// <summary>
        /// Gets the message.
        /// </summary>
        /// <returns>
        /// The message.
        /// </returns>
        public string getMessage()
        {
            return mMessage;
        }

        /// <summary>
        /// Gets the response code.
        /// </summary>
        /// <returns>
        /// The response code.
        /// </returns>
        public int getResponseCode()
        {
            return this.mResponseCode;
        }

        /// <summary>
        /// Gets the response status.
        /// </summary>
        /// <returns>
        /// The response status.
        /// </returns>
        public string getResponseStatus()
        {
            return this.mResponseStatus;
        }

        /// <summary>
        /// Gets the response message.
        /// </summary>
        /// <returns>
        /// The response message.
        /// </returns>
        public string getResponseMessage()
        {
            return this.mMessage;
        }
    }
}
