using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MogreetSDK;
using MogreetSDK.system;
using MogreetSDK.transaction;
using MogreetSDK.user;
using SDKApplication.Models;

namespace SDKApplication.Controllers
{
    /// <summary>
    /// Home controller.
    /// </summary>
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        private static Mercury myM;

        // init allow us to know if we have created a Mercury object or not
        private static int init = 0;
        public static int Init
        {
            get
            {
                return init;
            }
            set
            {
                init = value;
            }
        }
        
        /// <summary>
        /// Index the specified tabView, pingModel, mercuryID, pingID, sendID, lookupID, getoptID, setoptID, uncacheID,
        /// infoID, transactionsID, clientId, token, campaignId, from, messageSend, to, contentId, toName, fromName, udp,
        /// messageIdL, hashL, numberGetopt, campaignIdGetopt, numberSetopt, campaignIdSetopt, statusCodeSetopt,
        /// numberUncache, numberInfo, numberTrans, campaignIdTrans, startDateTrans and endDateTrans.
        /// </summary>
        /// <param name='tabView'>
        /// Tab view.
        /// </param>
        /// <param name='mercuryID'>
        /// Mercury I.
        /// </param>
        /// <param name='pingID'>
        /// Ping I.
        /// </param>
        /// <param name='sendID'>
        /// Send I.
        /// </param>
        /// <param name='lookupID'>
        /// Lookup I.
        /// </param>
        /// <param name='getoptID'>
        /// Getopt I.
        /// </param>
        /// <param name='setoptID'>
        /// Setopt I.
        /// </param>
        /// <param name='uncacheID'>
        /// Uncache I.
        /// </param>
        /// <param name='infoID'>
        /// Info I.
        /// </param>
        /// <param name='transactionsID'>
        /// Transactions I.
        /// </param>
        /// <param name='clientId'>
        /// Client identifier.
        /// </param>
        /// <param name='token'>
        /// Token.
        /// </param>
        /// <param name='campaignId'>
        /// Campaign identifier.
        /// </param>
        /// <param name='from'>
        /// From.
        /// </param>
        /// <param name='messageSend'>
        /// Message send.
        /// </param>
        /// <param name='to'>
        /// To.
        /// </param>
        /// <param name='contentId'>
        /// Content identifier.
        /// </param>
        /// <param name='toName'>
        /// To name.
        /// </param>
        /// <param name='fromName'>
        /// From name.
        /// </param>
        /// <param name='udp'>
        /// UDP.
        /// </param>
        /// <param name='messageIdL'>
        /// Message identifier l.
        /// </param>
        /// <param name='hashL'>
        /// Hash l.
        /// </param>
        /// <param name='numberGetopt'>
        /// Number getopt.
        /// </param>
        /// <param name='campaignIdGetopt'>
        /// Campaign identifier getopt.
        /// </param>
        /// <param name='numberSetopt'>
        /// Number setopt.
        /// </param>
        /// <param name='campaignIdSetopt'>
        /// Campaign identifier setopt.
        /// </param>
        /// <param name='statusCodeSetopt'>
        /// Status code setopt.
        /// </param>
        /// <param name='numberUncache'>
        /// Number uncache.
        /// </param>
        /// <param name='numberInfo'>
        /// Number info.
        /// </param>
        /// <param name='numberTrans'>
        /// Number trans.
        /// </param>
        /// <param name='campaignIdTrans'>
        /// Campaign identifier trans.
        /// </param>
        /// <param name='startDateTrans'>
        /// Start date trans.
        /// </param>
        /// <param name='endDateTrans'>
        /// End date trans.
        /// </param>
        public ActionResult Index(tabViewModel tabView, string mercuryID, string pingID, string sendID, string lookupID, string getoptID,
            string setoptID, string uncacheID, string infoID, string transactionsID, string clientId, string token, string campaignId,
            string from, string messageSend, string to, string contentId, string toName, string fromName, string udp, string messageIdL,
            string hashL, string numberGetopt, string campaignIdGetopt, string numberSetopt, string campaignIdSetopt, string statusCodeSetopt,
            string numberUncache, string numberInfo, string numberTrans, string campaignIdTrans, string startDateTrans, string endDateTrans)
        {
            //initialise first tab at mercury tab
            ViewData["tabID"] = 0;
            //disable tabs if a Mercury object hasn't been created yet
            ViewData["init"] = Init;
            //current tab
            int selectTab = 0;

            // we are in mercury tab
            if (mercuryID != null)
            {
                selectTab = 0;
                if (!Validate_mercury(clientId, token))
                {
                    ViewData["tabID"] = selectTab;
                    return View(tabView);
                }
                //Creates Mercury
                myM = new Mercury(Int32.Parse(clientId), token);
                ViewData["mercury"] = "A new Mercury object has been created";
                ViewData["tabID"] = selectTab;
                //enable other tabs
                Init = 1;
                ViewData["init"] = Init;
                return View(tabView);

            }
            //we are in ping tab
            if (pingID != null)
            {
                selectTab = 1;
                //Ping request
                Ping ping = myM.ping();
                //Prints elements
                ViewData["code"] = "code: " + ping.getResponseCode();
                ViewData["status"] = "status: " + ping.getResponseStatus();
                ViewData["message"] = "message: " + ping.getResponseMessage();
                ViewData["tabID"] = selectTab;
                return View(tabView);

            }

            //we are in send tab
            if (sendID != null)
            {
                selectTab = 2;
                if (!Validate_send(campaignId, from, messageSend, to))
                {
                    ViewData["tabID"] = selectTab;
                    return View(tabView);
                }
                //Creates Dictionary (request parameter)
                Dictionary<String, String> parameters = new Dictionary<String, String>();
                parameters.Add("campaign_id", campaignId);
                parameters.Add("to", to);
                parameters.Add("from", from);
                parameters.Add("message", messageSend);
                if (contentId != null)
                    parameters.Add("content_id", contentId);
                if (toName != null)
                    parameters.Add("to_name", toName);
                if (fromName != null)
                    parameters.Add("from_name", fromName);
                if (udp != null)
                    parameters.Add("udp_*", udp);

                //Send request
                Send send = myM.send(parameters);
                //Prints elements
                ViewData["codeSend"] = "code: " + send.getResponseCode();
                ViewData["statusSend"] = "status: " + send.getResponseStatus();
                ViewData["messageRSend"] = "message: " + send.getResponseMessage();
                ViewData["hashSend"] = "code: " + send.getHash();
                ViewData["messageIdSend"] = "message ID: " + send.getMessageId();
                ViewData["tabID"] = selectTab;
                return View(tabView);
            }

            //we are in lookup tab
            if (lookupID != null)
            {
                selectTab = 3;
                if (!Validate_lookup(messageIdL, hashL))
                {
                    ViewData["tabID"] = selectTab;
                    return View(tabView);
                }
                //Creates Dictionary (request parameter)
                Dictionary<String, String> parameters = new Dictionary<String, String>();
                parameters.Add("message_id", messageIdL);
                parameters.Add("hash", hashL);

                //Lookup request
                Lookup lookup = myM.lookup(parameters);

                //Prints elements
                ViewData["codeL"] = "code: " + lookup.getResponseCode();
                ViewData["statusRL"] = "status: " + lookup.getResponseStatus();
                ViewData["messageL"] = "message: " + lookup.getResponseMessage();
                ViewData["campaignIdL"] = "campaign ID: " + lookup.getCampaignId();
                ViewData["fromL"] = "from: " + lookup.getFromNumber();
                ViewData["fromNameL"] = "from name: " + lookup.getFromName();
                ViewData["toL"] = "to: " + lookup.getToNumber();
                ViewData["toNameL"] = "to name: " + lookup.getToName();
                ViewData["contentIdL"] = "content ID: " + lookup.getContentId();
                ViewData["statusL"] = "status: " + lookup.getStatus();
                List<string> list = lookup.getEventsList();
                List<string> listimestamp = lookup.getTimestampList();
                List<string> eventslist = new List<string>();
                int k = 0;
                for (int i = 0; i < listimestamp.Count; i++)
                {
                    for (int j = 0; j < lookup.getEvents(listimestamp[i]).Count; j++)
                    {
                        eventslist.Add("timestamp :" + listimestamp[i] + " -> " + list[k]);
                        k++;
                    }
                }
                ViewData["events"] = eventslist;
                ViewData["tabID"] = selectTab;
                return View(tabView);

            }

            //we are in getopt tab
            if (getoptID != null)
            {
                selectTab = 4;
                if (!Validate_getopt(numberGetopt))
                {
                    ViewData["tabID"] = selectTab;
                    return View(tabView);
                }
                //Creates Dictionary (request parameter)
                Dictionary<String, String> parameters = new Dictionary<String, String>();
                parameters.Add("number", numberGetopt);
                if (campaignIdGetopt != null)
                    parameters.Add("campaign_id", campaignIdGetopt);

                //Getopt request
                Getopt getopt = myM.getopt(parameters);

                //Prints elements
                ViewData["codeGetopt"] = "code: " + getopt.getResponseCode();
                ViewData["statusGetopt"] = "status: " + getopt.getResponseStatus();
                ViewData["messageGetopt"] = "message: " + getopt.getResponseMessage();

                List<int> list = getopt.getCampaignIdList();
                List<string> campaigns = new List<string>();
                for (int i = 0; i < list.Count; i++)
                {
                    campaigns.Add("campaign id:" + list[i] + " status code: " + 
                    getopt.getCampaignStatusCode(list[i]) + " -> " + getopt.getCampaignStatus(list[i]));
                }

                ViewData["campaignsGetopt"] = campaigns;
                ViewData["tabID"] = selectTab;
                return View(tabView);

            }

            //we are in setopt tab
            if (setoptID != null)
            {
                selectTab = 5;
                if (!Validate_setopt(numberSetopt, campaignIdSetopt, statusCodeSetopt))
                {
                    ViewData["tabID"] = selectTab;
                    return View(tabView);
                }
                //Creates Dictionary (request parameter)
                Dictionary<String, String> parameters = new Dictionary<String, String>();
                parameters.Add("number", numberSetopt);
                parameters.Add("campaign_id", campaignIdSetopt);
                parameters.Add("status_code", statusCodeSetopt);

                //Getopt request
                Setopt setopt = myM.setopt(parameters);

                //Prints elements
                ViewData["codeSetopt"] = "code: " + setopt.getResponseCode();
                ViewData["statusRSetopt"] = "status: " + setopt.getResponseStatus();
                ViewData["messageSetopt"] = "message: " + setopt.getResponseMessage();
                ViewData["campaignIdSetopt"] = "campaignId: " + setopt.getCampaignId();
                ViewData["statusCodeSetopt"] = "status code: " + setopt.getCampaignStatusCode();
                ViewData["statusSetopt"] = "status: " + setopt.getResponseStatus();
                ViewData["tabID"] = selectTab;
                return View(tabView);

            }
            //we are in uncache tab
            if (uncacheID != null)
            {
                selectTab = 6;
                if (!Validate_uncache(numberUncache))
                {
                    ViewData["tabID"] = selectTab;
                    return View(tabView);
                }
                //Creates Dictionary (request parameter)
                Dictionary<String, String> parameters = new Dictionary<String, String>();
                parameters.Add("number", numberUncache);

                //Uncache request
                Uncache uncache = myM.uncache(parameters);

                //Prints elements
                ViewData["codeUncache"] = "code: " + uncache.getResponseCode();
                ViewData["statusUncache"] = "status: " + uncache.getResponseStatus();
                ViewData["messageUncache"] = "message: " + uncache.getResponseMessage();
                ViewData["numberUncache"] = "number: " + uncache.getNumber();
                ViewData["tabID"] = selectTab;
                return View(tabView);

            }

            //we are in info tab
            if (infoID != null)
            {
                selectTab = 7;
                if (!Validate_info(numberInfo))
                {
                    ViewData["tabID"] = selectTab;
                    return View(tabView);
                }
                //Creates Dictionary (request parameter)
                Dictionary<String, String> parameters = new Dictionary<String, String>();
                parameters.Add("number", numberInfo);

                //Uncache request
                Info info = myM.info(parameters);

                //Prints elements
                ViewData["codeInfo"] = "code: " + info.getResponseCode();
                ViewData["statusInfo"] = "status: " + info.getResponseStatus();
                ViewData["messageInfo"] = "message: " + info.getResponseMessage();
                ViewData["numberInfo"] = "number: " + info.getNumber();
                ViewData["carrierIdInfo"] = "carrier Id: " + info.getCarrierId();
                ViewData["carrierInfo"] = "carrier : " + info.getCarrier();
                ViewData["handsetIdInfo"] = "handset Id: " + info.getHandsetId();
                ViewData["handsetInfo"] = "handset: " + info.getHandset();
                ViewData["tabID"] = selectTab;
                return View(tabView);

            }

            //we are in transactions tab
            if (transactionsID != null)
            {
                selectTab = 8;
                if (!Validate_transactions(numberTrans))
                {
                    ViewData["tabID"] = selectTab;
                    return View(tabView);
                }
                //Creates Dictionary (request parameter)
                Dictionary<String, String> parameters = new Dictionary<String, String>();
                parameters.Add("number", numberTrans);
                if (campaignIdTrans != null)
                    parameters.Add("campaign_id", campaignIdTrans);
                if (startDateTrans != null)
                    parameters.Add("start_date", startDateTrans);
                if (endDateTrans != null)
                    parameters.Add("end_date", endDateTrans);

                //Transactions request
                Transactions transactions = myM.transactions(parameters);

                //Prints elements
                ViewData["codeTrans"] = "code: " + transactions.getResponseCode();
                ViewData["statusTrans"] = "status: " + transactions.getResponseStatus();
                ViewData["messageTrans"] = "message: " + transactions.getResponseMessage();

                List<int> list = transactions.getCampaignsIdList();
                List<string> transactionsListOut = new List<string>();
                List<int> transactionsList = new List<int>();
                for (int i = 0; i < list.Count; i++)
                {
                    transactionsList = transactions.getTransactionsIdListFrom(list[i]);
                    for (int j = 0; j < transactionsList.Count; j++)
                        transactionsListOut.Add("campaign id:" + list[i] + " name: " + transactions.getCampaignNames(list[i])[i] + " -> transactions datestamp: "
                        + transactions.getValue(list[i], transactions.getTransactionsIdListFrom(list[i])[j], "datestamp") + " hash: " +
                        transactions.getValue(list[i], transactions.getTransactionsIdListFrom(list[i])[j], "hash") + " message id: " +
                        transactions.getTransactionsIdListFrom(list[i])[j] + " -> from number: " + transactions.getValue(list[i], transactions.getTransactionsIdListFrom(list[i])[j], "from_number")
                        + " from name: " + transactions.getValue(list[i], transactions.getTransactionsIdListFrom(list[i])[j], "from_name")
                        + " to number:" + transactions.getValue(list[i], transactions.getTransactionsIdListFrom(list[i])[j], "to_number")
                        + " to name: " + transactions.getValue(list[i], transactions.getTransactionsIdListFrom(list[i])[j], "to_name"));
                }

                ViewData["transactions"] = transactionsListOut;
                ViewData["tabID"] = selectTab;
                return View(tabView.ID);

            }
            return View(tabView.ID);

        }

