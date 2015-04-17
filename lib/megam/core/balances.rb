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
  class Balances < Megam::ServerAPI
    def initialize(email=nil, api_key=nil)
      @id = nil
      @accounts_id = nil
      @credit = nil
      @created_at = nil
      @updated_at = nil
      @some_msg = {}
      super(email, api_key)
    end

    def balances
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

    def credit(arg=nil)
      if arg != nil
        @credit = arg
      else
      @credit
      end
    end

    def created_at(arg=nil)
      if arg != nil
        @created_at = arg
      else
      @created_at
      end
    end

    def updated_at(arg=nil)
      if arg != nil
        @updated_at = arg
      else
      @updated_at
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
      index_hash["credit"] = credit
      index_hash["created_at"] = created_at
      index_hash["updated_at"] = updated_at
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
        "credit" => credit, 
        "created_at" => created_at,
        "updated_at" => updated_at
      }
      result
    end

    
    def self.json_create(o)
      balances = new
      balances.id(o["id"]) if o.has_key?("id")    
      balances.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")   
      balances.credit(o["credit"]) if o.has_key?("credit")
      balances.created_at(o["created_at"]) if o.has_key?("created_at")
      balances.updated_at(o["updated_at"]) if o.has_key?("updated_at")
      #success or error
      balances.some_msg[:code] = o["code"] if o.has_key?("code")
      balances.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      balances.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      balances.some_msg[:links] = o["links"] if o.has_key?("links")
      balances
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil)
      balances = self.new(tmp_email, tmp_api_key)
      balances.from_hash(o)
      balances
    end

    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @account_id = o[:account_id] if o.has_key?(:account_id)
      @credit   = o[:credit] if o.has_key?(:credit)     
      @created_at   = o[:created_at] if o.has_key?(:created_at)
      @updated_at   = o[:updated_at] if o.has_key?(:updated_at)
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil)
      acct = from_hash(o,tmp_email, tmp_api_key)
      acct.create
    end

    # Create the predef via the REST API
    def create
      megam_rest.post_balances(to_hash)
    end

    # Load all balances -
    # returns a BalanceCollection
    # don't return self. check if the Megam::BalanceCollection is returned.
    def self.list(tmp_email=nil, tmp_api_key=nil)
    balance = self.new(tmp_email,tmp_api_key)
      balance.megam_rest.get_balances
    end

    # Show a particular balance by name,
    # Megam::Balance
    def self.show(p_name,tmp_email=nil, tmp_api_key=nil)
    pre = self.new(tmp_email,tmp_api_key)
    pre.megam_rest.get_balance(p_name)
    end

    def self.delete(p_name,tmp_email=nil, tmp_api_key=nil)
    pre = self.new(tmp_email,tmp_api_key)
    pre.megam_rest.delete_balance(p_name)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
