
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
  class Assemblies < Megam::ServerAPI
    def initialize(email=nil, api_key=nil)
       @id = nil
       @accounts_id = nil
       @name = nil
       @assemblies = []
       @assemblies_type = []
       @label = nil
       @cloudsettings = []
       @inputs = nil
       @created_at = nil
       super(email, api_key)
    end



    def assemblies
      self
    end

  def assemblies_type(arg=nil)
        if arg != nil
            @assemblies_type = arg
        else
         @assemblies_type
       end
  end

  def label(arg=nil)
     if arg != nil
         @label = arg
      else
        @label
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

    def name(arg=nil)
      if arg != nil
        @name = arg
      else
      @name
      end
    end



    def assemblies(arg=[])
      if arg != []
        @assemblies = arg
      else
      @assemblies
      end
    end

   def cloudsettings(arg=[])
      if arg != []
          @cloudsettings = arg
       else
         @cloudsettings
       end
  end

   def input(arg=nil)
      if arg != nil
        @input = arg
      else
        @input
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
      index_hash["name"] = name
      index_hash["accounts_id"] = accounts_id
      index_hash["assemblies"] = assemblies
      index_hash["assemblies_type"] = assemblies_type
      index_hash["label"] = label
      index_hash["cloudsettings"] = cloudsettings
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
        "assemblies" => assemblies,
        "assemblies_type" => assemblies_type,
        "label" => label,
        "cloudsettings" => cloudsettings,
        "input" => input,
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
    

      asm = new
      asm.id(o["id"]) if o.has_key?("id")
      asm.name(o["name"]) if o.has_key?("name")
      asm.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")
      asm.assemblies(o["assemblies"]) if o.has_key?("assemblies") #this will be an array? can hash store array?


      oq = o["inputs"]
      asm.inputs[:id] = oq["id"] if oq && oq.has_key?("id")
      asm.inputs[:assemblies_type] = oq["assemblies_type"] if oq && oq.has_key?("assemblies_type")
      asm.inputs[:label] = oq["label"] if oq && oq.has_key?("label")
      asm.inputs[:cloudsettings] = oq["cloudsettings"] if oq && oq.has_key?("cloudsettings")

      asm.created_at(o["created_at"]) if o.has_key?("created_at")
      asm
   end



    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil)
      asm = self.new(tmp_email, tmp_api_key)
      asm.from_hash(o)
      asm
    end

    def from_hash(o)
      @id                = o["id"] if o.has_key?("id")
      @name              = o["name"] if o.has_key?("name")
      @accounts_id       = o["accounts_id"] if o.has_key?("accounts_id")
      @assemblies        = o["assemblies"] if o.has_key?("assemblies")
      @assemblies_type   = o["assemblies_type"] if o.has_key?("assemblies_type")
      @cloudsettings     = o["cloudsettings"] if o.has_key?("cloudsettings")
      @input             = o["input"] if o.has_key?("input")
      @label             = o["label"] if o.has_key?("label")
      @created_at        = o["created_at"] if o.has_key?("created_at")
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil)
      asm = from_hash(o, tmp_email, tmp_api_key)
      asm.create
    end

    # Create the node via the REST API
    def create
      megam_rest.post_assemblies(to_hash)
    end

    # Load a account by email_p
    def self.show(node_name, tmp_email=nil, tmp_api_key=nil)
      asm = self.new(tmp_email, tmp_api_key)
      asm.megam_rest.get_assemblies(node_name)
    end

    def self.list(tmp_email=nil, tmp_api_key=nil)
      asm = self.new(tmp_email, tmp_api_key)
      asm.megam_rest.get_assemblies
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end
end
end