        /// <summary>
        /// Validate_mercury the specified clientId and token.
        /// </summary>
        /// <param name='clientId'>
        /// If set to <c>true</c> client identifier.
        /// </param>
        /// <param name='token'>
        /// If set to <c>true</c> token.
        /// </param>
        private bool Validate_mercury(string clientId, string token)
        {
            if (String.IsNullOrEmpty(clientId))
            {
                ModelState.AddModelError("clientId", "You must specify a client Id.");
            }
            if (String.IsNullOrEmpty(token))
            {
                ModelState.AddModelError("token", "You must specify a token.");
            }

            return ModelState.IsValid;
        }

        /// <summary>
        /// Validate_send the specified campaignId, from, messageSend and to.
        /// </summary>
        /// <param name='campaignId'>
        /// If set to <c>true</c> campaign identifier.
        /// </param>
        /// <param name='from'>
        /// If set to <c>true</c> from.
        /// </param>
        /// <param name='messageSend'>
        /// If set to <c>true</c> message.
        /// </param>
        /// <param name='to'>
        /// If set to <c>true</c> to.
        /// </param>
        private bool Validate_send(string campaignId, string from, string messageSend, string to)
        {
            if (String.IsNullOrEmpty(campaignId))
            {
                ModelState.AddModelError("campaignId", "You must specify a campaign Id.");
            }
            if (String.IsNullOrEmpty(from))
            {
                ModelState.AddModelError("from", "You must specify a from.");
            }
            if (String.IsNullOrEmpty(messageSend))
            {
                ModelState.AddModelError("messageSend", "You must specify a message.");
            }
            if (String.IsNullOrEmpty(to))
            {
                ModelState.AddModelError("to", "You must specify a to.");
            }

            return ModelState.IsValid;
        }

