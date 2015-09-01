##
## Copyright [2013-2015] [Megam Systems]
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
module Megam
  class Billings < Megam::ServerAPI
    
    def initialize(email=nil, api_key=nil, host=nil)
      @id = nil
      @accounts_id = nil
      @line1 = nil
      @line2 = nil
      @country_code = nil
      @postal_code=nil
      @state=nil
      @phone = nil
      @bill_type = nil
      @created_at = nil
      @some_msg = {}
      super(email, api_key, host)
    end

    def billings
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

    def line1(arg=nil)
      if arg != nil
        @line1 = arg
      else
      @line1
      end
    end

    def line2(arg=nil)
      if arg != nil
        @line2 = arg
      else
      @line2
      end
    end

    def country_code(arg=nil)
      if arg != nil
        @country_code = arg
      else
      @country_code
      end
    end

    def postal_code(arg=nil)
      if arg != nil
        @postal_code= arg
      else
      @postal_code
      end
    end

    def state(arg=nil)
      if arg != nil
        @state= arg
      else
      @state
      end
    end

   def phone(arg=nil)
      if arg != nil
        @phone= arg
      else
      @phone
      end
    end
    
    def bill_type(arg=nil)
      if arg != nil
        @bill_type = arg
      else
      @bill_type
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
      index_hash["line1"] = line1
      index_hash["line2"] = line2
      index_hash["country_code"] = country_code
      index_hash["postal_code"] = postal_code
      index_hash["state"] = state
      index_hash["phone"] = phone
      index_hash["bill_type"] = bill_type
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
        "line1" => line1,
        "line2" => line2,
        "country_code" => country_code,
        "postal_code" => postal_code,
        "state" => state,
        "phone" => phone,
        "bill_type" => bill_type,
        "created_at" => created_at
      }
      result
    end

    #
    def self.json_create(o)
      cts = new
      cts.id(o["id"]) if o.has_key?("id")
      cts.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")
      cts.line1(o["line1"]) if o.has_key?("line1")
      cts.line2(o["line2"]) if o.has_key?("line2")
      cts.country_code(o["country_code"]) if o.has_key?("country_code")
      cts.postal_code(o["postal_code"]) if o.has_key?("postal_code")
      cts.state(o["state"]) if o.has_key?("state")
      cts.phone(o["phone"]) if o.has_key?("phone")
      cts.bill_type(o["bill_type"]) if o.has_key?("bill_type")

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
      @line1   = o[:line1] if o.has_key?(:line1)
      @line2     = o[:line2] if o.has_key?(:line2)
      @country_code     = o[:country_code] if o.has_key?(:country_code)
      @postal_code   = o[:postal_code] if o.has_key?(:postal_code)
      @state   = o[:state] if o.has_key?(:state)
      @bill_type   = o[:bill_type] if o.has_key?(:bill_type)
      @created_at   = o[:created_at] if o.has_key?(:created_at)
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil,tmp_host=nil)
      acct = from_hash(o,tmp_email, tmp_api_key, tmp_host)
      acct.create
    end

    # Create the billings via the REST API
    def create
      megam_rest.post_billings(to_hash)
    end

    # Load all billings -
    # returns a billingsCollection
    # don't return self. check if the Megam::billingsCollection is returned.
    def self.list(tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      cts = self.new(tmp_email, tmp_api_key, tmp_host)
      cts.megam_rest.get_billings
    end

    # Show a particular billings by name,
    # Megam::billings
    def self.show(p_name,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      pre = self.new(tmp_email, tmp_api_key, tmp_host)
      pre.megam_rest.get_billing(p_name)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
