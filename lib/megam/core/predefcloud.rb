
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
  class PredefCloud
    # Each notify entry is a resource/action pair, modeled as an
    # Struct with a #resource and #action member
    def initialize
      @id = nil
      @name = nil
      @accounts_id = nil
      @spec = {}
      @access = {}
      #@ideal=nil
      #@performance = nil
      @created_at = nil
      @some_msg = {}
    end

    def predef_cloud
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

    def spec(arg=nil)
      if arg != nil
        @spec = arg
      else
      @spec
      end
    end

    def access(arg=nil)
      if arg != nil
        @access = arg
      else
      @access
      end
    end

    def ideal(arg=nil)
      if arg != nil
        @ideal= arg
      else
      @ideal
      end
    end

    def performance(arg=nil)
      if arg != nil
        @performance= arg
      else
      @performance
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
      index_hash["spec"] = spec
      index_hash["access"] = access
      #index_hash["ideal"] = ideal
      #index_hash["performance"] = performance
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
        "spec" => spec,
        "access" => access,
        #"ideal" => ideal,
        #"performance" => performance,
        "created_at" => created_at
      }
      result
    end

    #
    def self.json_create(o)
      predefcd = new
      predefcd.id(o["id"]) if o.has_key?("id")
      predefcd.name(o["name"]) if o.has_key?("name")
      #requests
      oq = o["spec"]
      predefcd.spec[:type_name] = oq["type_name"] if oq && oq.has_key?("type_name")
      predefcd.spec[:groups] = oq["groups"] if oq && oq.has_key?("groups")
      predefcd.spec[:image] = oq["image"] if oq && oq.has_key?("image")
      predefcd.spec[:flavor] = oq["flavor"] if oq && oq.has_key?("flavor")
      #predef
      op = o["access"]
      predefcd.access[:ssh_key] = op["ssh_key"] if op && op.has_key?("ssh_key")
      predefcd.access[:identity_file] = op["identity_file"] if op && op.has_key?("identity_file")
      predefcd.access[:ssh_user]= op["ssh_user"] if op && op.has_key?("ssh_user")
      #access
      #predefcd.ideal(o["ideal"]) if o.has_key?("ideal")
      #predefcd.performance(o["performance"]) if o.has_key?("performance")
      predefcd.created_at(o["created_at"]) if o.has_key?("created_at")
      #success or error
      predefcd.some_msg[:code] = o["code"] if o.has_key?("code")
      predefcd.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      predefcd.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      predefcd.some_msg[:links] = o["links"] if o.has_key?("links")
      predefcd
    end

    def self.from_hash(o)
      predefcd = self.new()
      predefcd.from_hash(o)
      predefcd
    end

    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @name = o[:name] if o.has_key?(:name)
      @spec   = o[:spec] if o.has_key?(:spec)
      @access     = o[:access] if o.has_key?(:access)
      #@ideal   = o[:ideal] if o.has_key?(:ideal)
      #@performance   = o[:performance] if o.has_key?(:performance)
      @created_at   = o[:created_at] if o.has_key?(:created_at)
      self
    end

    def self.create(o)
      acct = from_hash(o)
      acct.create
    end

    # Create the predef via the REST API
    def create
      megam_rest.post_predefcloud(to_hash)
    end

    # Load all predefs -
    # returns a PredefsCollection
    # don't return self. check if the Megam::PredefCollection is returned.
    def self.list
    predef = self.new()
      predef.megam_rest.get_predefclouds
    end

    # Show a particular predef by name,
    # Megam::Predef
    def self.show(p_name)
    pre = self.new()
      pre.megam_rest.get_predefcloud(p_name)
      self
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end