        /// <summary>
        /// Validate_lookup the specified messageIdL and hashL.
        /// </summary>
        /// <param name='messageIdL'>
        /// If set to <c>true</c> message identifier.
        /// </param>
        /// <param name='hashL'>
        /// If set to <c>true</c> hash.
        /// </param>
        private bool Validate_lookup(string messageIdL, string hashL)
        {
            if (String.IsNullOrEmpty(messageIdL))
            {
                ModelState.AddModelError("messageIdL", "You must specify a message Id.");
            }
            if (String.IsNullOrEmpty(hashL))
            {
                ModelState.AddModelError("hashL", "You must specify a hash.");
            }

            return ModelState.IsValid;
        }

        /// <summary>
        /// Validate_getopt the specified number.
        /// </summary>
        /// <param name='numberGetopt'>
        /// If set to <c>true</c> number.
        /// </param>
        private bool Validate_getopt(string numberGetopt)
        {
            if (String.IsNullOrEmpty(numberGetopt))
            {
                ModelState.AddModelError("numberGetopt", "You must specify a number.");
            }

            return ModelState.IsValid;
        }

        /// <summary>
        /// Validate_setopt the specified numberSetopt, campaignIdSetopt and statusCodeSetopt.
        /// </summary>
        /// <param name='numberSetopt'>
        /// If set to <c>true</c> number.
        /// </param>
        /// <param name='campaignIdSetopt'>
        /// If set to <c>true</c> campaign identifier.
        /// </param>
        /// <param name='statusCodeSetopt'>
        /// If set to <c>true</c> status code.
        /// </param>
        private bool Validate_setopt(string numberSetopt, string campaignIdSetopt, string statusCodeSetopt)
        {
            if (String.IsNullOrEmpty(numberSetopt))
            {
                ModelState.AddModelError("numberSetopt", "You must specify a number.");
            }
            if (String.IsNullOrEmpty(campaignIdSetopt))
            {
                ModelState.AddModelError("campaignIdSetopt", "You must specify a campaign Id.");
            }
            if (String.IsNullOrEmpty(statusCodeSetopt))
            {
                ModelState.AddModelError("statusCodeSetopt", "You must specify a status code.");
            }

            return ModelState.IsValid;
        }

        /// <summary>
        /// Validate_uncache the specified number.
        /// </summary>
        /// <param name='numberUncache'>
        /// If set to <c>true</c> number.
        /// </param>
        private bool Validate_uncache(string numberUncache)
        {
            if (String.IsNullOrEmpty(numberUncache))
            {
                ModelState.AddModelError("numberUncache", "You must specify a number.");
            }

            return ModelState.IsValid;
        }

        /// <summary>
        /// Validate_info the specified number.
        /// </summary>
        /// <param name='numberInfo'>
        /// If set to <c>true</c> number.
        /// </param>
        private bool Validate_info(string numberInfo)
        {
            if (String.IsNullOrEmpty(numberInfo))
            {
                ModelState.AddModelError("numberInfo", "You must specify a number.");
            }

            return ModelState.IsValid;
        }

        /// <summary>
        /// Validate_transactions the specified number.
        /// </summary>
        /// <param name='numberTrans'>
        /// If set to <c>true</c> number .
        /// </param>
        private bool Validate_transactions(string numberTrans)
        {
            if (String.IsNullOrEmpty(numberTrans))
            {
                ModelState.AddModelError("numberTrans", "You must specify a number.");
            }

            return ModelState.IsValid;
        }

    }
}
