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


require 'net/https'
require 'uri'

# :title:Mercury
# The Mercury is a SDK that allows to use the MoMS (Mogreet Messaging System) API easily with the ruby language.
#
# The MoMS (Mogreet Message System) is a dynamic SMS, MMS, and email messaging system which supports many different clients, many different campaigns, many different message flows, many different aggregators	and	many different carriers.
# 
# == Examples
# === Creating a Mercury object :
#  m = Mercury.new "312", "4c2fi6j7f1c6d7"
# === Examples of requests to the Mercury :
# ==== Ping :
# ===== How to perform the 'ping' request :
#  p = m.system.ping
# ===== How to print its result :
#  puts p.get_response_message
# ==== Send
# ===== Creating the parameters Hash and adding parameters :
#  argHash = Hash.new
#  argHash["campaign_id"] = "34110"
#  argHash["message"] = "Tom tests the SDK"
#  argHash["content_id"] = "2150"
#  argHash["from"] = "3108760944"
#  argHash["from_name"] = "Tom"
#  argHash["to"] = "3107840189"
#  argHash["to_name"] = "Jerry"
# ===== Performing the send : 
#  s = m.transaction.send(argHash)
# ===== Getting the message id and the hash :
#  puts "Message ID: " << s.get_message_id
#  puts "Hash ID: "  << s.get_hash
# 
# == Contact
# 
# Author:: Thomas SCHWEBEL for Mogreet
# Website:: http://www.mogreet.com/
# Date:: Monday December 06, 2010
#
 
class Mercury
  
  require File.expand_path(File.join(File.dirname(__FILE__), 'response'))
  
  # Subclass of StandardError which is raised when a Mercury Response error occurs.
  class Mercury::ResponseError < StandardError
  end
  
  # Contains the url of the API.
  API_URL = "https://api.mogreet.com/moms/"
  
  # Hash API method name => API url.
  # Takes the method name as a key and gives the complete API url for the API method as a key.
  URLS = {
    "ping"         => API_URL + "system.ping",
    #"status"      => "",
    "send"         => API_URL + "transaction.send",
    "lookup"       => API_URL + "transaction.lookup",
    "getopt"       => API_URL + "user.getopt",
    "setopt"       => API_URL + "user.setopt",
    "uncache"      => API_URL + "user.uncache",
    "info"         => API_URL + "user.info",
    "transactions" => API_URL + "user.transactions"
  }
  
  attr_accessor :system, :transaction, :user
  
  
  # Creates a MoMSBox object that allows to perform API calls.
  # The client ID and token from your client account are required.
  def initialize client_id, token
    
    require File.expand_path(File.join(File.dirname(__FILE__), 'user'))
    require File.expand_path(File.join(File.dirname(__FILE__), 'system'))
    require File.expand_path(File.join(File.dirname(__FILE__), 'transaction'))
    
    @user        = Mercury::User.new(client_id, token)
    @system      = Mercury::System.new(client_id, token)
    @transaction = Mercury::Transaction.new(client_id, token)
  end


  # Makes a HTTP Post request at the 'url' with the parameters 'params'.
  # Returns a HTTPResponse object.
  def self.make_http_post url, params=Hash.new
    
    # Parses url.
    uri = URI.parse(url)
    # Initiliazes net http.
    http_session = Net::HTTP.new(uri.host, uri.port)
    # Sets timeout at 90 sec to avoid timeout exception due to lag.
    http_session.read_timeout = 90
    # Sets ssl.
    http_session.use_ssl = true
		# Initializes request.
		request = Net::HTTP::Post.new(uri.request_uri)
		# Sets data.
		request.set_form_data(params)
		# Submits request.
		http_response = http_session.request(request)
    # Raises an error if the http request failed.
    http_response.error! if http_response.class.is_a?(Net::HTTPSuccess)
	
		# Returns the HTTPResponse object.
		http_response
  end
  
  
  # Checks if the required arguments from argArray are in the argHash.
  def self.check_arguments argArray, argHash
    
    argArray.each do |key|
      raise(ArgumentError, "Missing argument '" << key << "'!") if !argHash.include?(key)
    end
  end
  
  
  # Makes the HTTP Post, creates and returns a Response Object.
  def self.make_response_object objectName, argHash=Hash.new
    
    raise(ArgumentError, "Invalid object name '" << objectName << "'!") if !URLS.has_key?(objectName)
    Response.new(make_http_post(URLS[objectName], argHash).body)
    
    rescue Exception => e
      raise e.class, "Error while processing '" << objectName << "' API call: " << e.to_s
  end
end