using System;
using System.Xml;
using System.Security;

namespace MogreetSDK.system
{
    /// <summary>
    /// The Ping object contains the response from a <see cref="MogreetSDK.Mercury.ping"/> request to the Moms API.
    /// </summary>
    public class Ping : Response
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="SDK.Ping"/> class.
        /// </summary>
        /// <param name='xmlDoc'>
        /// Xml document that is returned by all the requests.
        /// </param>
        /// <exception cref='Exception'>
        /// Represents errors that occur during application execution.
        /// </exception>
        public Ping(XmlDocument xmlDoc)
            : base(xmlDoc)
        {
            if (!(base.responseIsValid()))
                throw new Exception(base.getMessage());
        }
    }
}
