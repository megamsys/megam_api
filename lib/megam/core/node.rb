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
  class Node

    # Each notify entry is a resource/action pair, modeled as an
    # Struct with a #resource and #action member
    def initialize
      @id = nil
      @accounts_id = nil
      @command = nil
      @request ={}
      @predefs={}
      @some_msg = {}
    end

    def node
      self
    end

    def megam_rest
      Megam::API.new(Megam::Config[:email], Megam::Config[:api_key])
    end
    
    def node_name(arg=nil)
      if arg != nil
        @node_name = arg
      else
      @node_name
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
      index_hash["request"] = request
      index_hash["predefs"] = predefs
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
        "request" => request,
        "predefs" => predefs
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
      node.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")
      #requests
      oq = o["request"]
      node.request[:req_id] = oq["req_id"] if oq.has_key?("req_id")
      node.request[:command] = oq["command"] if oq.has_key?("command")
      #predef
      op = o["predefs"]
      node.predefs[:name] = op["name"] if op.has_key?("name")
      node.predefs[:scm] = op["scm"] if op.has_key?("scm")
      node.predefs[:war]= op["war"] if op.has_key?("war")
      node.predefs[:db] = op["db"] if op.has_key?("db")
      node.predefs[:queue] = op["queue"] if op.has_key?("queue")
      #success or error
      node.some_msg[:code] = o["code"] if o.has_key?("code")
      node.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      node.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      node.some_msg[:links] = o["links"] if o.has_key?("links")
      node
    end

    def self.from_hash(o)
      acct = self.new()
      acct.from_hash(o)
      acct
    end

    def from_hash(o)
      @node_name = o[:node_name] if o.has_key?(:node_name)
      @command   = o[:command] if o.has_key?(:command)
      @id        = o[:id] if o.has_key?(:id)
      @email     = o[:accounts_id] if o.has_key?(:accounts_id)
      @request   = o[:request] if o.has_key?(:request)
      @predefs   = o[:predefs] if o.has_key?(:predefs)
      self
    end

    def self.create
      node = build
      node.create
    end

    #
    #build the node as per the need
    def self.build
      payload = {:node_name => self.node_name, :command => self.command, :predefs => self.predefs }
      from_hash(payload)
    end
    
     # Create the node via the REST API
    def create(node_input)
      megam_rest.post_nodes(node_input)
      self
    end

    # Load a account by email_p
    def self.show(node_name)
      megam_rest.get_nodes(node_name)
      self
    end

  
    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end