# Copyright:: Copyright (c) 2013-2016 Megam Systems, Inc.
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
  class Auth
    
    def initialize
      @some_msg = {}
    end

    #used by resque workers and any other background job
    def auth
      self
    end

    def megam_rest
      Megam::API.new(Megam::Config[:email], Megam::Config[:api_key], Megam::Config[:host])
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
      index_hash["some_msg"] = some_msg
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

    def for_json
      result = { }
      result
    end

    # Create a Megam::Account from JSON (used by the backgroud job workers)
    def self.json_create(o)
      acct = new
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

    # just an auth
    def self.auth
      megam_rest.post_auth
      self
    end


    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end
  end
end