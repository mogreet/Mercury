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


# :title:User
# 
# The User class allows to manage user call object responses from the MoMS API (Mogreet Message System).
#
# The available modules are used to extend a Response object from the Mercury.
# 
# === Examples of requests to the Mercury::User:
# Using a Mercury object m.
# ==== GetOpt
# ===== Creating the parameters Hash and adding parameters:
#  argHash = Hash.new
#  argHash["number"] = "3105767889"
# ===== Performing the getopt: 
#  go = m.user.getopt(argHash)
# ===== Getting the info:
#  puts "Number: " << go.get_number.to_s
#  puts "Campaigns Array: " << go.get_campaigns.inspect
#  puts "Status Code for first campaign (" << go.get_campaigns[0].to_s << "): " << go.get_campaign_status_code(go.get_campaigns[0]).to_s
#  puts "Status for first campaign (" << go.get_campaigns[0].to_s << "): " << go.get_campaign_status(go.get_campaigns[0]).to_s
# 
# ==== SetOpt
# ===== Creating the parameters Hash and adding parameters:
#  argHash = Hash.new
#  argHash["number"] = "3105767889"
#  argHash["campaign_id"] = "45520"
#  argHash["status_code"] = "-1"
# ===== Performing the setopt: 
#  so = m.user.setopt(argHash)
# ===== Getting the info:
#  puts "Number: " << so.get_number.to_s
#  puts "Campaign Id: " << so.get_campaign_id
#  puts "Campaign Status: " << so.get_campaign_status
#  puts "Campaign Status Code: " << so.get_campaign_status_code
# 
# ==== Uncache
# ===== Creating the parameters Hash and adding parameters:
#  argHash = Hash.new
#  argHash["number"] = "3105767889"
# ===== Performing the uncache: 
#  u = m.user.uncache(argHash)
# ===== Getting the info:
#  puts "Number uncached: " << u.get_number.to_s
# 
# ==== Info
# ===== Creating the parameters Hash and adding parameters:
#  argHash = Hash.new
#  argHash["number"] = "3105767889"
# ===== Performing the info: 
#  i = m.user.info(argHash)
# ===== Getting the info:
#  puts "Number: " << i.get_number.to_s
#  puts "Carrier Id: " << i.get_carrier_id.to_s
#  puts "Carrier Name: " << i.get_carrier_name
#  puts "Handset Name: " << i.get_handset_name
#  puts "Handset Id: " << i.get_handset_id.to_s
# 
# ==== Transactions
# ===== Creating the parameters Hash and adding parameters:
#  argHash = Hash.new
#  argHash["number"] = "3105767889"
# ===== Performing the transactions: 
#  t = m.user.transactions(argHash)
# ===== Getting the info:
#  puts "Campaigns: " << t.get_campaigns.inspect
#  first_campaign = t.get_campaigns[0].to_s
#  puts "First campaign: " << t.get_campaign_name(first_campaign)
#  puts "Transactions for the first campaign (" << t.get_campaigns[0] << "): " << (t.get_campaign_transactions first_campaign).inspect
#  first_trans = (t.get_campaign_transactions first_campaign)[1].to_s
#  puts "Hash for the first campaign (" << first_campaign << ") and first transaction (" << first_trans << "): " <<  t.get_transaction_hash( first_campaign, first_trans)
#  puts "DateStamp for the first campaign (" << first_campaign << ") and first transaction (" << first_trans << "): " << t.get_transaction_datestamp( first_campaign, first_trans)
#  puts "To Number for the first campaign (" << first_campaign << ") and first transaction (" << first_trans << "): " << t.get_transaction_to_number( first_campaign, first_trans).to_s
#  puts "From Number for the first campaign (" << first_campaign << ") and first transaction (" << first_trans << "): " << t.get_transaction_from_number( first_campaign, first_trans).to_s
#  puts "To Name for the first campaign (" << first_campaign << ") and first transaction (" << first_trans << "): " << t.get_transaction_to_name( first_campaign, first_trans)
#  puts "From Name for the first campaign (" << first_campaign << ") and first transaction (" << first_trans << "): " << t.get_transaction_from_name( first_campaign, first_trans)
# == Contact
# 
# Author:: Thomas SCHWEBEL for Mogreet
# Website:: http://www.mogreet.com/
# Date:: Monday December 06, 2010
# 

