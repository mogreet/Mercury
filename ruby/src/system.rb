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


# :title:System
# 
# The System class allows to manage system call object responses from the MoMS API (Mogreet Message System).
#
# The available modules are used to extend a Response object from the Mercury.
# 
# === Example of request to the Mercury::System:
# Using a Mercury object m.
# ==== Ping :
# ===== How to perform the 'ping' request:
#  p = m.system.ping
# ===== How to print its result:
#  puts p.get_response_message
# 
# == Contact
# 
# Author:: Thomas SCHWEBEL for Mogreet
# Website:: http://www.mogreet.com/
# Date:: Monday December 06, 2010
#


class Mercury::System
  
  def initialize client_id, token
    @argHash = { 'client_id' => client_id, 'token' => token }
  end
  
  ## SYSTEM OBJECT REQUESTS
  # The system object tests connectivity to MoMS API servers.	 
  
  # The ping method tests connectivity to the MoMS API servers.
  def ping args = {}

    # Creates and returns a Response extending the Ping module.
    Mercury.make_response_object("ping", args.merge(@argHash)).extend(Ping)
  end

  # The status method => Not available yet.
  def status
     raise NotImplementedError, "Status method not available yet"
  end
  
  ## END OF SYSTEM OBJECT REQUESTS
  
  ## MODULES
  
  # The Ping module implements methods for getting data from a Ping Response Object.
  # This module is the same as a basic Response Object.
  module Ping
    # Represents a ping response.
    # Same as a Response object.
  end
  
  # The System module implements methods for getting data from a System Response Object.
  # This module is not implemented yet.
  module Status
    # Not implemented yet.
  end
  
end