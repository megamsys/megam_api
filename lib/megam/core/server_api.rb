# Copyright:: Copyright (c) 2012, 2013 Megam Systems
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Megam
  # Basic HTTP client, with support for adding features via middleware
  class ServerAPI

    
    attr_reader :email
    attr_reader :api_key


    # Create a Megam REST object. The supplied email and api_key is used as the base for
    # all subsequent requests. For example, when initialized with an email, api_key  url
    # https://api.megam.co, a call to +get+ with 'nodes' will make an
    # HTTP GET request to http://api.megam.co/nodes using the email, api_key
    def initialize(email=nil, api_key=nil)
      @email = email
      @api_key = api_key      
    end

    # Build a megam api client
    #
    # === Parameters
    # api:: The Megam::API client
    def megam_rest
      options = { :email =>email || Megam::Config[:email], :api_key => api_key || Megam::Config[:api_key]}
      Megam::API.new(options)
    end
    


  end
end

