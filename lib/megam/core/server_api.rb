# Copyright:: Copyright (c) 2012, 2014 Megam Systems
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
    attr_reader :host
    attr_reader :password
    attr_reader :org_id

    # Create a Megam REST object. The supplied email and api_key is used as the base for
    # all subsequent requests. For example, when initialized with an email, api_key  url
    # https://api.megam.io, a call to +get+ with 'accounts' will make an
    # HTTP GET request to https://api.megam.io/accounts using the email, api_key
    def initialize(o)
      @email = o[:email]
      @api_key = o[:api_key] || nil
      @host = o[:host]
      @password = o[:password] || nil
      @org_id = o[:org_id]
    end

    # Build a megam api client
    #
    # === Parameters
    # api:: The Megam::API client
    def megam_rest
      options = { :email => email || Megam::Config[:email], :api_key => api_key || Megam::Config[:api_key], :org_id => org_id || Megam::Config[:org_id], :password => password || Megam::Config[:password], :host => host || Megam::Config[:host]}
      Megam::API.new(options)
    end



  end
end
