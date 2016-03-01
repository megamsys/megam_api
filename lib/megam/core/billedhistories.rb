##
## Copyright 2013-2016 Megam Systems
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
  class Billedhistories < Megam::ServerAPI
    def initialize(email=nil, api_key=nil, host=nil)
      @id = nil
      @accounts_id = nil
      @assembly_id = nil
      @bill_type = nil
      @billing_amount = nil
      @currency_type = nil
      @created_at = nil
      @some_msg = {}
      super(email, api_key, host)
    end

    def billedhistories
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

    def bill_type(arg=nil)
      if arg != nil
        @bill_type = arg
      else
      @bill_type
      end
    end

    def billing_amount(arg=nil)
      if arg != nil
        @billing_amount= arg
      else
      @billing_amount
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
      index_hash["assembly_id"] = assembly_id
      index_hash["bill_type"] = bill_type
      index_hash["billing_amount"] = billing_amount
      index_hash["currency_type"] = currency_type
      index_hash["created_at"] = created_at
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
        "bill_type" => bill_type,
        "billing_amount" => billing_amount,
        "currency_type" => currency_type,
        "created_at" => created_at
      }
      result
    end

    #
    def self.json_create(o)
      bal = new
      bal.id(o["id"]) if o.has_key?("id")
      bal.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")
      bal.assembly_id(o["assembly_id"]) if o.has_key?("assembly_id")
      bal.bill_type(o["bill_type"]) if o.has_key?("bill_type")
      bal.billing_amount(o["billing_amount"]) if o.has_key?("billing_amount")
      bal.currency_type(o["currency_type"]) if o.has_key?("currency_type")
      bal.created_at(o["created_at"]) if o.has_key?("created_at")
      #success or error
      bal.some_msg[:code] = o["code"] if o.has_key?("code")
      bal.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      bal.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      bal.some_msg[:links] = o["links"] if o.has_key?("links")
      bal
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      bal = self.new(tmp_email, tmp_api_key, tmp_host)
      bal.from_hash(o)
      bal
    end

    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @accounts_id = o[:accounts_id] if o.has_key?(:accounts_id)
      @assembly_id   = o[:assembly_id] if o.has_key?(:assembly_id)
      @bill_type     = o[:bill_type] if o.has_key?(:bill_type)
      @billing_amount   = o[:billing_amount] if o.has_key?(:billing_amount)
      @currency_type   = o[:currency_type] if o.has_key?(:currency_type)
      @created_at   = o[:created_at] if o.has_key?(:created_at)
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      acct = from_hash(o,tmp_email, tmp_api_key, tmp_host)
      acct.create
    end

    # Create the billing histories via the REST API
    def create
      megam_rest.post_billedhistories(to_hash)
    end

    # Load all billing histories -
    # returns a BillingHistoriesCollection
    # don't return self. check if the Megam::BillingHistoriesCollection is returned.
    def self.list(params)
      billhistory = self.new(params["email"], params["api_key"], params["host"])
      billhistory.megam_rest.get_billedhistories
    end

    # Show a particular billing history by name,
    # Megam::BillingHistory
    def self.show(p_name,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      pre = self.new(tmp_email,tmp_api_key, tmp_host)
      pre.megam_rest.get_billedhistory(p_name)
    end

    def self.delete(p_name,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      pre = self.new(tmp_email,tmp_api_key, tmp_host)
      pre.megam_rest.delete_billedhistory(p_name)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end

