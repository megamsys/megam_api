
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
  class SshKey < Megam::ServerAPI
    def initialize(email=nil, api_key=nil)
      @id = nil
      @name = nil
      @accounts_id = nil      
      @path=nil      
      @created_at = nil
      @some_msg = {}
      super(email, api_key)
    end

    def sshkey
      self
    end

    
    def id(arg=nil)
      if arg != nil
        @id = arg
      else
      @id
      end
    end

    def name(arg=nil)
      if arg != nil
        @name = arg
      else
      @name
      end
    end

    def accounts_id(arg=nil)
      if arg != nil
        @accounts_id= arg
      else
      @accounts_id
      end
    end
    

    def path(arg=nil)
      if arg != nil
        @path= arg
      else
      @path
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
      index_hash["accounts_id"] = accounts_id
      index_hash["path"] = path     
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
        "accounts_id" => accounts_id,
        "path" => path,        
        "created_at" => created_at
      }
      result
    end

    #
    def self.json_create(o)
      sshKey = new
      sshKey.id(o["id"]) if o.has_key?("id")
      sshKey.name(o["name"]) if o.has_key?("name")     
      sshKey.path(o["path"]) if o.has_key?("path")     
      sshKey.created_at(o["created_at"]) if o.has_key?("created_at")
      #success or error
      sshKey.some_msg[:code] = o["code"] if o.has_key?("code")
      sshKey.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      sshKey.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      sshKey.some_msg[:links] = o["links"] if o.has_key?("links")
      sshKey
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil)
      sshKey = self.new(tmp_email, tmp_api_key)
      sshKey.from_hash(o)
      sshKey
    end

    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @name = o[:name] if o.has_key?(:name)      
      @path   = o[:path] if o.has_key?(:path)   
      @created_at   = o[:created_at] if o.has_key?(:created_at)
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil)
      acct = from_hash(o,tmp_email, tmp_api_key)
      acct.create
    end

    # Create the predef via the REST API
    def create
      megam_rest.post_sshkey(to_hash)
    end

    # Load all sshkeys -
    # returns a sshkeysCollection
    # don't return self. check if the Megam::SshKeyCollection is returned.
    def self.list(tmp_email=nil, tmp_api_key=nil)
    sshKey = self.new(tmp_email,tmp_api_key)
      sshKey.megam_rest.get_sshkeys
    end

    # Show a particular sshKey by name,
    # Megam::SshKey
    def self.show(p_name,tmp_email=nil, tmp_api_key=nil)
    pre = self.new(tmp_email,tmp_api_key)
    pre.megam_rest.get_sshkey(p_name)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end
