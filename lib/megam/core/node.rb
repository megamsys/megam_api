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
  class Node < Megam::ServerAPI
    def initialize(email=nil, api_key=nil)
      @id = nil
      @node_name = nil
      @accounts_id = nil
      @node_type = nil
      @req_type = nil
      @status=nil
      @noofinstances=0
      @request ={}
      @predefs={}
      @some_msg = {}
      @command = Hashie::Mash.new
      @appdefnsid = nil
      @boltdefnsid = nil
      @appdefns = {}
      @boltdefns = {}
      @created_at = nil
      super(email, api_key)
    end

    def node
      self
    end

    
    def node_name(arg=nil)
      if arg != nil
        @node_name = arg
      else
      @node_name
      end
    end

    def noofinstances(arg=nil)
      if arg != nil
        @noofinstances = arg
      else
      @noofinstances
      end
    end

    def command(arg=nil)
      if arg != nil
        @command = arg
      else
      @command
      end
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
        @accounts_id = arg
      else
      @accounts_id
      end
    end

    def node_type(arg=nil)
      if arg != nil
        @node_type = arg
      else
      @node_type
      end
    end

    def req_type(arg=nil)
      if arg != nil
        @req_type = arg
      else
      @req_type
      end
    end

    def status(arg=nil)
      if arg != nil
        @status = arg
      else
      @status
      end
    end

    def request(arg=nil)
      if arg != nil
        @request = arg
      else
      @request
      end
    end

    def predefs(arg=nil)
      if arg != nil
        @predefs = arg
      else
      @predefs
      end
    end

    def appdefns(arg=nil)
      if arg != nil
        @appdefns = arg
      else
      @appdefns
      end
    end

    def boltdefns(arg=nil)
      if arg != nil
        @boltdefns = arg
      else
      @boltdefns
      end
    end

    def appdefnsid(arg=nil)
      if arg != nil
        @appdefnsid = arg
      else
      @appdefnsid
      end
    end

    def boltdefnsid(arg=nil)
      if arg != nil
        @boltdefnsid = arg
      else
      @boltdefnsid
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
      index_hash["node_name"] = node_name
      index_hash["accounts_id"] = accounts_id
      index_hash["node_type"] = node_type
      index_hash["req_type"] = req_type
      index_hash["status"] = status
      index_hash["command"] = command
      index_hash["request"] = request
      index_hash["predefs"] = predefs
      index_hash["appdefns"] = appdefns
      index_hash["boltdefns"] = boltdefns
      index_hash["some_msg"] = some_msg
      index_hash["noofinstances"] = noofinstances.to_i
      index_hash["appdefnsid"] = appdefnsid
      index_hash["boltdefnsid"] = boltdefnsid
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
        "node_name" => node_name,
        "accounts_id" => accounts_id,
        "node_type" => node_type,
        "req_type" => req_type,
        "status" => status,
        "request" => request,
        "predefs" => predefs,
        "appdefns" => appdefns,
        "boltdefns" => boltdefns,
        "appdefnsid" => appdefnsid,
        "boltdefnsid" => boltdefnsid,
        "noofinstances" => noofinstances,
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
      node.node_name(o["node_name"]) if o.has_key?("node_name")
      node.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")
      node.node_type(o["node_type"]) if o.has_key?("node_type")
      node.req_type(o["req_type"]) if o.has_key?("req_type")
      node.status(o["status"]) if o.has_key?("status")
      node.appdefnsid(o["appdefnsid"]) if o.has_key?("appdefnsid")
      node.boltdefnsid(o["boltdefnsid"]) if o.has_key?("boltdefnsid")
      node.noofinstances(o["noofinstances"]) if o.has_key?("noofinstances")
      node.created_at(o["created_at"]) if o.has_key?("created_at")
      #requests
      oq = o["request"]
      node.request[:req_id] = oq["req_id"] if oq && oq.has_key?("req_id")
      node.request[:req_type] = oq["req_type"] if oq && oq.has_key?("req_type")
      node.request[:command] = oq["command"] if oq && oq.has_key?("command")

      #Command
