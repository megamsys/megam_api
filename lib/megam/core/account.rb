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
      @some_msg = {}
    end

    #used by resque workers and any other background job
    def account
      self
    end

    def megam_rest
      options = { :email => Megam::Config[:email], :api_key => Megam::Config[:api_key]}
      Megam::API.new(options)
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

    def some_msg(arg=nil)
      if arg != nil
        @some_msg = arg
      else
      @some_msg
      end
    end

    def error?
      crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["json_claz"] = self.class.name
      index_hash["id"] = id
      index_hash["email"] = email
      index_hash["api_key"] = api_key
      index_hash["authority"] = authority
      index_hash["some_msg"] = some_msg
      index_hash
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
        "authority" => authority
      }
      result
    end

    # Create a Megam::Account from JSON (used by the backgroud job workers)
    def self.json_create(o)
      acct = new
      acct.id(o["id"]) if o.has_key?("id")
      acct.email(o["email"]) if o.has_key?("email")
      acct.api_key(o["api_key"]) if o.has_key?("api_key")
      acct.authority(o["authority"]) if o.has_key?("authority")
      acct.some_msg[:code] = o["code"] if o.has_key?("code")
      acct.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      acct.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      acct.some_msg[:links] = o["links"] if o.has_key?("links")
      acct
    end

    def self.from_hash(o)
      acct = self.new()
      acct.from_hash(o)
      acct
    end

    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @email      = o[:email] if o.has_key?(:email)
      @api_key   = o[:api_key] if o.has_key?(:api_key)
      @authority = o[:authority] if o.has_key?(:authority)
      self
    end

    def self.create(o)
      acct = from_hash(o)
      acct.create
    end

    # Load a account by email_p
    def self.show(email_p)
      megam_rest.get_accounts(email)
      self
    end

    # Create the node via the REST API
    def create
      megam_rest.post_accounts(to_hash)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end
  end
end
