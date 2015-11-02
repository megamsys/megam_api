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
    def initialize(email=nil, api_key=nil, host=nil)
      @id = nil
      @name = nil
      @cattype = nil
      @order = nil
      @image = nil
      @url = nil
      @host = nil
      @port = nil
      @username = nil
      @password = nil
      @plans= nil
      @created_at = nil
      super(email, api_key, host)
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

    def cattype(arg=nil)
      if arg != nil
        @cattype = arg
      else
      @cattype
      end
    end

    def order(arg=nil)
      if arg != nil
        @order = arg
      else
      @order
      end
    end

    def image(arg=nil)
      if arg != nil
        @image = arg
      else
      @image
      end
    end

    def url(arg=nil)
      if arg != nil
        @url = arg
      else
      @url
      end
    end

    def host(arg=nil)
      if arg != nil
        @host = arg
      else
        @host
      end
    end

    def port(arg=nil)
      if arg != nil
       @port = arg
     else
        @port
      end
    end

    def username(arg=nil)
      if arg != nil
        @username = arg
      else
        @username
      end
    end

    def password(arg=nil)
     if arg != nil
       @password = arg
     else
       @password
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
      index_hash["cattype"] = cattype
      index_hash["order"] = order
      index_hash["image"] = image
      index_hash["url"] = url
      index_hash["host"] = host
      index_hash["port"] = port
      index_hash["username"] = username
      index_hash["password"] = password
      index_hash["plans"] = plans
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
        "cattype" => cattype,
        "order" => order,
        "image" => image,
        "url" => url,
        "host" => host,
        "port" => port,
        "username" => username,
        "plans" => plans,
        "created_at" => created_at
      }
      result
    end

    def self.json_create(o)
      app = new
      app.id(o["id"]) if o.has_key?("id")
      app.name(o["name"]) if o.has_key?("name")
      app.cattype(o["cattype"]) if o.has_key?("cattype")
      app.order(o["order"]) if o.has_key?("order")
      app.image(o["image"]) if o.has_key?("image")
      app.url(o["url"]) if o.has_key?("url")
      app.host(o["hash"]) if o.has_key?("host")
      app.port(o["port"]) if o.has_key?("port")
      app.username(o["username"]) if o.has_key?("username")
      app.password(o["password"]) if o.has_key?("password")
      app.plans(o["plans"]) if o.has_key?("plans")
      app.created_at(o["created_at"]) if o.has_key?("created_at")

      app
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      app = self.new(tmp_email, tmp_api_key, tmp_host)
      app.from_hash(o)
      app
    end

    def from_hash(o)
      @name           = o["name"] if o.has_key?("name")
      @id             = o["id"] if o.has_key?("id")
      @cattype        = o["cattype"] if o.has_key?("cattype")
      @order          = o["order"] if o.has_key?("order")
      @image          = o["image"] if o.has_key?("image")
      @url            = o["url"] if o.has_key?("url")
      @host           = o["host"] if o.has_key?("host")
      @port           = o["port"]  if o.has_key?("port")
      @username       = o["username"] if o.has_key?("username")
      @password       = o["password"] if o.has_key?("password")
      @plans          = o["plans"] if o.has_key?("plans")
      @created_at     = o["created_at"] if o.has_key?("created_at")
      self
    end

    def self.create(params)
      acct = from_hash(params, params["email"], params["api_key"], params["host"])
      acct.create
    end

    # Create the marketplace app via the REST API
    def create
      megam_rest.post_marketplaceapp(to_hash)
    end

    # Load a account by email_p
    def self.show(params)
      app = self.new(params["email"], params["api_key"], params["host"])
      app.megam_rest.get_marketplaceapp(params["id"])
    end

    def self.list(params)
      app = self.new(params["email"], params["api_key"], params["host"])
      app.megam_rest.get_marketplaceapps
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end
