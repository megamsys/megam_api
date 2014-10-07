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
  class Request < Megam::ServerAPI
    def initialize(email=nil, api_key=nil)
      @id = nil
      @node_id = nil
      @node_name = nil
      @req_type = nil
      @command =nil
      @some_msg = {}
      @created_at = nil
      super(email, api_key)
    end

    def request
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
    def req_type(arg=nil)
      if arg != nil
        @req_type = arg
      else
      @req_type
      end
    end
    def created_at(arg=nil)
      if arg != nil
        @created_at = arg
      else
      @created_at
      end
    end

    def command(arg=nil)
      if arg != nil
        @command = arg
      else
      @command
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
      index_hash["req_type"] = req_type
      index_hash["command"] = command
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
        "req_type" => req_type,
        "command" => command,
        "created_at" => created_at
      }
      result
    end

    #
    def self.json_create(o)
      node = new
      node.id(o["id"]) if o.has_key?("id")
      node.node_id(o["node_id"]) if o.has_key?("node_id")
      node.node_name(o["node_name"]) if o.has_key?("node_name")
      node.req_type(o["req_type"]) if o.has_key?("req_type")
      node.command(o["command"]) if o.has_key?("command")
      node.created_at(o["created_at"]) if o.has_key?("created_at")
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
      @id = o["id"] if o.has_key?("id")
      @node_id  = o["node_id"] if o.has_key?("node_id")
      @node_name       = o["node_name"] if o.has_key?("node_name")
      @req_type       = o["req_type"] if o.has_key?("req_type")
      @command  = o["command"] if o.has_key?("command")
      @created_at       = o["created_at"] if o.has_key?("created_at")
      self
    end


    def self.create(o,tmp_email=nil, tmp_api_key=nil)
      acct = from_hash(o,tmp_email, tmp_api_key)
      acct.create
    end

    # Create the node via the REST API
    def create
      megam_rest.post_request(to_hash)
    end

    
     def self.show(tmp_email=nil, tmp_api_key=nil)
      prede = self.new(tmp_email, tmp_api_key)
      prede.megam_rest.get_requests
    end

     def self.list(n_name,tmp_email=nil, tmp_api_key=nil)
      prede = self.new(tmp_email,tmp_api_key)
      prede.megam_rest.get_request(n_name)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end
