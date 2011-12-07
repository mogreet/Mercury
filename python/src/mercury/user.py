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


class Getopt(object):
    '''
    The Getopt object contains the response from a getopt request to the Moms API.
    '''
    
    def __init__(self, urlGetopt):
        '''
        Creation of a new Getopt response to the MOMs API.
        @param urlGetopt: URL to make from the Mogreet API
        '''
        #Parsing the xml document from the url
        try:
            xmlDoc = ElementTree.parse(urllib.urlopen(urlGetopt))  
        except IOError:
            print "Error while parsing the XML document"  
        
        root = xmlDoc.getroot()    
        campid = []
        status = []
        code = []
        for it in root.findall(".//campaign"):
            campid.append(it.attrib.get("id"))
        for st in root.findall(".//status"):
            status.append(st.text)
            code.append(st.attrib.get("code"))
        
        self.message = root.find(".//message").text
        self.responseCode = root.attrib.get("code")
        self.responseStatus = root.attrib.get("status")
        self.number = root.find(".//number").text
        self.campaignID = campid
        self.campaignStatus = status
        self.campaignStatusCode = code
        
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
    
    def getNumber(self):
        '''
        @return: The number
        '''
        return self.number
    
    
    def getCampaignIDList(self):
        '''
        @return: The list of all campaign IDs
        '''
        return self.campaignID
    
    def getCampaignStatusList(self):
        '''
        @return: The list of all campaign Status
        '''
        return self.campaignStatus
    
    def getCampaignStatusCodeList(self):
        '''
        @return: The list of all campaign status codes 
        '''
        return self.campaignStatusCode
    
    def getCampaignStatus(self, campaignId):
        '''
        Get the campaign status regarding to its campaign ID
        @param campaignId: The campaign ID
        @return: The corresponding campaign status
        '''
        camp = self.campaignID
        status = self.campaignStatus
        index = camp.index(campaignId)
        return status[index]
    
    def getCampaignStatusCode(self, campaignId):
        '''
        Get the campaign status code regarding to the campaign ID
        @param campaignId: The campaign ID
        @return: the corresponding campaign status code
        '''
        camp = self.campaignID
        code = self.campaignStatusCode
        index = camp.index(campaignId)
        return code[index]
        
       
class Info(object):
    '''
    The Info object contains the response from an info request to the Moms API.
    ''' 
    
    def __init__(self, urlInfo):
        '''
        Creation of a new Info response to the MOMs API.
        @param urlInfo: URL to make from the Mogreet API
        '''
        #Parsing the xml document from the url
        try:
            xmlDoc = ElementTree.parse(urllib.urlopen(urlInfo))  
        except IOError:
            print "Error while parsing the XML document"
        root = xmlDoc.getroot()    
        
        self.message = root.find(".//message").text
        self.responseCode = root.attrib.get("code")
        self.responseStatus = root.attrib.get("status")
        self.number = root.find(".//number").text
        self.carrier = root.find(".//carrier").text
        self.handset = root.find(".//handset").text
        self.carrierID = root.find(".//carrier").attrib.get("id")
        self.handsetID = root.find(".//handset").attrib.get("id")
        
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
    
    def getNumber(self):
        '''
        @return: The number
        '''
        return self.number
    
    def getCarrier(self):
        '''
        @return: The phone carrier
        '''
        return self.carrier
    
    def getCarrierID(self):
        '''
        @return: The carrier ID
        '''
        return self.carrierID
    
    def getHandset(self):
        '''
        @return: The phone handset
        '''
        return self.handset
    
    def getHandsetID(self):
        '''
        @return: The handset ID
        '''
        return self.handsetID
        

class Setopt(object):
    '''
    The Setopt object contains the response from a setopt request to the Moms API.
    '''
    
    def __init__(self, urlSetopt):
        '''
        Creation of a new Setopt response to the MOMs API.
        @param urlSetopt: URL to make from the Mogreet API
        '''
        #Parsing the xml document from the url
        try:
            xmlDoc = ElementTree.parse(urllib.urlopen(urlSetopt))  
        except IOError:
            print "Error while parsing the XML document"
        
        root = xmlDoc.getroot()    
        
        self.message = root.find(".//message").text
        self.responseCode = root.attrib.get("code")
        self.responseStatus = root.attrib.get("status")
        self.number = root.find(".//number").text
        self.campaignID = root.find(".//campaign").attrib.get("id")
        self.campaignStatusCode = root.find(".//status").attrib.get("code")
        self.campaignStatus = root.find(".//status").text
        
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
    
    def getNumber(self):
        '''
        @return: The number
        '''
        return self.number
    
    def getCampaignID(self):
        '''
        @return: The campaign ID
        '''
        return self.campaignID
    
    def getCampaignStatusCode(self):
        '''
        @return: The campaign Status Code
        '''
        return self.campaignStatusCode
    
    def getCampaignStatus(self):
        '''
        @return: The campaign Status
        '''
        return self.campaignStatus
    

