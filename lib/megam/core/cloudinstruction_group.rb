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
  class CloudInstructionGroup
    def initialize
      @group = nil
      @cloud_instructions_array = nil
    end

    def cloudinstruction_group
      self
    end

    def group(arg=nil)
      if arg != nil
        @group = arg
      else
      @group
      end
    end
    
    def cloud_instructions_array(arg=nil)
      if arg != nil
        @cloud_instructions_array = arg
      else
      @cloud_instructions_array
      end
    end


    def error?
      crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
    end



    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["json_claz"] = self.class.name
      index_hash["group"] = group
      cloud_instructions_array.each do |single_cig|
        index_hash[""] = single_cig
      end
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

    def for_json
      result = {
        "group" => group
      }
      result
    end

    #
    def self.json_create(o)
      cloudinstruction_group = new
      cloudinstruction_group.group(o["group"]) if o.has_key?("group")
      cloudinstruction_group.cloud_instructions_array(o["results"]) if o.has_key?("results")
      cloudinstruction_group
    end

    def self.from_hash(o)
      cloudinstruction_group = self.new()
      cloudinstruction_group.from_hash(o)
      cloudinstruction_group
    end

    def from_hash(o)
      @group  = o[:group] if o.has_key?(:group)
      @cloudinstructions = o[:cloud_instructions_array] if o.has_key?(:cloud_instructions_array)
      self
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
