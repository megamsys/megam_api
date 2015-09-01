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
  class Subscriptions < Megam::ServerAPI
    
    def initialize(email=nil, api_key=nil, host=nil)
      @id = nil
      @accounts_id = nil
      @assembly_id = nil
      @start_date = nil
      @end_date = nil
      @created_at = nil
      @some_msg = {}
      super(email, api_key, host)
    end

    def subscriptions
      self
    end

    
    def id(arg=nil)
      if arg != nil
        @id = arg
      else
      @id
      end
    end

    def accounts_id(arg=nil)
      if arg != nil
        @accounts_id= arg
      else
      @accounts_id
      end
    end

    def assembly_id(arg=nil)
      if arg != nil
        @assembly_id = arg
      else
      @assembly_id
      end
    end

    def start_date(arg=nil)
      if arg != nil
        @start_date = arg
      else
      @start_date
      end
    end

    def end_date(arg=nil)
      if arg != nil
        @end_date = arg
      else
      @end_date
      end
    end

    def created_at(arg=nil)
      if arg != nil
        @created_at = arg
      else
      @created_at
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
      index_hash["accounts_id"] = accounts_id
      index_hash["assembly_id"] = assembly_id
      index_hash["start_date"] = start_date
      index_hash["end_date"] = end_date
      index_hash["created_at"] = created_at
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
        "accounts_id" => accounts_id,
        "assembly_id" => assembly_id,
        "start_date" => start_date,
        "end_date" => end_date,
        "created_at" => created_at
      }
      result
    end

    #
    def self.json_create(o)
      cts = new
      cts.id(o["id"]) if o.has_key?("id")
      cts.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")
      cts.assembly_id(o["assembly_id"]) if o.has_key?("assembly_id")
      cts.start_date(o["start_date"]) if o.has_key?("start_date")
      cts.end_date(o["end_date"]) if o.has_key?("end_date")

      cts.created_at(o["created_at"]) if o.has_key?("created_at")
      #success or error
      cts.some_msg[:code] = o["code"] if o.has_key?("code")
      cts.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      cts.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      cts.some_msg[:links] = o["links"] if o.has_key?("links")
      cts
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      cts = self.new(tmp_email,tmp_api_key,tmp_host)
      cts.from_hash(o)
      cts
    end

    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @accounts_id = o[:accounts_id] if o.has_key?(:accounts_id)
      @assembly_id   = o[:assembly_id] if o.has_key?(:assembly_id)
      @start_date     = o[:start_date] if o.has_key?(:start_date)
      @end_date     = o[:end_date] if o.has_key?(:end_date)
      @created_at   = o[:created_at] if o.has_key?(:created_at)
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      acct = from_hash(o,tmp_email, tmp_api_key, tmp_host)
      acct.create
    end

    # Create the subscriptions via the REST API
    def create
      megam_rest.post_subscriptions(to_hash)
    end

    # Load all subscriptions -
    # returns a subscriptionsCollection
    # don't return self. check if the Megam::subscriptionsCollection is returned.
    def self.list(tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      cts = self.new(tmp_email, tmp_api_key, tmp_host)
      cts.megam_rest.get_subscriptions
    end

    # Show a particular subscriptions by name,
    # Megam::subscriptions
    def self.show(p_name,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      pre = self.new(tmp_email, tmp_api_key, tmp_host)
      pre.megam_rest.get_subscriptions(p_name)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
