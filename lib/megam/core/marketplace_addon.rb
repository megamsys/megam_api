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
module Megam
  class MarketPlaceAddons< Megam::ServerAPI
    
    def initialize(email=nil, api_key=nil)
      @id = nil
      @node_id = nil
      @node_name = nil
      @marketplace_id = nil
      @config = nil
      @config_id = nil
      @created_at = nil
      @some_msg = {}
      super(email,api_key)
    end
    
    def market_place_addons
      self
    end
    

    def id(arg=nil)
      if arg != nil
        @id = arg
      else
      @id
      end
    end

    def node_id(arg=nil)
      if arg != nil
        @node_id = arg
      else
      @node_id
      end
    end

    def node_name(arg=nil)
      if arg != nil
        @node_name = arg
      else
      @node_name
      end
    end

    def marketplace_id(arg=nil)
      if arg != nil
        @marketplace_id = arg
      else
      @marketplace_id
      end
    end

    def config_id(arg=nil)
      if arg != nil
        @config_id = arg
      else
      @config_id
      end
    end

    def config(arg=nil)
      if arg != nil
        @config = arg
      else
      @config
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
      index_hash["node_id"] = node_id
      index_hash["node_name"] = node_name
      index_hash["marketplace_id"] = marketplace_id
      index_hash["config"] = config
      index_hash["config_id"] = config_id
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
        "node_id" => node_id,
        "node_name" => node_name,
        "marketplace_id" => marketplace_id,
        "config" => {},
        "config_id" => config_id,
        "created_at" => created_at
      }     
      result
    end


    def self.json_create(o)
      addon = new
      addon.id(o["id"]) if o.has_key?("id")
      addon.node_id(o["node_id"]) if o.has_key?("node_id")
      addon.node_name(o["node_name"]) if o.has_key?("node_name")
      addon.marketplace_id(o["marketplace_id"]) if o.has_key?("marketplace_id")
      addon.config(o["config"]) if o.has_key?("config")
      addon.config_id(o["config_id"]) if o.has_key?("config_id")
      addon.created_at(o["created_at"]) if o.has_key?("created_at")        
      
      addon.some_msg[:code] = o["code"] if o.has_key?("code")
      addon.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      addon.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      addon.some_msg[:links] = o["links"] if o.has_key?("links")

      addon
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil)
      addon = self.new(tmp_email, tmp_api_key)
      addon.from_hash(o)
      addon
    end

    def from_hash(o)
      @id        = o["id"] if o.has_key?("id")
      @node_id        = o["node_id"] if o.has_key?("node_id")
      @node_name = o["node_name"] if o.has_key?("node_name")
      @marketplace_id   = o["marketplace_id"] if o.has_key?("marketplace_id")
      @config   = o["config"] if o.has_key?("config")
      @config_id  = o["config_id"] if o.has_key?("config_id")
      @created_at        = o["created_at"] if o.has_key?("created_at")
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil)
      acct = from_hash(o,tmp_email, tmp_api_key)
      acct.create
    end

    # Create the addon via the REST API
    def create
      megam_rest.post_addon(to_hash)
    end

    # Load a account by email_p
    def self.list(node_name,tmp_email=nil, tmp_api_key=nil)
      addon = self.new(tmp_email, tmp_api_key)
      addon.megam_rest.get_addons(node_name)
      #self
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
