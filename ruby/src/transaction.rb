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


# :title:Transaction
# 
# The Transaction class allows to manage transaction call object responses from the MoMS API (Mogreet Message System).
#
# The available modules are used to extend a Response object from the Mercury.
# 
# === Examples of requests to the Mercury::Transaction:
# Using a Mercury object m.
# ==== Send
# ===== Creating the parameters Hash and adding parameters:
#  argHash = Hash.new
#  argHash["campaign_id"] = "34110"
#  argHash["message"] = "Tom tests the SDK"
#  argHash["content_id"] = "2150"
#  argHash["from"] = "3108760944"
#  argHash["from_name"] = "Tom"
#  argHash["to"] = "3107840189"
#  argHash["to_name"] = "Jerry"
# ===== Performing the send: 
#  s = m.transaction.send(argHash)
# ===== Getting the message id and the hash:
#  puts "Message ID: " << s.get_message_id
#  puts "Hash ID: "  << s.get_hash
# 
# ===== Lookup
# ===== Creating the parameters Hash and adding parameters:
#  argHash = Hash.new
#  argHash["message_id"] = "74232280" 
#  argHash["hash"] = "ifdc0fpd"
# ===== Performing the lookup: 
#  l = m.transaction.lookup(argHash)
# ===== Getting the info:
#  puts "Campaign ID: " << l.get_campaign_id.to_s
#  puts "To Number: " << l.get_to_number.to_s
#  puts "To Name: " << l.get_to_name
#  puts "From Number: " << l.get_from_number.to_s
#  puts "From Name: " << l.get_from_name
#  puts "Content ID: " << l.get_content_id.to_s
#  puts "Status: " << l.get_status
#  puts "Timestamps Array: " << l.get_timestamps.inspect
#  puts "Events for first timestamp (" << l.get_timestamps[0] << "): " << l.get_events(l.get_timestamps[0]).inspect
# 
# == Contact
# 
# Author:: Thomas SCHWEBEL for Mogreet
# Website:: http://www.mogreet.com/
# Date:: Monday December 06, 2010
#

class Mercury::Transaction

  def initialize client_id, token
    @argHash = { 'client_id' => client_id, 'token' => token }
  end

  ## TRANSACTION CALL OBJECTS
  # The transaction object can initiate an SMS or MMS send and lookup information on a send.
  
  # The send method initiates a transaction and delivery	of an	SMS	or MMS depending on the	set	up of	your campaign.
  # The hash in argument needs to contain 'campaign_id', 'to', 'from' and 'message' keys.
  def send args
    
    # Creates and returns a Response extending the Send module.
    Mercury.check_arguments(["campaign_id", "to", "from", "message"], args)
    Mercury.make_response_object("send", args.merge(@argHash)).extend(Send)
  end

  # The	lookup method	returns	the	info,	status,	and	history	of the requested transaction. 
  # The hash in argument needs to contain 'message_id' and 'hash' keys.
  def lookup args
    
    # Creates and returns a Response extending the Lookup module
    Mercury.check_arguments(["message_id", "hash"], args)
    Mercury.make_response_object("lookup", args.merge(@argHash)).extend(Lookup)
  end

  ## END OF TRANSACTION CALLS OBJECTS

  ## MODULES

  # The Send module implements methods for getting data from a Send Response Object.
  module Send
        
    # Gets the message ID of a send.
    def get_message_id
      @message_id ||= /<message_id(.*?)>(.*?)<\/message_id>/im.match(@xml)[2]
    end

    # Gets the hash ID of a send.
    def get_hash
      @hash ||= /<hash(.*?)>(.*?)<\/hash>/im.match(@xml)[2]
    end
    
  end
  
  # The Lookup module implements methods for getting data from a Lookup Response Object.
  module Lookup

    # Gets the campaign ID associated to the transaction.
    def get_campaign_id
      @campaign_id ||= /<campaign_id(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/campaign_id>/im.match(@xml)[2].to_i
    end

    # Gets the 10-digit mobile phone number of the receiver.
    def get_to_number
      @to ||= /<to(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/to>/im.match(@xml)[2].to_i
    end

    # Gets the name of the receiver.
    def get_to_name
      @to_name ||= /<to_name(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/to_name>/im.match(@xml)[2]
    end

    # Gets the 10-digit mobile phone number of the sender.
    def get_from_number
      @from ||= /<from(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/from>/im.match(@xml)[2].to_i
    end

    # Gets the name of the sender.
    def get_from_name
      @from_name ||= /<from_name(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/from_name>/im.match(@xml)[2]
    end

    # Gets the content id of the content sent to the receiver.
    def get_content_id
      @content_id ||= /<content_id(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/content_id>/im.match(@xml)[2].to_i
    end

    # Gets the text description of the transaction status.
    def get_status
      @status ||= /<status(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/status>/im.match(@xml)[2]
    end

    # Creates the history Hash containing all the data from the events.
    def history
      
      @history ||= {}
  	  @xml.scan(/<event(.*?)<\/event>/) do |event|
  	    event = event.is_a?(Array) ? event.join : event.to_s
  	    
        match     = /timestamp=['"](.*?)['"](.*?)>\s*<!\[CDATA\[(.*?)\]\]>/im.match(event)
        timestamp = match[1]
  	    @history.include?(timestamp) ? @history[timestamp] << (match[3]) : @history[timestamp] = [match[3]]
  	  end if @history.empty?
  	  @history
    end
    private :history
    
    # Gets the array of timestamps.
    # Each timestamp is associated to one or more events of the transaction.
    def get_timestamps
      history.keys
    end

    # Gets the associated event array of the timestamp.
    def get_events timestamp
      
      raise(IndexError, "Timestamp not found") if !history.has_key?(timestamp)
      history[timestamp]
    end
  end
  
end