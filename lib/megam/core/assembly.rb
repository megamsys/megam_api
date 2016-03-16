# Copyright:: Copyright (c) 2013-2016 Megam Systems
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
  class Assembly < Megam::ServerAPI
    def initialize(o)
      @id = nil
      @asms_id = nil
      @name = nil
      @components = []
      @tosca_type = nil
      @policies = []
      @inputs = []
      @outputs = []
      @status = nil
      @created_at = nil

      super(o)
    end

    def assembly
      self
    end

    def id(arg = nil)
      if !arg.nil?
        @id = arg
      else
        @id
      end
    end

    def asms_id(arg=nil)
      if arg != nil
        @asms_id = arg
      else
      @asms_id
      end
    end

    def name(arg = nil)
      if !arg.nil?
        @name = arg
      else
        @name
      end
    end

    def tosca_type(arg = nil)
      if !arg.nil?
        @tosca_type = arg
      else
        @tosca_type
      end
    end

    def components(arg = [])
      if arg != []
        @components = arg
      else
        @components
      end
    end

    def policies(arg = [])
      if arg != []
        @policies = arg
      else
        @policies
      end
    end

    def inputs(arg = [])
      if arg != []
        @inputs = arg
      else
        @inputs
      end
    end

    def outputs(arg = [])
      if arg != []
        @outputs = arg
      else
        @outputs
      end
    end

    def status(arg = nil)
      if !arg.nil?
        @status = arg
      else
        @status
      end
    end

    def created_at(arg = nil)
      if !arg.nil?
        @created_at = arg
      else
        @created_at
       end
      end

    def error?
      crocked = true if some_msg.key?(:msg_type) && some_msg[:msg_type] == 'error'
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = {}
      index_hash['json_claz'] = self.class.name
      index_hash['id'] = id
      index_hash["asms_id"] = asms_id
      index_hash['name'] = name
      index_hash['components'] = components
      index_hash['tosca_type'] = tosca_type
      index_hash['policies'] = policies
      index_hash['inputs'] = inputs
      index_hash['outputs'] = outputs
      index_hash['status'] = status
      index_hash['created_at'] = created_at
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

    def for_json
      result = {
        'id' => id,
        'name' => name,
        'components' => components,
        'tosca_type' => tosca_type,
        'policies' => policies,
        'inputs' => inputs,
        'outputs' => outputs,
        'status' => status,
        'created_at' => created_at
      }

      result
    end

    def self.json_create(o)
      asm = new({})
      asm.id(o['id']) if o.key?('id')
      asm.asms_id(o["asms_id"]) if o.has_key?("asms_id")
      asm.name(o['name']) if o.key?('name')
      asm.components(o['components']) if o.key?('components')
      asm.tosca_type(o['tosca_type']) if o.key?('tosca_type')
      asm.policies(o['policies']) if o.key?('policies') # this will be an array? can hash store array?
      asm.inputs(o['inputs']) if o.key?('inputs')
      asm.outputs(o['outputs']) if o.key?('outputs')
      asm.status(o['status']) if o.key?('status')
      asm.created_at(o['created_at']) if o.key?('created_at')
      asm
    end

    def self.from_hash(o)
      asm = new(o)
      asm.from_hash(o)
      asm
    end

    def from_hash(o)
      @id                = o['id'] if o.key?('id')
      @asms_id           = o["asms_id"] if o.has_key?("asms_id")
      @name              = o['name'] if o.key?('name')
      @components        = o['components'] if o.key?('components')
      @tosca_type        = o['tosca_type'] if o.key?('tosca_type')
      @policies          = o['policies'] if o.key?('policies')
      @inputs            = o['inputs'] if o.key?('inputs')
      @outputs           = o['outputs'] if o.key?('outputs')
      @status            = o['status'] if o.key?('status')
      @created_at        = o['created_at'] if o.key?('created_at')
      self
    end

    def self.show(params)
      asm = new(params)
      asm.megam_rest.get_one_assembly(params['id'])
    end

    def self.update(params)
      asm = from_hash(params)
      asm.update
   end

   def self.upgrade(params)
     asm = from_hash(params)
     asm.megam_rest.upgrade_assembly(params['id'])
   end

    # Create the node via the REST API
    def update
      megam_rest.update_assembly(to_hash)
    end   

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end
  end
end

