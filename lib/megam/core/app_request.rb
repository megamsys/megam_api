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
  class AppRequest < Megam::ServerAPI
    def initialize(email=nil, api_key=nil)
      @id = nil
      @app_id = nil
      @app_name = nil
      @action = nil
      @some_msg = {}
      @created_at = nil
      super(email, api_key)
    end

    def app_request
      self
    end

    
    def id(arg=nil)
      if arg != nil
        @id = arg
      else
      @id
      end
    end

    def app_id(arg=nil)
      if arg != nil
        @app_id = arg
      else
      @app_id
      end
    end
    
    def app_name(arg=nil)
      if arg != nil
        @app_name = arg
      else
      @app_name
      end
    end

    def action(arg=nil)
      if arg != nil
        @action = arg
      else
      @action
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
      index_hash["app_id"] = app_id
      index_hash["app_name"] = app_name
      index_hash["action"] = action      
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
        "app_id" => app_id,
        "app_name" => app_name,
        "action" => action,       
        "created_at" => created_at
      }
      result
    end

    #
    def self.json_create(o)
      node = new
      node.id(o["id"]) if o.has_key?("id")
      node.app_id(o["app_id"]) if o.has_key?("app_id")
      node.app_name(o["app_name"]) if o.has_key?("app_name")
      node.action(o["action"]) if o.has_key?("action")     
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
      @id = o[:id] if o.has_key?(:id)
      @app_id  = o[:app_id] if o.has_key?(:app_id)
      @app_name  = o[:app_name] if o.has_key?(:app_name)
      @action  = o[:action] if o.has_key?(:action)     
      @created_at       = o[:created_at] if o.has_key?(:created_at)      
      self
    end


    def self.create(o,tmp_email=nil, tmp_api_key=nil)
      acct = from_hash(o,tmp_email, tmp_api_key)
      acct.create
    end

    # Create the node via the REST API
    def create
      megam_rest.post_apprequest(to_hash)
    end   


    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end
