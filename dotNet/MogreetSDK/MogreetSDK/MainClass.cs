using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MogreetSDK
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            int clientId = 536;
            string token = "102ed2ad568f913a31aeace02eeae234";
            Mercury myM = new Mercury(clientId, token);
            myM.ping();
            Dictionary<string, string> parameters = new Dictionary<string, string>();
            //params.Add ("message_id","34975512");
            //params.Add("hash","ppsvchee");
            //myM.lookup(params);


            //parameters.Add("campaign_id", "10651");
            //parameters.Add("to", "7752171448");
            //parameters.Add("from", "7752171448");
            //parameters.Add("message", "Hello, World!");
            //parameters.Add("content_id", "4321");
            //myM.send(parameters);

            parameters.Add("number", "7752171448");
            myM.uncache(parameters);

            //parameters.Add("number", "7752171448");
            //parameters.Add("campaign_id", "10651");
            //parameters.Add("status_code", "1");
            //myM.setopt(parameters);

            Console.WriteLine("Hello World!");
        }
    }
}