class Mercury::User
  
  def initialize client_id, token
    @argHash = { 'client_id' => client_id, 'token' => token }
  end
  
  ## USER CALL OBJECTS
  # The user object exposes users' basic information, transactions, and campaign status.	

  # The getopt method returns the opt in status of any mobile number.
  # The hash in argument needs to contain a 'number' key.
  def getopt args
    
    # Creates and returns a Response extending the GetOpt module.
    Mercury.check_arguments(["number"], args)
    Mercury.make_response_object("getopt", args.merge(@argHash)).extend(GetOpt)
  end

  # The setopt method sets the opt in status of any mobile number.
  # The hash in argument needs to contain 'number', 'campaign_id' and 'status_code' keys.
  def setopt args
    
    # Creates and returns a Response extending the SetOpt module.
    Mercury.check_arguments(["number", "campaign_id", "status_code"], args)
    Mercury.make_response_object("setopt", args.merge(@argHash)).extend(SetOpt)
  end

  # The uncache method clears the user carrier and handset info from the Mogreet cache.
  # The hash in argument needs to contain a 'number' key.
  def uncache args
    
    # Creates and returns a Response extending the Uncache module.
    Mercury.check_arguments(["number"], args)
    Mercury.make_response_object("uncache", args.merge(@argHash)).extend(Uncache)
  end

  # The info method returns the user carrier and handset info if available.
  # The hash in argument needs to contain a 'number' key.
  def info args
    
    # Creates and returns a Response extending the Info module.
    Mercury.check_arguments(["number"], args)
    Mercury.make_response_object("info", args.merge(@argHash)).extend(Info)
  end

  # The transactions method returns the user’s transactions (open and closed).	
  # The hash in argument needs to contain a 'number' key.
  def transactions args
    
    # Creates and returns a Response extending the Info module.
    Mercury.check_arguments(["number"], args)
    Mercury.make_response_object("transactions", args.merge(@argHash)).extend(Transactions)
  end
  #
  ## END OF USER CALL OBJECTS

  ## MODULES
  
  # The SetOpt module implements methods for getting data from a SetOpt Response Object.
  module SetOpt
      
    # Gets the 10-digit mobile phone number.
    def get_number
      @number ||= /<number(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/number>/im.match(@xml)[2].to_i
    end

    # Gets the campaign ID where the opt has been set.
    def get_campaign_id
      @campaign_id ||= /id=['"](.*?)['"](.*?)>/im.match(/<campaign(.*?)<\/campaign>/im.match(@xml)[1])[1].to_i
    end

    # Gets the campaign status (OPTEDIN or OPTEDOUT).
    def get_campaign_status
      @campaign_status ||= /<status(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/status>/im.match(/<campaign(.*?)<\/campaign>/im.match(@xml)[1])[2]
    end

    # Gets the campaign status code (1 (OPTEDIN) or -2 (OPTEDOUT)).
    def get_campaign_status_code
      @campaign_status_code ||=  /<status(.*?)code=['"](.*?)['"](.*?)>/im.match(/<campaign(.*?)<\/campaign>/im.match(@xml)[1])[2].to_i
    end
  end

  # The GetOpt module implements methods for getting data from a GetOpt Response Object.
  module GetOpt
    
    # Gets the 10-digit mobile phone number.
    def get_number
      @number ||= /<number(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/number>/im.match(@xml)[2].to_i
    end
    
    # Creates the Hash containing all the data from the campaigns associated with the phone number passed as argument.
    def campaigns
      
      @campaigns ||= {}
      @xml.scan(/<campaign(.*?)<\/campaign>/im) do |campaign|
        campaign = campaign.is_a?(Array) ? campaign.join : campaign.to_s
  	    
  	    @campaigns[/id=['"](.*?)['"](.*?)>/im.match(campaign)[1].to_i] = {
          "status_code" => /<status(.*?)code=['"](.*?)['"](.*?)>/im.match(campaign)[2].to_i, 
          "status"      => /<status(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/status>/im.match(campaign)[2]
        }
      end if @campaigns.empty?
      @campaigns
    end
    private :campaigns
    
    # Gets the array of campaigns searched for the mobile phone number.
    def get_campaigns
      campaigns.keys
    end

    # Gets the campaign status code of the campaign ID passed as argument.
    # Only works with campaigns that have been searched during the getopt API call.
    def get_campaign_status_code(campaign_id)
      
      raise(IndexError, "Campaign id not found") if !campaigns.has_key?(campaign_id)
      campaigns[campaign_id]["status_code"]
    end

    # Gets the campaign status message of the campaign ID passed as parameter.
    # Only works with campaigns that have been searched during the getopt API call.
    def get_campaign_status(campaign_id)
      
      raise(IndexError, "Campaign id not found") if !campaigns.has_key?(campaign_id)
      campaigns[campaign_id]["status"]
    end
  end
  
  # The Uncache module implements methods for getting data from a Uncache Response Object.
  module Uncache
        
    # Gets the 10-digit mobile phone number that has been uncached.
    def get_number
      @number ||= /<number(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/number>/im.match(@xml)[2].to_i
    end
  end
  
  # The Info module implements methods for getting data from a Info Response Object.
  module Info

    # Gets the 10-digit mobile phone number.
    def get_number
      @number ||= /<number(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/number>/im.match(@xml)[2].to_i
    end

    # Gets the carrier ID.
    def get_carrier_id
      @carrier_id ||= /<carrier(.*?)id=['"](.*?)['"](.*?)>/im.match(@xml)[2].to_i
    end

    # Gets the carrier name.
    def get_carrier_name
      @carrier_name ||= /<carrier(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/carrier>/im.match(@xml)[2]
    end

    # Gets the handset ID.
    def get_handset_id
      @handset_id ||= /<handset(.*?)id=['"](.*?)['"](.*?)>/im.match(@xml)[2].to_i
    end

    # Gets the handset name.
    def get_handset_name
      @handset_name ||= /<handset(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/handset>/im.match(@xml)[2]
    end
  end
  
  # The Transactions module implements methods for getting data from a Transactions Response Object.
  module Transactions
    
    # Creates the Hash containing all the data from the campaigns associated with the phone number passed as argument.
    def campaigns
      @campaigns ||= {}
      if @campaigns.empty?
        
        @xml.scan(/<campaign(.*?)<\/campaign>/im) do |campaign|
          campaign    = campaign.is_a?(Array) ? campaign.join : campaign.to_s
          campaign_id = /id=['"](.*?)['"](.*?)>/im.match(campaign)[1].to_i
          
      	  @campaigns[campaign_id] = 
      	  {
            'name'         => /name=['"](.*?)['"](.*?)>/im.match(campaign)[1], 
            "transactions" => Hash.new
      	  } if !@campaigns.include?(campaign_id) # prevents from wiping out other transactions from the same campaign.

      	  campaign.to_s.scan(/<transaction(.*?)<\/transaction>/im) do |trans|
            trans = trans.is_a?(Array) ? trans.join : trans.to_s
            
      	    @campaigns[campaign_id]['transactions'][/message_id=['"](.*?)['"](.*?)>/im.match(trans)[1]] = 
      	    {
              'hash'      => /hash=['"](.*?)['"](.*?)>/im.match(trans)[1], 
              "datestamp" => /datestamp=['"](.*?)['"](.*?)>/im.match(trans)[1], 
              "to"        => {
                "number" => /<to(.*?)number=['"](.*?)['"](.*?)>/im.match(trans)[2].to_i, 
                "name"   => /<to(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/to>/im.match(trans)[2]
              },
              "from"      => {
                "number" => /<from(.*?)number=['"](.*?)['"](.*?)>/im.match(trans)[2].to_i, 
                "name"   => /<from(.*?)>\s*<!\[CDATA\[(.*?)\]\]>\s*<\/from>/im.match(trans)[2]
              }
      	    }
      	  end
      	end
      end
      @campaigns
    end
    private :campaigns
    
    # Gets the array of campaign ID searched.
    def get_campaigns
      campaigns.keys
    end

    # Gets the name of the campaign.
    def get_campaign_name campaign_id
      
      raise(IndexError,"Campaign id not found") if !campaigns.has_key?(campaign_id)
      campaigns[campaign_id]["name"]
    end

    # Gets the array of transactions ID associated with the campaign_id.
    def get_campaign_transactions campaign_id
      
      raise(IndexError,"Campaign id not found") if !campaigns.has_key?(campaign_id)
      campaigns[campaign_id]["transactions"].keys
    end

    # Gets the hash associated with the transaction ID from the campaign ID.
    def get_transaction_hash campaign_id, transaction_id
      
      raise(IndexError,"Campaign id not found") if !campaigns.has_key?(campaign_id)
      raise(IndexError, "Transaction id not found") if !campaigns[campaign_id]["transactions"].has_key?(transaction_id)
      campaigns[campaign_id]["transactions"][transaction_id]["hash"]
    end

    # Gets the transaction datestamp associated with the transaction ID from the campaign ID.
    def get_transaction_datestamp campaign_id, transaction_id
      
      raise(IndexError,"Campaign id not found") if !campaigns.has_key?(campaign_id)
      raise(IndexError, "Transaction id not found") if !campaigns[campaign_id]["transactions"].has_key?(transaction_id)
      campaigns[campaign_id]["transactions"][transaction_id]["datestamp"]
    end

    # Gets the transaction to number associated with the transaction ID from the campaign ID.
    def get_transaction_to_number campaign_id, transaction_id
      
      raise(IndexError,"Campaign id not found") if !campaigns.has_key?(campaign_id)
      raise(IndexError, "Transaction id not found") if !campaigns[campaign_id]["transactions"].has_key?(transaction_id)
      campaigns[campaign_id]["transactions"][transaction_id]["to"]["number"]
    end

    # Gets the transaction to name associated with the transaction ID from the campaign ID.
    def get_transaction_to_name campaign_id, transaction_id
      
      raise(IndexError,"Campaign id not found") if !campaigns.has_key?(campaign_id)
      raise(IndexError, "Transaction id not found") if !campaigns[campaign_id]["transactions"].has_key?(transaction_id)
      campaigns[campaign_id]["transactions"][transaction_id]["to"]["name"]
    end

    # Gets the transaction from number associated with the transaction ID from the campaign ID.
    def get_transaction_from_number campaign_id, transaction_id
      
      raise(IndexError,"Campaign id not found") if !campaigns.has_key?(campaign_id)
      raise(IndexError, "Transaction id not found") if !campaigns[campaign_id]["transactions"].has_key?(transaction_id)
      campaigns[campaign_id]["transactions"][transaction_id]["from"]["number"]
    end

    # Gets the transaction from name associated with the transaction ID from the campaign ID.
    def get_transaction_from_name campaign_id, transaction_id
      
      raise(IndexError,"Campaign id not found") if !campaigns.has_key?(campaign_id)
      raise(IndexError, "Transaction id not found") if !campaigns[campaign_id]["transactions"].has_key?(transaction_id)
      campaigns[campaign_id]["transactions"][transaction_id]["from"]["name"]
    end   
    
  end
  
end