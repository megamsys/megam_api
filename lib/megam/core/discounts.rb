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
  class Discounts < Megam::ServerAPI
    
    def initialize(email=nil, api_key=nil)
      @id = nil
      @accounts_id = nil
      @bill_type = nil
      @code = nil
      @status = nil
      @created_at = nil
      @some_msg = {}
      super(email, api_key)
    end

    def cloud_tool_setting
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

    def code(arg=nil)
      if arg != nil
        @code = arg
      else
      @code
      end
    end

    def status(arg=nil)
      if arg != nil
        @status = arg
      else
      @status
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
      index_hash["code"] = code
      index_hash["status"] = status
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
        "code" => code,
        "status" => status,
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
      cts.code(o["code"]) if o.has_key?("code")
      cts.status(o["status"]) if o.has_key?("status")

      cts.created_at(o["created_at"]) if o.has_key?("created_at")
      #success or error
      cts.some_msg[:code] = o["code"] if o.has_key?("code")
      cts.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      cts.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      cts.some_msg[:links] = o["links"] if o.has_key?("links")
      cts
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil)
      cts = self.new(tmp_email,tmp_api_key)
      cts.from_hash(o)
      cts
    end

    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @accounts_id = o[:accounts_id] if o.has_key?(:accounts_id)
      @bill_type   = o[:bill_type] if o.has_key?(:bill_type)
      @code     = o[:code] if o.has_key?(:code)
      @status     = o[:status] if o.has_key?(:status)
      @created_at   = o[:created_at] if o.has_key?(:created_at)
      self
    end

    def self.create(params)
     
      discount = from_hash(params, params[:email], params[:api_key])
      discount.create
    end

    # Create the discounts via the REST API
    def create
      
      megam_rest.post_discounts(to_hash)
    end
    
      def self.update(o)
     discount = from_hash(o)
     discount.update
   end

   # Create the node via the REST API
   def update
     megam_rest.update_discounts(to_hash)
   end

    # Load all discounts -
    # returns a discountsCollection
    # don't return self. check if the Megam::discountsCollection is returned.
    def self.list(params)
      cts = self.new(params[:email], params[:api_key])
      
      cts.megam_rest.get_discounts
    end

    # Show a particular discounts by name,
    # Megam::discounts
    def self.show(p_name,tmp_email=nil, tmp_api_key=nil)
      pre = self.new(tmp_email, tmp_api_key)
      pre.megam_rest.get_discounts(p_name)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
