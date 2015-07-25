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
require 'hashie'

module Megam
  class MarketPlace < Megam::ServerAPI
    def initialize(email=nil, api_key=nil)
      @id = nil
      @name = nil
      @catalog = {}
      @plans=nil
      @cattype =nil
      @predef =nil
      @some_msg = {}
      @status = nil
      @created_at = nil
      super(email, api_key)
    end

    def market_place
      self
    end


    def name(arg=nil)
      if arg != nil
        @name = arg
      else
      @name
      end
    end

    def catalog(arg=nil)
      if arg != nil
        @catalog = arg
      else
      @catalog
      end
    end

    def id(arg=nil)
      if arg != nil
        @id = arg
      else
      @id
      end
    end


    def plans(arg=nil)
      if arg != nil
        @plans = arg
      else
      @plans
      end
    end


    def predef(arg=nil)
      if arg != nil
        @predef = arg
      else
      @predef
      end
    end

    def cattype(arg=nil)
      if arg != nil
        @cattype = arg
      else
      @cattype
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
      index_hash["name"] = name
      index_hash["catalog"] = catalog
      index_hash["plans"] = plans
      index_hash["cattype"] = cattype
      index_hash["predef"] = predef
      index_hash["status"] = status
      index_hash["some_msg"] = some_msg
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
        "name" => name,
        "catalog" => catalog,
        "plans" => plans,
        "cattype" => cattype,
        "predef" => predef,
        "status" => status,
        "created_at" => created_at
      }
      result
    end

    def self.json_create(o)
      app = new
      app.id(o["id"]) if o.has_key?("id")
      app.name(o["name"]) if o.has_key?("name")

      ct = o["catalog"]
      app.catalog[:logo] = ct["logo"] if ct && ct.has_key?("logo")
      app.catalog[:category] = ct["category"] if ct && ct.has_key?("category")
      app.catalog[:description] = ct["description"] if ct && ct.has_key?("description")
      app.catalog[:port] = ct["port"] if ct && ct.has_key?("port")
      
      app.plans(o["plans"]) if o.has_key?("plans")
      app.cattype(o["cattype"]) if o.has_key?("cattype")
      app.predef(o["predef"]) if o.has_key?("predef")
      app.status(o["status"]) if o.has_key?("status")
      app.created_at(o["created_at"]) if o.has_key?("created_at")

      #success or error
      app.some_msg[:code] = o["code"] if o.has_key?("code")
      app.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      app.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      app.some_msg[:links] = o["links"] if o.has_key?("links")

      app
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil)
      app = self.new(tmp_email, tmp_api_key)
      app.from_hash(o)
      app
    end

    def from_hash(o)
      @name           = o["name"] if o.has_key?("name")
      @id             = o["id"] if o.has_key?("id")
      @catalog        = o["catalog"] if o.has_key?("catalog")
      @plans          = o["plans"] if o.has_key?("plans")
      @cattype        = o["cattype"] if o.has_key?("cattype")
      @predef         = o["predef"] if o.has_key?("predef")
      @status         = o["status"] if o.has_key?("status")
      @created_at     = o["created_at"] if o.has_key?("created_at")
      self
    end

    def self.create(params)
      acct = from_hash(params, params["email"], params["api_key"])
      acct.create
    end

    # Create the marketplace app via the REST API
    def create
      megam_rest.post_marketplaceapp(to_hash)
    end

    # Load a account by email_p
    def self.show(params)
      app = self.new(params["email"], params["api_key"])
      app.megam_rest.get_marketplaceapp(params["id"])
    end

    def self.list(params)
      app = self.new(params["email"], params["api_key"])
      app.megam_rest.get_marketplaceapps
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end
