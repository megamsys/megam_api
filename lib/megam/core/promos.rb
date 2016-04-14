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
  class Promos < Megam::RestAdapter
    def initialize(email=nil, api_key=nil, host=nil)
      @id = nil
      @code = nil
      @amount = nil
      @created_at = nil
      @some_msg = {}
      super(email, api_key, host)
    end

    def promos
      self
    end

    def id(arg=nil)
      if arg != nil
        @id = arg
      else
        @id
      end
    end

    def code(arg=nil)
      if arg != nil
        @code = arg
      else
        @code
      end
    end

    def amount(arg=nil)
      if arg != nil
        @amount = arg
      else
        @amount
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
      index_hash["code"] = code
      index_hash["amount"] = amount
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
        "code" => code,
        "amount" => amount,
        "created_at" => created_at
      }
      result
    end

    def self.json_create(o)
      promos = new
      promos.id(o["id"]) if o.has_key?("id")
      promos.code(o["code"]) if o.has_key?("code")
      promos.amount(o["amount"]) if o.has_key?("amount")
      promos.created_at(o["created_at"]) if o.has_key?("created_at")
      #success or error
      promos.some_msg[:code] = o["code"] if o.has_key?("code")
      promos.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      promos.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      promos.some_msg[:links] = o["links"] if o.has_key?("links")
      promos
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      promos = self.new(tmp_email, tmp_api_key, tmp_host)
      promos.from_hash(o)
      promos
    end

    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @code = o[:name] if o.has_key?(:name)
      @amount  = o[:credit] if o.has_key?(:credit)
      @created_at   = o[:created_at] if o.has_key?(:created_at)
      self
    end

    def self.create(params)
      promo = from_hash(params,params["email"], params["api_key"], params["host"])
      promo.create
    end

    # Create the predef via the REST API
    def create
      megam_rest.post_promos(to_hash) #WONT BE USED AS OF NOW
    end

    def self.list(params)
      promos = self.new(params["email"], params["api_key"],  params["host"])
      promos.megam_rest.get_promos
    end

    # Show a particular promo by name,
    # Megam::Promos
    def self.show(params)
      pre = self.new(params["email"], params["api_key"], params["host"])
      pre.megam_rest.get_promos(params["code"])
    end


    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
