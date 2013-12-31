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
  class Appdefns
    # Each notify entry is a resource/action pair, modeled as an
    # Struct with a #resource and #action member

    def initialize
      @id = nil
      @node_id = nil
      @node_name = nil
      @appdefns ={}
      @created_at = nil
      @some_msg = {}
    end

    def appdefns
      self
    end

    def megam_rest
      options = { :email => Megam::Config[:email], :api_key => Megam::Config[:api_key]}
      Megam::API.new(options)
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

    def appdefns(arg=nil)
      if arg != nil
        @appdefns = arg
      else
      @appdefns
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
      index_hash["appdefns"] = appdefns
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
        "appdefns" => appdefns,
        "created_at" => created_at
      }
      result
    end

    
    def self.json_create(o)
      appdefns = new
      appdefns.id(o["id"]) if o.has_key?("id")
      appdefns.node_id(o["node_id"]) if o.has_key?("node_id")
      appdefns.node_name(o["node_name"]) if o.has_key?("node_name")
      appdefns.created_at(o["created_at"]) if o.has_key?("created_at")

      #APP DEFINITIONS
      op = o["appdefns"]
      appdefns.appdefns[:timetokill] = op["timetokill"] if op && op.has_key?("timetokill")
      appdefns.appdefns[:metered] = op["metered"] if op && op.has_key?("metered")
      appdefns.appdefns[:logging]= op["logging"] if op && op.has_key?("logging")
      appdefns.appdefns[:runtime_exec] = op["runtime_exec"] if op && op.has_key?("runtime_exec")

      appdefns.some_msg[:code] = o["code"] if o.has_key?("code")
      appdefns.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      appdefns.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      appdefns.some_msg[:links] = o["links"] if o.has_key?("links")

      appdefns
    end

    def self.from_hash(o)
      appdefns = self.new()
      appdefns.from_hash(o)
      appdefns
    end

    def from_hash(o)
      @id        = o["id"] if o.has_key?("id")
      @node_id    = o["node_id"] if o.has_key?("node_id")
      @node_name = o["node_name"] if o.has_key?("node_name")
      @appdefns   = o["appdefns"] if o.has_key?("appdefns")
      @created_at        = o["created_at"] if o.has_key?("created_at")
      self
    end

    def self.create(o)
      acct = from_hash(o)
      acct.create
    end

    # Create the node via the REST API
    def create
      megam_rest.post_appdefn(to_hash)
    end

    # Load a account by email_p
    def self.show(id)
      appdefns = self.new()
      appdefns.megam_rest.get_appdefn(id)
    end
    
    # Load a account by email_p
    def self.shown(node_name, id)
      appdefns = self.new()
      appdefns.megam_rest.get_appdefn(node_name,id)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
