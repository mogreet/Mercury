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
from xml.etree import ElementTree


class Lookup(object):
    '''
    The Lookup object contains the response from a lookup request to the Moms API.
    '''
    
    def __init__(self, urlLookup):
        '''
        Creation of a new Lookup response to the MOMs API.
        @param urlLookup: URL to make from the Mogreet API
        '''
        #Parsing the xml document from the url
        try:
            xmlDoc = ElementTree.parse(urllib.urlopen(urlLookup))  
        except IOError:
            print "Error while parsing the XML document"  
        
        root = xmlDoc.getroot()    
        events = []
        stamps = []
        for ev in root.findall(".//event"):
            events.append(ev.text)
            stamps.append(ev.attrib.get("timestamp"))
            
        self.message = root.find(".//message").text
        self.responseCode = root.attrib.get("code")
        self.responseStatus = root.attrib.get("status")
        self.campaignId = root.find(".//campaign_id").text
        self.fromNumber = root.find(".//from").text
        self.fromName = root.find(".//from_name").text
        self.toNumber = root.find(".//to").text
        self.toName = root.find(".//to_name").text
        self.contentId = root.find(".//content_id").text
        self.status = root.find(".//status").text
        self.history = events
        self.timestamp = stamps
        
    def __getattr__(self, attribut):
        print("Attribute {0} undefined!".format(attribut))
        
    def responseIsValid(self):
        '''
        Checks if the response code is 1.
        @return: True if the response code is 1, False if it is not
        '''
        if (self.responseCode == 1):
            return True
        else:
            return False
     
    def getMessage(self):
        '''
        @return: The message
        '''
        return self.message
        
    def getResponseStatus(self):
        '''
        @return: The response Status
        '''
        return self.responseStatus
        
    def getResponseCode(self):
        '''
        @return: The response code
        '''
        return self.responseCode
    
    def getCampaignID(self):
        '''
        @return: The campaign ID
        '''
        return self.campaignId
    
    def getFromNumber(self):
        '''
        @return: The phone number of the sender
        '''
        return self.fromNumber
    
    def getFromName(self):
        '''
        @return: The name of the sender
        '''
        return self.fromName
    
    def getToNumber(self):
        '''
        @return: The phone number of the recipient
        '''
        return self.toNumber
    
    def getToName(self):
        '''
        @return: The name of the recipient
        '''
        return self.toName
    
    def getContentID(self):
        '''
        @return: The content ID
        '''
        return self.contentId
    
    def getStatus(self):
        '''
        @return: The status
        '''
        return self.status
    
    def getEventsList(self):
        '''
        @return: The history of the transaction
        '''
        return self.history
    
    def getTimestampList(self):
        '''
        @return: The timeStamps of the current transaction
        '''
        return self.timestamp
    
    def getEvent(self, timestamp):
        '''
        Get an event regarding to its timestamp
        @param timestamp: A timestamp
        @return: An event
        '''
        ts = self.timestamp
        evts = self.history
        index = ts.index(timestamp)
        return evts[index]
 
     
class Send(object):
    '''
    The Send object contains the response from a send request to the Moms API.
    '''
    
    def __init__(self, urlSend):  
        '''
        Creation of a new Send response to the MOMs API.
        @param urlSend: URL to make from the Mogreet API
        '''
        #Parsing the xml document from the url
        try:
            xmlDoc = ElementTree.parse(urllib.urlopen(urlSend))  
        except IOError:
            print "Error while parsing the XML document"  
        
        root = xmlDoc.getroot()    
        
        self.message = root.find(".//message").text
        self.responseCode = root.attrib.get("code")
        self.responseStatus = root.attrib.get("status")
        self.messageId = root.find(".//message_id").text
        self.hash = root.find(".//hash").text
        
    def __getattr__(self, attribut):
        print("Attribute {0} undefined!".format(attribut))
        
    def responseIsValid(self):
        '''
        Checks if the response code is 1.
        @return: True if the response code is 1, False if it is not
        '''
        if (self.responseCode == 1):
            return True
        else:
            return False
     
    def getMessage(self):
        '''
        @return: The message
        '''
        return self.message
        
    def getResponseStatus(self):
        '''
        @return: The response Status
        '''
        return self.responseStatus
        
    def getResponseCode(self):
        '''
        @return: The response code
        '''
        return self.responseCode
    
    def getMessageID(self):
        '''
        @return: The message ID
        '''
        return self.messageId
    
    def getHash(self):
        '''
        @return: The hash
        '''
        return self.hash