class Transactions(object):
    '''
    The Transactions object contains the response from a transactions request to the Moms API.
    '''
    
    def __init__(self, urlTrans):
        '''
        Creation of a new Trans response to the MOMs API.
        @param urlTrans: URL to make from the Mogreet API
        '''
        #Parsing the xml document from the url
        try:
            xmlDoc = ElementTree.parse(urllib.urlopen(urlTrans))  
        except IOError:
            print "Error while parsing the XML document"  
        
        root = xmlDoc.getroot()    
        campid = []
        campName = []
        datestamp = []
        _hash = []
        messid = []
        fromNum = []
        toNum = []
        fromNom = []
        toNom = []
        for camp in root.findall(".//campaign"):
            campid.append(camp.attrib.get("id"))
            campName.append(camp.attrib.get("name"))
        for attr in root.findall(".//transaction"):
            datestamp.append(attr.attrib.get("datestamp"))
            _hash.append(attr.attrib.get("hash"))
            messid.append(attr.attrib.get("message_id"))
        for fromItem in root.findall(".//from"):
            fromNum.append(fromItem.attrib.get("number"))
            fromNom.append(fromItem.text)
        for toItem in root.findall(".//to"):
            toNum.append(toItem.attrib.get("number"))
            toNom.append(toItem.text)
        
        self.message = root.find(".//message").text
        self.responseCode = root.attrib.get("code")
        self.responseStatus = root.attrib.get("status")
        self.campaignIDs = campid
        self.campaignNames = campName
        self.dateStamp = datestamp
        self.hash = _hash
        self.messageIDs = messid
        self.toName = toNom
        self.toNumber = toNum
        self.fromName = fromNom
        self.fromNumber = fromNum
        
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
    
    def getAllCampaignIDs(self):
        '''
        @return: The list of all campaign IDs
        '''
        return self.campaignIDs
        
    def getAllCampaignNames(self):
        '''
        @return: The list of all Campaign Names
        '''
        return self.campaignNames
    
    def getAllDateStamps(self):
        '''
        @return: The list of all date stamps
        '''
        return self.dateStamp
    
    def getAllHash(self):
        '''
        @return: The list of all hashes
        '''
        return self.hash
    
    def getAllMessageIDs(self):
        '''
        @return: The list of all message IDs
        '''
        return self.messageIDs
    
    def getAllToNames(self):
        '''
        @return: The list of all recipient names
        '''
        return self.toName
    
    def getAllToNumbers(self):
        '''
        @return: The list of all recipients numbers
        '''
        return self.toNumber
    
    def getAllFromNames(self):
        '''
        @return: The list of all sender names
        '''
        return self.fromName
    
    def getAllFromNumbers(self):
        '''
        @return: The list of all sender numbers
        '''
        return self.fromNumber
    
    def getToName(self, messageId):
        '''
        Get the recipient name regarding to the message ID
        @param messageId: The message ID
        @return: The recipient name
        '''
        messid = self.messageIDs
        names = self.toName
        index = messid.index(messageId)
        return names[index]
    
    def getFromName(self, messageId):
        '''
        Get the sender name regarding to the message ID
        @param messageId: the message ID
        @return: The sender name
        '''
        messid = self.messageIDs
        names = self.fromName
        index = messid.index(messageId)
        return names[index]
    
    def getToNumber(self, messageId):
        '''
        Get the recipient number regarding to the message ID
        @param messageId: the message ID
        @return: The recipient number
        '''
        messid = self.messageIDs
        nums = self.toNumber
        index = messid.index(messageId)
        return nums[index]
    
    def getFromNumber(self, messageId):
        '''
        Get the sender number regarding to the message ID
        @param messageId: The message ID
        @return: The sender number
        '''
        messid = self.messageIDs
        names = self.fromNumber
        index = messid.index(messageId)
        return names[index]
    
    def getDateStamp(self, messageId):
        '''
        Get the date stamp of the message regarding to the message ID
        @param messageId: The message ID
        @return: The date stamp of the message
        '''
        messid = self.messageIDs
        dates = self.dateStamp
        index = messid.index(messageId)
        return dates[index]
       
        
class Uncache(object):
    '''
    The Uncache object contains the response from an uncache request to the MoMs API.
    '''
    
    def __init__(self, urlUncache):
        '''
        Creation of a new Uncache response to the MOMs API.
        @param urlUncache: URL to make from the Mogreet API
        '''
        #Parsing the xml document from the url
        try:
            xmlDoc = ElementTree.parse(urllib.urlopen(urlUncache))  
        except IOError:
            print "Error while parsing the XML document" 
        
        root = xmlDoc.getroot()    
        
        self.message = root.find(".//message").text
        self.responseCode = root.attrib.get("code")
        self.responseStatus = root.attrib.get("status")
        self.number = root.find(".//number").text
        
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
    
    def getNumber(self):
        '''
        @return: The number
        '''
        return self.number
