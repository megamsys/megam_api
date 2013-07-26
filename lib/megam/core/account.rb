# Copyright:: Copyright (c) 2012-2013 Megam Systems, Inc.
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
  class Account
    def initialize
      @id = nil
      @email = nil
      @api_key = nil
      @authority = nil
    end

    #used by resque workers and any other background job
    def account
      self
    end

    def megam_rest
      Megam::API.new(Megam::Config[:email], Megam::Config[:api_key])
    end

    def id(arg=nil)
      if arg != nil
        @id = arg
      else
      @id
      end
    end

    def email(arg=nil)
      if arg != nil
        @email = arg
      else
      @email
      end
    end

    def api_key(arg=nil)
      if arg != nil
        @api_key = arg
      else
      @api_key
      end
    end

    def authority(arg=nil)
      if arg != nil
        @authority = arg
      else
      @authority
      end
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["megam_type"] = "account"
      index_hash["id"] = id
      index_hash["email"] = email
      index_hash["api_key"] = api_key
      index_hash["authority"] = authority
      index_hash
    end
    
    # Transform hash to -> a new ruby obj
    def self.from_hash(acct_hash)
      acct = Megam::Acount.new
      acct.id acct_hash['id']
      acct.email acct_hash['email']
      acct.api_key acct_hash['password']
      acct.authority acct_hash['authority']
      acct
    end

    # Serialize this object as a hash: called from JsonCompat. 
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

    def for_json
      result = {
        "id" => id,
        "email" => email,
        "api_key" => api_key,
        "authority" => authority,
        'json_class' => self.class.name
      }
      result
    end

    # Create a Megam::Account from JSON
    def self.from_json(json)
      Megam::Account.from_hash(Megam::JSONCompat.from_json(json))
    end

    class << self
      alias_method :json_create, :from_json
    end

    def self.find_or_create(email_f)
      show(email_f)
    rescue Net::HTTPServerException => e
      raise unless e.response.code == '404'
      acct = build
      acct.create
      end

    def self.build
      payload = {:id => self.id, :email =>  self.email, :api_key => self.api_key, :authority => self.authority }
      from_hash(payload)
    end

    # Load a account by email_p
    def self.show(email_p)
      megam_rest.get_accounts(email)
    end

    # Create the node via the REST API
    def create
      megam_rest.post_accounts(to_hash)
      self
    end

    def to_s
      "account[#{email}]"
    end
  end
end