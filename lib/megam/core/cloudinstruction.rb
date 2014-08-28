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
  class CloudInstruction
    def initialize
      @action = nil
      @command = nil
      @name = nil
    end

    def cloud_instruction
      self
    end

   
    def action(arg=nil)
      if arg != nil
        @action = arg
      else
      @action
      end
    end

    def command(arg=nil)
      if arg != nil
        @command = arg
      else
      @command
      end
    end

    def name(arg=nil)
      if arg != nil
        @name = arg
      else
      @name
      end
    end

     def error?
      crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["json_claz"] = self.class.name
      index_hash["action"] = action
      index_hash["command"] = command
      index_hash["name"] = name
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

    def for_json
      result = {
        "action" => action,
        "command" => command,
        "name" => name
      }
      result
    end

    #
    def self.json_create(o)
      cloudinstruction = new
      cloudinstruction.action(o["action"]) if o.has_key?("action")
      cloudinstruction.command(o["command"]) if o.has_key?("command")
      cloudinstruction.name(o["name"]) if o.has_key?("name")      
      cloudinstruction
    end

    def self.from_hash(o)
      cloudinstruction = self.new()
      cloudinstruction.from_hash(o)
      cloudinstruction
    end

    def from_hash(o)
      @action   = o[:action] if o.has_key?(:action)
      @command   = o[:command] if o.has_key?(:command)
      @name  = o[:name] if o.has_key?(:name)
      self
    end

    
    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end