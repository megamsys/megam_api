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
  class Components < Megam::ServerAPI
    def initialize(email=nil, api_key=nil, host=nil)
      @id = nil
      @name =nil
      @tosca_type = nil
      @inputs = []
      @outputs = []      
      @artifacts = {}
      @artifact_type = nil
      @content = nil
      @artifact_requirements = []
      @related_components = []
      @operations = []
      @status = nil
      @created_at = nil

      super(email, api_key, host)
    end

    def components
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

    def tosca_type(arg=nil)
      if arg != nil
        @tosca_type = arg
      else
      @tosca_type
      end
    end
    
    def inputs(arg=[])
      if arg != []
        @inputs = arg
      else
      @inputs
      end
    end
    
    def outputs(arg=[])
      if arg != []
        @outputs = arg
      else
      @outputs
      end
    end

    def artifacts(arg=nil)
      if arg != nil
        @artifacts = arg
      else
      @artifacts
      end
    end

    def artifact_type(arg=nil)
      if arg != nil
        @artifact_type = arg
      else
      @artifact_type
      end
    end

    def content(arg=nil)
      if arg != nil
        @content = arg
      else
      @content
      end
    end

    def artifact_requirements(arg=[])
      if arg != []
        @artifact_requirements = arg
      else
      @artifact_requirements
      end
    end

    def related_components(arg=[])
      if arg != []
        @related_components = arg
      else
      @related_components
      end
    end

    def operations(arg=[])
      if arg != []
        @operations = arg
      else
      @operations
      end
    end
    
     def status(arg=nil)
      if arg != nil
        @status = arg
      else
      @status
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
      index_hash["tosca_type"] = tosca_type
      index_hash["inputs"] = inputs
      index_hash["outputs"] = outputs
      index_hash["artifacts"] = artifacts
      index_hash["related_components"] = related_components
      index_hash["operations"] = operations
      index_hash["status"] = status
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
        "tosca_type" => tosca_type,
        "inputs" => inputs,
        "outputs" => outputs,
        "artifacts" => artifacts,
        "related_components" => related_components,
        "operations" => operations,
        "status" => status,
        "created_at" => created_at
      }
      result
    end

    def self.json_create(o)
      asm = new
      asm.id(o["id"]) if o.has_key?("id")
      asm.name(o["name"]) if o.has_key?("name")
      asm.tosca_type(o["tosca_type"]) if o.has_key?("tosca_type")
      asm.inputs(o["inputs"]) if o.has_key?("inputs")
      asm.outputs(o["outputs"]) if o.has_key?("outputs")

      ar = o["artifacts"]
      asm.artifacts[:artifact_type] = ar["artifact_type"] if ar && ar.has_key?("artifact_type")
      asm.artifacts[:content] = ar["content"] if ar && ar.has_key?("content")
      asm.artifacts[:artifact_requirements] = ar["artifact_requirements"] if ar && ar.has_key?("artifact_requirements")

      asm.related_components(o["related_components"]) if o.has_key?("related_components")
      asm.operations(o["operations"]) if o.has_key?("operations")      
      asm.status(o["status"]) if o.has_key?("status")
      asm.created_at(o["created_at"]) if o.has_key?("created_at")
      asm
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      asm = self.new(tmp_email, tmp_api_key, tmp_host)
      asm.from_hash(o)
      asm
    end

    def from_hash(o)
      @id                              = o["id"] if o.has_key?("id")
      @name                            = o["name"] if o.has_key?("name")
      @tosca_type                      = o["tosca_type"] if o.has_key?("tosca_type")
      @inputs                          = o["inputs"] if o.has_key?("inputs")
      @outputs                         = o["outputs"] if o.has_key?("outputs")
      @artifacts                       = o["artifacts"] if o.has_key?("artifacts")
      @related_components              = o["related_components"] if o.has_key?("related_components")
      @operations                      = o["operations"] if o.has_key?("operations")
      @status                          = o["status"] if o.has_key?("status")
      @created_at                      = o["created_at"] if o.has_key?("created_at")
      self
    end

    def self.create(params)
      asm = from_hash(params, params["email"], params["api_key"], params["host"])
      asm.create
    end

    # Load a account by email_p
    def self.show(params)
      asm = self.new(params["email"], params["api_key"], params["host"])
      asm.megam_rest.get_components(params["id"])
    end

    def self.update(params)
      asm = from_hash(params, params["email"] || params[:email], params["api_key"] || params[:api_key], params["host"] || params[:host])
      asm.update
    end

    # Create the node via the REST API
    def update
      megam_rest.update_component(to_hash)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end