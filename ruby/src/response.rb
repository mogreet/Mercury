############################
# Copyright 2011 Thomas SCHWEBEL
# 
# This file is part of The Mercury Ruby SDK.
# 
# The Mercury Ruby SDK is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# The Mercury Ruby SDK is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with The Mercury Ruby SDK.  If not, see <http://www.gnu.org/licenses/>.
############################


# :title:Response
# 
# The Response object represents a response from the MoMS API (Mogreet Message System).
#
# It is created by the Mercury and it is the result of an API call to the MoMS.
#
# A Response can extend methods from any module from the Mercury (e.g. System, User or Transaction).
# 
# == Contact
# 
# Author:: Thomas SCHWEBEL for Mogreet
# Website:: http://www.mogreet.com/
# Date:: Monday December 06, 2010
#
# 

class Mercury::Response
  # Creates a Response object with an xml String.
  def initialize xml
     @xml = xml
     raise(Mercury::ResponseError, get_response_message << " (" << get_response_status << ")")if !is_valid?
  end
  
  # Returns true if the Response is valid.
  def is_valid?
    get_response_code == 1
  end
  
  # Gets the response status.
  def get_response_status
    @response_status ||= /<response\W(.*?)status=['"](.*?)['"](.*?)>/im.match(@xml)[2]
  end

  # Gets the response code (== 1 if everything went well).
  def get_response_code
    @response_code ||= /<response\W(.*?)code=['"](.*?)['"](.*?)>/im.match(@xml)[2].to_i
  end

  # Gets the response message.
  def get_response_message
    @message ||= /<message(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/message>/im.match(@xml)[2]
  end
  
  # Gets the xml of the response in a String format.
  def get_xml_string
    @xml
  end
end