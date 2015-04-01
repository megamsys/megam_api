# Copyright:: Copyright (c) 2012, 2015 Megam Systems
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
  class Event < Megam::ServerAPI
    def initialize(email=nil, api_key=nil)
      @id = nil
      @name = nil
      @command = nil
      @type = nil
      super(email, api_key)
    end

    def event
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

   

    
    def command(arg=[])
      if arg != []
        @command = arg
      else
      @command
      end
    end

    def type(arg=nil)
      if arg != nil
        @type = arg
      else
      @type
      end
    end

    def error?
      crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["id"] = id
      index_hash["name"] = name
      index_hash["command"] = command
      index_hash["type"] = type
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
        "command" => command,
        "type" => type
        }
      result
    end

    def self.json_create(o)
      event = new
      event.id(o["id"]) if o.has_key?("id")
      event.name(o["name"]) if o.has_key?("name")
      event.command(o["command"]) if o.has_key?("command")
      event.type(o["type"]) if o.has_key?("type") #this will be an array? can hash store array?
      event
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil)
      event = self.new(tmp_email, tmp_api_key)
      event.from_hash(o)
      event
    end

    def from_hash(o)
      @id                = o["id"] if o.has_key?("id")
      @name              = o["name"] if o.has_key?("name")
      @command      = o["command"] if o.has_key?("command")
      @type        = o["type"] if o.has_key?("type")
     self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil)
      event = from_hash(o, tmp_email, tmp_api_key)
      event.create
    end

    # Create the node via the REST API
    def create
      puts "Creating new event! weehaaa!"
      megam_rest.post_event(to_hash)
    end

   

    def self.list(tmp_email=nil, tmp_api_key=nil, inflated=false)
      event = self.new(tmp_email, tmp_api_key)
      event.megam_rest.get_events
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
