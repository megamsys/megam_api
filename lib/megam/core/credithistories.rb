# Copyright:: Copyright (c) 2013-2016 Megam Systems
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
  class Credithistories < Megam::ServerAPI
    
    def initialize(email=nil, api_key=nil, host=nil)
      @id = nil
      @accounts_id = nil
      @bill_type = nil
      @credit_amount = nil
      @currency_type = nil      
      @created_at = nil
      @some_msg = {}
      super(email, api_key, host)
    end

    def credithistories
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

    def bill_type(arg=nil)
      if arg != nil
        @bill_type = arg
      else
      @bill_type
      end
    end

    def credit_amount(arg=nil)
      if arg != nil
        @credit_amount = arg
      else
      @credit_amount
      end
    end

    def currency_type(arg=nil)
      if arg != nil
        @currency_type = arg
      else
      @currency_type
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
      index_hash["bill_type"] = bill_type
      index_hash["credit_amount"] = credit_amount
      index_hash["currency_type"] = currency_type    
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
        "bill_type" => bill_type,
        "credit_amount" => credit_amount,
        "currency_type" => currency_type,
        "created_at" => created_at
      }
      result
    end

    #
    def self.json_create(o)
      cts = new
      cts.id(o["id"]) if o.has_key?("id")
      cts.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")
      cts.bill_type(o["bill_type"]) if o.has_key?("bill_type")
      cts.credit_amount(o["credit_amount"]) if o.has_key?("credit_amount")
      cts.currency_type(o["currency_type"]) if o.has_key?("currency_type")

      cts.created_at(o["created_at"]) if o.has_key?("created_at")
      #success or error
      cts.some_msg[:code] = o["code"] if o.has_key?("code")
      cts.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      cts.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      cts.some_msg[:links] = o["links"] if o.has_key?("links")
      cts
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      cts = self.new(tmp_email,tmp_api_key, tmp_host)
      cts.from_hash(o)
      cts
    end

    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @accounts_id = o[:accounts_id] if o.has_key?(:accounts_id)
      @bill_type   = o[:bill_type] if o.has_key?(:bill_type)
      @credit_amount     = o[:credit_amount] if o.has_key?(:credit_amount)
      @currency_type     = o[:currency_type] if o.has_key?(:currency_type)
      @created_at   = o[:created_at] if o.has_key?(:created_at)
      self
    end

    def self.create(params)
      acct = from_hash(params,params["email"], params["api_key"], params["host"])
      acct.create
    end

    # Create the credit histories via the REST API
    def create
      megam_rest.post_credithistories(to_hash)
    end

    # Load all credithistories -
    # returns a credithistoriesCollection
    # don't return self. check if the Megam::ccredithistoriesCollection is returned.
    def self.list(params)
      cts = self.new(params["email"], params["api_key"], params["host"])
      cts.megam_rest.get_credithistories
    end

    # Show a particular credithistories by name,
    # Megam::credithistories
    def self.show(p_name,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      pre = self.new(tmp_email, tmp_api_key, tmp_host)
      pre.megam_rest.get_credithistories(p_name)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
