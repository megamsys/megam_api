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
    def initialize(email=nil, api_key=nil)
      @id = nil
      @name =nil
      @tosca_type = nil
      @requirements = {}
      @host = nil
      @dummy = nil
      @inputs = {}
      @domain = nil
      @port = nil
      @username = nil
      @password = nil
      @version = nil
      @source = nil
      @design_inputs = nil
      @x = nil
      @y = nil
      @z = nil
      @wires = []
      @service_inputs = nil
      @dbname = nil
      @dbpassword = nil
      @external_management_resource = nil
      @artifacts = {}
      @artifact_type = nil
      @content = nil
      @artifact_requirements = nil
      @related_components = nil
      @operations = {}
      @operation_type = nil
      @target_resource = nil
      @created_at = nil

      super(email, api_key)
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

    def requirements(arg=nil)
      if arg != nil
        @requirements = arg
      else
      @requirements
      end
    end

    def host(arg=nil)
      if arg != nil
        @host = arg
      else
      @host
      end
    end

    def dummy(arg=nil)
      if arg != nil
        @dummy = arg
      else
      @dummy
      end
    end

    def inputs(arg=[])
      if arg != []
        @inputs = arg
      else
      @inputs
      end
    end

    def domain(arg=nil)
      if arg != nil
        @domain = arg
      else
      @domain
      end
    end

    def port(arg=nil)
      if arg != nil
        @port = arg
      else
      @port
      end
    end

    def username(arg=nil)
      if arg != nil
        @username = arg
      else
      @username
      end
    end

    def password(arg=nil)
      if arg != nil
        @password = arg
      else
      @password
      end
    end

    def version(arg=nil)
      if arg != nil
        @version = arg
      else
      @version
      end
    end

    def source(arg=nil)
      if arg != nil
        @source = arg
      else
      @source
      end
    end

    def design_inputs(arg=nil)
      if arg != nil
        @design_inputs = arg
      else
      @design_inputs
      end
    end

    def x(arg=nil)
      if arg != nil
        @x = arg
      else
      @x
      end
    end

    def y(arg=nil)
      if arg != nil
        @y = arg
      else
      @y
      end
    end

    def z(arg=nil)
      if arg != nil
        @z = arg
      else
      @z
      end
    end

    def wires(arg=nil)
      if arg != nil
        @wires = arg
      else
      @wires
      end
    end

    def service_inputs(arg=nil)
      if arg != nil
        @service_inputs = arg
      else
      @service_inputs
      end
    end

    def dbname(arg=nil)
      if arg != nil
        @dbname = arg
      else
      @dbname
      end
    end

    def dbpassword(arg=nil)
      if arg != nil
        @dbpassword = arg
      else
      @dbpassword
      end
    end

    def external_management_resource(arg=nil)
      if arg != nil
        @external_management_resource = arg
      else
      @external_management_resource
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

    def artifact_requirements(arg=nil)
      if arg != nil
        @artifact_requirements = arg
      else
      @artifact_requirements
      end
    end

    def related_components(arg=nil)
      if arg != nil
        @related_components = arg
      else
      @related_components
      end
    end

    def operations(arg=nil)
      if arg != nil
        @operations = arg
      else
      @operations
      end
    end

    def operation_type(arg=nil)
      if arg != nil
        @operation_type = arg
      else
      @operation_type
      end
    end

    def target_resource(arg=nil)
      if arg != nil
        @target_resource = arg
      else
      @target_resource
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
      index_hash["requirements"] = requirements
      index_hash["inputs"] = inputs
      index_hash["external_management_resource"] = external_management_resource
      index_hash["artifacts"] = artifacts
      index_hash["related_components"] = related_components
      index_hash["operations"] = operations
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
        "requirements" => requirements,
        "inputs" => inputs,
        "external_management_resource" => external_management_resource,
        "artifacts" => artifacts,
        "related_components" => related_components,
        "operations" => operations,
        "created_at" => created_at
      }
      result
    end

    def self.json_create(o)
      asm = new
      asm.id(o["id"]) if o.has_key?("id")
      asm.name(o["name"]) if o.has_key?("name")
      asm.tosca_type(o["tosca_type"]) if o.has_key?("tosca_type")

      oq = o["requirements"]
      asm.requirements[:host] = oq["host"] if oq && oq.has_key?("host")
      asm.requirements[:dummy] = oq["dummy"] if oq && oq.has_key?("dummy")

      inp = o["inputs"]
      asm.inputs[:domain] = inp["domain"] if inp && inp.has_key?("domain")
      asm.inputs[:port] = inp["port"] if inp && inp.has_key?("port")
      asm.inputs[:username] = inp["username"] if inp && inp.has_key?("username")
      asm.inputs[:password] = inp["password"] if inp && inp.has_key?("password")
      asm.inputs[:version] = inp["version"] if inp && inp.has_key?("version")
      asm.inputs[:source] = inp["source"] if inp && inp.has_key?("source")
      asm.inputs[:design_inputs] = inp["design_inputs"] if inp && inp.has_key?("design_inputs")
      asm.inputs[:service_inputs] = inp["service_inputs"] if inp && inp.has_key?("service_inputs")
      # ind = inp["design_inputs"]
      #  asm.inputs["design_inputs"][:did] = ind["did"] if ind && ind.has_key?("did")
      # asm.inputs[:design_inputs][:x] = ind["x"] if ind && ind.has_key?("x")
      # asm.inputs[:design_inputs][:y] = ind["y"] if ind && ind.has_key?("y")
      #  asm.inputs[:design_inputs][:z] = ind["z"] if ind && ind.has_key?("z")
      #  asm.inputs[:design_inputs][:wires] = ind["wires"] if ind && ind.has_key?("wires")
      #  ins = o["inputs"]["service_inputs"]
      #  asm.inputs[:service_inputs][:dbname] = ins["dbname"] if ins && ins.has_key?("dbname")
      # asm.inputs[:service_inputs][:dbpassword] = ins["dbpassword"] if ins && ins.has_key?("dbpassword")

      asm.external_management_resource(o["external_management_resource"]) if o.has_key?("external_management_resource")

      ar = o["artifacts"]
      asm.artifacts[:artifact_type] = ar["artifact_type"] if ar && ar.has_key?("artifact_type")
      asm.artifacts[:content] = ar["content"] if ar && ar.has_key?("content")
      asm.artifacts[:artifact_requirements] = ar["artifact_requirements"] if ar && ar.has_key?("artifact_requirements")

      asm.related_components(o["related_components"]) if o.has_key?("related_components")

      ope = o["operations"]
      asm.operations[:operation_type] = ope["operation_type"] if ope && ope.has_key?("operation_type")
      asm.operations[:target_resource] = ope["target_resource"] if ope && ope.has_key?("target_resource")

      asm.created_at(o["created_at"]) if o.has_key?("created_at")
      asm
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil)
      asm = self.new(tmp_email, tmp_api_key)
      asm.from_hash(o)
      asm
    end

    def from_hash(o)
      @id                              = o["id"] if o.has_key?("id")
      @name                            = o["name"] if o.has_key?("name")
      @tosca_type                      = o["tosca_type"] if o.has_key?("tosca_type")
      @inputs                          = o["inputs"] if o.has_key?("inputs")
      @external_management_resource    = o["external_management_resource"] if o.has_key?("external_management_resource")
      @artifacts                       = o["artifacts"] if o.has_key?("artifacts")
      @related_components              = o["related_components"] if o.has_key?("related_components")
      @operations                      = o["operations"] if o.has_key?("operations")
      @created_at                      = o["created_at"] if o.has_key?("created_at")
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil)
      asm = from_hash(o, tmp_email, tmp_api_key)
      asm.create
    end

    # Load a account by email_p
    def self.show(comp_id, tmp_email=nil, tmp_api_key=nil)
      asm = self.new(tmp_email, tmp_api_key)
      asm.megam_rest.get_components(comp_id)
    end

    def self.update(o,tmp_email=nil, tmp_api_key=nil)
      asm = from_hash(o, tmp_email, tmp_api_key)
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