# Copyright:: Copyright (c) 2012, 2013 Megam Systems
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
      @logo = nil
      @catagory = nil
      @pricetype = nil
      @features={}
      @plan={}
      @attach =nil
      @predefnode=nil
      @some_msg = {}      
      @approved = nil      
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

    def logo(arg=nil)
      if arg != nil
        @logo = arg
      else
      @logo
      end
    end

    def catagory(arg=nil)
      if arg != nil
        @catagory = arg
      else
      @catagory
      end
    end

    def id(arg=nil)
      if arg != nil
        @id = arg
      else
      @id
      end
    end

    def pricetype(arg=nil)
      if arg != nil
        @pricetype = arg
      else
      @pricetype
      end
    end

    def features(arg=nil)
      if arg != nil
        @features = arg
      else
      @features
      end
    end

    def plan(arg=nil)
      if arg != nil
        @plan = arg
      else
      @plan
      end
    end

    def predefnode(arg=nil)
      if arg != nil
        @predefnode = arg
      else
      @predefnode
      end
    end

    def attach(arg=nil)
      if arg != nil
        @attach = arg
      else
      @attach
      end
    end

    def approved(arg=nil)
      if arg != nil
        @approved = arg
      else
      @approved
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
      index_hash["logo"] = logo
      index_hash["catagory"] = catagory
      index_hash["pricetype"] = pricetype
      index_hash["features"] = features
      index_hash["plan"] = plan
      index_hash["attach"] = attach
      index_hash["predefnode"] = predefnode
      index_hash["approved"] = approved      
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
        "logo" => logo,
        "catagory" => catagory,
        "pricetype" => pricetype,
        "features" => features,
        "plan" => plan,
        "attach" => attach,
        "predefnode" => predefnode,
        "approved" => approved,        
        "created_at" => created_at
      }
      result
    end
   
    def self.json_create(o)
      app = new
      app.id(o["id"]) if o.has_key?("id")
      app.name(o["name"]) if o.has_key?("name")
      app.logo(o["logo"]) if o.has_key?("logo")
      app.catagory(o["catagory"]) if o.has_key?("catagory")
      app.pricetype(o["pricetype"]) if o.has_key?("pricetype")   
      app.attach(o["attach"]) if o.has_key?("attach")
      app.predefnode(o["predefnode"]) if o.has_key?("predefnode")
      app.approved(o["approved"]) if o.has_key?("approved")
      app.created_at(o["created_at"]) if o.has_key?("created_at")
      #requests
      oq = o["features"]
      app.features[:feature1] = oq["feature1"] if oq && oq.has_key?("feature1")
      app.features[:feature2] = oq["feature2"] if oq && oq.has_key?("feature2")
      app.features[:feature3] = oq["feature3"] if oq && oq.has_key?("feature3")
      app.features[:feature4] = oq["feature4"] if oq && oq.has_key?("feature4")
    
      op = o["plan"]
      app.plan[:price] = op["price"] if op && op.has_key?("price")
      app.plan[:description] = op["description"] if op && op.has_key?("description")
      app.plan[:plantype]= op["plantype"] if op && op.has_key?("plantype")    
      
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
      @name = o["name"] if o.has_key?("name")
      @catagory   = o["catagory"] if o.has_key?("catagory")
      @id        = o["id"] if o.has_key?("id")
      @logo    = o["logo"] if o.has_key?("logo")
      @pricetype    = o["pricetype"] if o.has_key?("pricetype")
      @features    = o["features"] if o.has_key?("features")
      @plan   = o["plan"] if o.has_key?("plan")
      @attach   = o["attach"] if o.has_key?("attach")
      @predefnode   = o["predefnode"] if o.has_key?("predefnode")
      @approved   = o["approved"] if o.has_key?("approved")      
      @created_at        = o["created_at"] if o.has_key?("created_at")
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil)
      acct = from_hash(o, tmp_email, tmp_api_key)
      acct.create
    end

    # Create the marketplace app via the REST API
    def create
      megam_rest.post_marketplaceapp(to_hash)
    end

    # Load a account by email_p
    def self.show(name, tmp_email=nil, tmp_api_key=nil)
      app = self.new(tmp_email, tmp_api_key)
      app.megam_rest.get_marketplaceapp(name)
    end

    def self.list(tmp_email=nil, tmp_api_key=nil)
      app = self.new(tmp_email, tmp_api_key)
      app.megam_rest.get_marketplaceapps
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end
