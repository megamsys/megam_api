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
  class Boltdefns
    # Each notify entry is a resource/action pair, modeled as an
    # Struct with a #resource and #action member
=begin
  def self.hash_tree
    Hash.new do |hash, key|
      hash[key] = hash_tree
    end
  end
=end

    def initialize
      @id = nil
      @node_id = nil
      @node_name = nil
      @boltdefns ={}
      @created_at = nil
    end
    def node
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

    def boltdefns(arg=nil)
      if arg != nil
        @boltdefns = arg
      else
      @boltdefns
      end
    end


    def created_at(arg=nil)
      if arg != nil
        @created_at = arg
      else
      @created_at
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
      index_hash["boltdefns"] = boltdefns
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
        "node_id" => node_id,
        "node_name" => node_name,
        "boltdefns" => boltdefns,
        "created_at" => created_at
      }
      result
    end

    # Create a Megam::Node from NodeResult-JSON
    #
    #[{
    #"id":"NOD362212018897289216",
    #"accounts_id":"ACT362211962353876992",
    #"json_claz":"Megam::Node",
    #"request":{
    #"req_id":"NOD362212018897289216",
    #"command":"commands"
    #},
    #"predefs":{
    #"name":"",
    #"scm":"",
    #"war":"",
    #"db":"",
    #"queue":""
    #}
    #}]
    #
    def self.json_create(o)
      node = new
      node.id(o["id"]) if o.has_key?("id")
      node.node_id(o["node_id"]) if o.has_key?("node_id")
      node.node_name(o["node_name"]) if o.has_key?("node_name")
      node.created_at(o["created_at"]) if o.has_key?("created_at")


      #APP DEFINITIONS
      op = o["boltdefns"]
      node.boltdefns[:username] = op["username"] if op && op.has_key?("username")
      node.boltdefns[:apikey] = op["apikey"] if op && op.has_key?("apikey")
      node.boltdefns[:store_name]= op["store_name"] if op && op.has_key?("store_name")
      node.boltdefns[:url] = op["url"] if op && op.has_key?("url")
      node.boltdefns[:prime] = op["prime"] if op && op.has_key?("prime")

      node.boltdefns[:timetokill] = op["timetokill"] if op && op.has_key?("timetokill")
      node.boltdefns[:metered] = op["metered"] if op && op.has_key?("metered")
      node.boltdefns[:logging]= op["logging"] if op && op.has_key?("logging")
      node.boltdefns[:runtime_exec] = op["runtime_exec"] if op && op.has_key?("runtime_exec")
      node
    end

    def self.from_hash(o)
      node = self.new()
      node.from_hash(o)
      node
    end

    def from_hash(o)
      @id        = o["id"] if o.has_key?("id")
      @node_id    = o["node_id"] if o.has_key?("node_id")
      @node_name = o["node_name"] if o.has_key?("node_name")
      @boltdefns   = o["boltdefns"] if o.has_key?("boltdefns")
      @created_at        = o["created_at"] if o.has_key?("created_at")
      self
    end

    def self.create(o)
      acct = from_hash(o)
      acct.create
    end

    # Create the node via the REST API
    def create
      megam_rest.post_boltdefn(to_hash)
    end

    # Load a account by email_p
    def self.show(node_name)
      megam_rest.get_boltdefn(node_name)
      self
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end
