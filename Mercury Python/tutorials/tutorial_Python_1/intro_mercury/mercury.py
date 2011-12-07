#!/usr/bin/python
'''
  Copyright 2011 Julien Salvi for Mogreet
 
  This file is part of Mercury.
 
  Mercury is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
 
  Mercury is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with Mercury. If not, see <http://www.gnu.org/licenses/>.
'''

import urllib
import user
import transaction
import system

class Mercury(object):
    '''
    The Mercury is an object that allows to execute three types of requests (system, user and transaction) to the MoMS API.
    '''
    
    def __init__(self, clientID, token):
        '''
        Create a new Mercury object
        @param clientID: The client ID
        @param token: The token of the client
        '''
        self.clientID = clientID
        self.token = token

    def setParams(self, hashMap):
        '''
        Returns a URL format string created with HashMap key-value pairs.
        @param hashMap: hash List of parameters (param_name-param_value pairs)
        '''
        params = "client_id="+self.clientID+"&token="+self.token
        if hashMap != None:
            for key, value in hashMap.items():
                params = params+"&"+key+"="+urllib.quote(value)
        return params
    
    def checkInputParams(self, paramsList, hashMap):
        '''
        Checks if the parameters in paramsList are the keys in hash.
        @param hashMap: List of parameters (param_name-param_value pairs)
        @param paramsList: Array of parameters names
        @return: True if all parameters in the list are the keys in hash, else false.
        '''
        for item in paramsList:
            if (hashMap.has_key(item) == False):
                return False
        return True
    
    def ping(self):
        '''
        Tests connectivity to the MoMS API servers.<br />
        <pre>
        <b>Code sample:</b>
        myPing = myMercury.ping
        </pre>
        @return:  A new Ping response object
        '''
        urlPing = "https://api.mogreet.com/moms/system.ping?"
        params = self.setParams(None)
        urlPing = urlPing+params
        
        myPing = system.Ping(urlPing)
        return myPing
    
    def lookup(self, paramsLook):
        '''
        Returns the info, status and history of the requested transaction.
        <pre>
        <b>Code sample:</b>
        hash = {"message_id":"xxxxx", "hash":"xxxxx"}
        myLookup = myMercury.lookup(hash)
        </pre>
        @param paramsLook: A map object that must contains the following keys with their corresponding value:
        <ul>
            <li> "message_id" &rarr; "...": <i>An ID returned from a {@link #send} or from {@link #transactions} method.</i>
            <li> "hash" &rarr; "...": <i>A hash returned from a {@link #send} or from a {@link #transactions} method.</i>
        </ul>
        @return: A new Lookup response object
        '''
        urlLookup = "https://api.mogreet.com/moms/transaction.lookup?"
        params = self.setParams(paramsLook)
        urlLookup = urlLookup+params
        
        myLook = transaction.Lookup(urlLookup)
        return myLook
    
    def send(self, paramsSend):
        '''
        Initiates a transaction and delivery of an SMS or MMS.
        <pre>
        <b>Code sample:</b> 
        hash = {"campaign_id":"xxxxx", "from":"xxxxxxxxxx",
                "to":"xxxxxxxxxx", "message":"Hello, World!", "content_id":"xxxx"}
        mySend = myMercury.send(hash)
        </pre>
        @param paramsSend:  A Map object that must contain the following keys with their corresponding value:
        <ul>
           <li> "campaign_id" &rarr; "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
           <li> "to" &rarr; "...": <i>A 10-digit mobile phone number.</i>
           <li> "from" &rarr; "...": <i>A 10-digit mobile phone number.</i>
           <li> "message" &rarr; "...": <i>Depending on your campaign set up, the message presented to the "to" user.</i>
           <li> "content_id" &rarr; "...": <i>An ID associated to the content being sent (optional - depending on your campaign set up, this parameter may be required).</i>
           <li> OR "content_url" &rarr; "...": <i>underdevelopment - for users who host their own content</i>
        </ul>
        The Map can also contain the following optionnal key-value pairs: 
        <ul>
          <li> "to_name" &rarr; "...": <i>A name associated to the "to" mobile number (if not included will be set to "to" mobile number).</i>
          <li> "from_name" &rarr; "...": <i>A name associated to the "from" mobile number (if not included will be set to "from" mobile number).</i>
          <li> "udp_*" &rarr; "...": <i>User Defined Parameter. Clients can pass in any number of udp_* parameters for message flow customization.</i>
        </ul>
        @return A new Send response object
        '''
        urlSend = "https://api.mogreet.com/moms/transaction.send?"
        params = self.setParams(paramsSend)
        urlSend = urlSend+params
        
        mySend = transaction.Send(urlSend)
        return mySend
    
    def getopt(self, paramsGetopt):
        '''    
        Returns the opt in status of any mobile number.
        <pre>
        <b>Code sample:</b>
        hash = {"number":"xxxxxxxxxx", "campaign_id":"xxxxx"}
        myGetopt = myMercury.getopt(hash)
        </pre>
        @param paramsGetopt:  A Map object that must contains the following keys with their corresponding value:
        <ul>
          <li> "number" &rarr; "...": <i>A 10-digit mobile phone number.</i>
        </ul>
        The Map can also contain the following optionnal key-value pairs:
        <ul>
         <li> "campaign_id" &rarr; "...": <i>A campaign id to search on, if excluded, returns all opt in statuses for the client's campaigns.</i>
        </ul>
        @return: A new Getopt response object
        '''
        urlGetopt = "https://api.mogreet.com/moms/user.getopt?"
        params = self.setParams(paramsGetopt)
        urlGetopt = urlGetopt+params
        
        myGetopt = user.Getopt(urlGetopt)
        return myGetopt
    
    def info(self, paramsInfo):
        '''
        Returns the user carrier and handset info if available.
        <pre>
        <b>Code sample:</b> 
        hash = {"number":"xxxxxxxxxx"}
        myInfo = myMercury.info(hash)
        </pre>
        @param paramsInfo:  A Map object that must contains the following key with its corresponding value:
        <ul>
           <li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
        </ul>
        @return: A new Info response object
        '''
        urlInfo = "https://api.mogreet.com/moms/user.info?"
        params = self.setParams(paramsInfo)
        urlInfo = urlInfo+params
        
        myInfo = user.Info(urlInfo)
        return myInfo
    
    def setopt(self, paramsSetopt):
        '''
        Sets the opt in status of any mobile number.
        <pre>
        <b>Code sample:</b> 
        hash = {"number":"xxxxxxxxxx", "campaign_id":"xxxxx", "status_code":"xx"}
        mySetopt = myMercury.setopt(hash)
        </pre>
        @param paramsSetopt:  A Map object that must contains the following keys with their corresponding value:
        <ul>
           <li> "number" &rarr; "...": <i>A 10-digit mobile phone number.</i>
           <li> "campaign_id" &rarr; "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
           <li> "status_code" &rarr; "...": <i>See the bellow table for available codes to use here.</i>
        </ul>
        
        <table border="1">
            <tr>
                <td>Status</td>
                <td>Status code</td>
               <td>Description</td>
            </tr>
            <tr>
                <td>OPTEDIN</td>
                <td>1</td>
               <td>User is opted into the campaign</td>
            </tr>
            <tr>
                <td>OPTEDOUT</td>
                <td>-2</td>
               <td>User is opted out of the campaign</td>
            </tr>
        </table>
        <br />
        @return: A new Setopt response object
        '''
        urlSetopt = "https://api.mogreet.com/moms/user.setopt?"
        params = self.setParams(paramsSetopt)
        urlSetopt = urlSetopt+params
        
        mySetopt = user.Setopt(urlSetopt)
        return mySetopt
    
    def transactions(self, paramsTrans):
        '''
        Returns the user's transactions (open and closed).
        <pre>
        <b>Code sample:</b> 
        hash = {"number":"xxxxxxxxxx"}
        myTransactions = myMercury.transactions(hash)
        </pre>
        @param paramsTrans:  A Map object that must contains the following key with its corresponding value:
        <ul>
           <li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
        </ul>
        The Map can also contain the following optionnal key-value pairs:
        <ul>
           <li> "campaign_id" &rarr; "...": <i>A campaign id to search on, if excluded, returns all transactions for the client's campaigns.</i>
           <li> "start_date" &rarr; "...": <i>Narrow search by adding a date to start searching on (YYYY-MM-DD).</i>
           <li> "end_date" &rarr; "...": <i>Narrow search by adding a date to stop searching on (YYYY-MM-DD).</i>
        </ul>
        @return: A new Transactions response object
        '''
        urlTrans = "https://api.mogreet.com/moms/user.transactions?"
        params = self.setParams(paramsTrans)
        urlTrans = urlTrans+params
        
        myTrans = user.Transactions(urlTrans)
        return myTrans
    
    def uncache(self, paramsUncache):
        '''
        Clears the user carrier and handset info from the Mogreet cache.
        <pre>
        <b>Code sample:</b>
        hash = {"number":"xxxxxxxxxx"}
        myUncache = myMercury.uncache(hash)
        </pre>
        @param hash A Map object that must contains the following key with its corresponding value:
        <ul>
          <li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
        </ul>
        @return A new Uncache response object
        '''
        urlUncache = "https://api.mogreet.com/moms/user.uncache?"
        params = self.setParams(paramsUncache)
        urlUncache = urlUncache+params
        
        myUncache = user.Uncache(urlUncache)
        return myUncache