=begin
node.command[:systemprovider][:provider][:prov] = oc["systemprovider"]["provider"]["prov"]
node.command[:compute][:cctype] = oc["compute"]["cctype"]
node.command[:compute][:cc][:groups] = oc["compute"]["cc"]["groups"]
node.command[:compute][:cc][:image] = oc["compute"]["cc"]["image"]
node.command[:compute][:cc][:flavor] = oc["compute"]["cc"]["flavor"]
node.command[:compute][:access][:ssh_key] = oc["compute"]["access"]["ssh_key"]
node.command[:compute][:access][:identity_file] = oc["compute"]["access"]["identity_file"]
node.command[:compute][:access][:ssh_user] = oc["compute"]["access"]["ssh_user"]
node.command[:cloudtool][:chef][:command] = oc["cloudtool"]["chef"]["command"]
node.command[:cloudtool][:chef][:plugin] = oc["cloudtool"]["chef"]["plugin"]
node.command[:cloudtool][:chef][:run_list] = oc["cloudtool"]["chef"]["run_list"]
node.command[:cloudtool][:chef][:name] = oc["cloudtool"]["chef"]["name"]
=end
      #predef
      op = o["predefs"]
      node.predefs[:name] = op["name"] if op && op.has_key?("name")
      node.predefs[:scm] = op["scm"] if op && op.has_key?("scm")
      node.predefs[:war]= op["war"] if op && op.has_key?("war")
      node.predefs[:db] = op["db"] if op && op.has_key?("db")
      node.predefs[:queue] = op["queue"] if op && op.has_key?("queue")

      #APP DEFINITIONS
      op = o["appdefns"]
      node.appdefns[:timetokill] = op["timetokill"] if op && op.has_key?("timetokill")
      node.appdefns[:metered] = op["metered"] if op && op.has_key?("metered")
      node.appdefns[:logging]= op["logging"] if op && op.has_key?("logging")
      node.appdefns[:runtime_exec] = op["runtime_exec"] if op && op.has_key?("runtime_exec")

      #BOLT DEFINITIONS
      op = o["boltdefns"]
      node.boltdefns[:username] = op["username"] if op && op.has_key?("username")
      node.boltdefns[:apikey] = op["apikey"] if op && op.has_key?("apikey")
      node.boltdefns[:store_name]= op["store_name"] if op && op.has_key?("store_name")
      node.boltdefns[:url] = op["url"] if op && op.has_key?("url")
      node.boltdefns[:timetokill] = op["timetokill"] if op && op.has_key?("timetokill")
      node.boltdefns[:metered] = op["metered"] if op && op.has_key?("metered")
      node.boltdefns[:logging]= op["logging"] if op && op.has_key?("logging")
      node.boltdefns[:runtime_exec] = op["runtime_exec"] if op && op.has_key?("runtime_exec")

      #success or error
      node.some_msg[:code] = o["code"] if o.has_key?("code")
      node.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      node.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      node.some_msg[:links] = o["links"] if o.has_key?("links")

      node
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil)
      node = self.new(tmp_email, tmp_api_key)
      node.from_hash(o)
      node
    end

    def from_hash(o)
      @node_name = o["node_name"] if o.has_key?("node_name")
      @command   = o["command"] if o.has_key?("command")
      @id        = o["id"] if o.has_key?("id")
      @accounts_id    = o["accounts_id"] if o.has_key?("accounts_id")
      @node_type    = o["node_type"] if o.has_key?("node_type")
      @req_type    = o["req_type"] if o.has_key?("req_type")
      @request   = o["request"] if o.has_key?("request")
      @predefs   = o["predefs"] if o.has_key?("predefs")
      @appdefns   = o["appdefns"] if o.has_key?("appdefns")
      @boltdefns   = o["boltdefns"] if o.has_key?("boltdefns")
      @appdefnsid   = o["appdefnsid"] if o.has_key?("appdefnsid")
      @boltdefnsid   = o["boltdefnsid"] if o.has_key?("boltdefnsid")
      @noofinstances        = o["noofinstances"] if o.has_key?("noofinstances")
      @created_at        = o["created_at"] if o.has_key?("created_at")
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil)
      acct = from_hash(o, tmp_email, tmp_api_key)
      acct.create
    end

    # Create the node via the REST API
    def create
      megam_rest.post_node(to_hash)
    end

    # Load a account by email_p
    def self.show(node_name, tmp_email=nil, tmp_api_key=nil)
      node = self.new(tmp_email, tmp_api_key)
      node.megam_rest.get_node(node_name)
    end

    def self.list(tmp_email=nil, tmp_api_key=nil)
      node = self.new(tmp_email, tmp_api_key)
      node.megam_rest.get_nodes
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end
