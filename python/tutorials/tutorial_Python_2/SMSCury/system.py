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

class Ping(object):
    '''
    The Ping object contains the response from a ping request to the Moms API.
    '''    
    
    def __init__(self, urlPing):
        '''
        Initializes a new Ping response object.
        @param urlPing URL for calling requests from Mogreet API.
        '''
        
        #Parsing the xml document from the url
        try:
            xmlDoc = ElementTree.parse(urllib.urlopen(urlPing))  
        except IOError:
            print "Error while parsing the XML document"  
        
        root = xmlDoc.getroot()
        
        self.message = root.find(".//message").text
        self.responseCode = root.attrib.get("code")
        self.responseStatus = root.attrib.get("status")
             
    def __getattr__(self, attribut):
        print("Attribute {0} undefined!".format(attribut))
    
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
        @return: The response Code
        ''' 
        return self.responseCode
    
    def responseIsValid(self):
        '''
        Checks if the response code is 1.
        @return: True if the response code is 1, False if it is not
        '''
        if (self.responseCode == 1):
            return True
        else:
            return False