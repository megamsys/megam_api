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
  class Sensor < Megam::ServerAPI
    def initialize(email = nil, api_key = nil, host = nil)
      @id = nil
      @sensor_type = nil
      @payload = {}
      @created_at = nil
      super(email, api_key, host)
    end

    def sensor
      self
    end

    def id(arg = nil)
      if !arg.nil?
        @id = arg
      else
        @id
      end
    end



    def sensor_type(arg = nil)
      if !arg.nil?
        @sensor_type = arg
      else
        @sensor_type
      end
    end

    def payload(arg = nil)
      if !arg.nil?
        @payload = arg
      else
        @payload
      end
    end

=begin
    def accounts_id(arg = nil)
      if !arg.nil?
        @accounts_id = arg
      else
        @accounts_id
      end
    end

    def assemblies_id(arg = nil)
      if !arg.nil?
        @assemblies_id = arg
      else
        @assemblies_id
      end
    end

    def assembly_id(arg = nil)
      if !arg.nil?
        @assembly_id = arg
      else
        @assembly_id
      end
    end

    def components_id(arg = nil)
      if !arg.nil?
       @components_id = arg
     else
       @components_id
     end
   end

      def state(arg = nil)
        if !arg.nil?
          @state = arg
        else
          @state
        end
      end


    def metrics(arg = [])
      if arg != []
        @metrics = arg
      else
        @metrics
      end
    end

    def source(arg = nil)
      if !arg.nil?
        @source = arg
      else
        @source
      end
   end

   def one(arg = nil)
     if !arg.nil?
       @one = arg
     else
       @one
     end
   end

  def docker(arg = nil)
    if !arg.nil?
      @docker = arg
    else
      @docker
    end
  end

  def ceph(arg = nil)
    if !arg.nil?
      @ceph = arg
    else
      @ceph
    end
  end

def node(arg = nil)
  if !arg.nil?
    @node = arg
  else
    @node
  end
end

def message(arg = nil)
  if !arg.nil?
    @message = arg
  else
    @message
  end
end

def audit_period_begining(arg = nil)
  if !arg.nil?
    @audit_period_begining = arg
  else
    @audit_period_begining
  end
end

def audit_period_ending(arg = nil)
  if !arg.nil?
    @audit_period_ending = arg
  else
    @audit_period_ending
  end
end



=end



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

      index_hash['sensor_type'] = sensor_type
      index_hash['payload'] = payload
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
        'sensor_type' => sensor_type,
        'payload' => payload,
        'created_at' => created_at
      }
      result
    end

    def self.json_create(o)
      asm = new
      asm.id(o['id']) if o.key?('id')
      asm.sensor_type(o['sensor_type']) if o.key?('sensor_type')
          asm.payload(o['payload']) if o.key?('payload')
          asm.created_at(o['created_at']) if o.key?('created_at')
      asm
    end

    def self.from_hash(o, tmp_email = nil, tmp_api_key = nil, tmp_host = nil)
      asm = new(tmp_email, tmp_api_key, tmp_host)
      asm.from_hash(o)
      asm
    end

    def from_hash(o)
      @id                              = o['id'] if o.key?('id')
      @sensor_type                      = o['sensor_type'] if o.key?('sensor_type')
      @payload                      = o['payload'] if o.key?('payload')
      @created_at                      = o['created_at'] if o.key?('created_at')
      self
    end

    def self.create(params)
      asm = from_hash(params, params['email'], params['api_key'], params['host'])
      asm.create
    end

    # Load a account by email_p
    def self.show(params)
      asm = new(params['email'], params['api_key'], params['host'])
      asm.megam_rest.get_components(params['id'])
    end

    def self.update(params)
      asm = from_hash(params, params['email'] || params[:email], params['api_key'] || params[:api_key], params['host'] || params[:host])
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
