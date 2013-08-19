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
  class CloudTemplate
    def initialize
      @cctype = nil
      @cloud_instruction_group_array = nil
      @cloudinstructiongroup_by_name = Hash.new
      @cloud_instruction_group = nil
      @cloud_instruction_group_by_name = Hash.new
    end

    def cloud_template
      self
    end

    def cctype(arg=nil)
      if arg != nil
        @cctype = arg
      else
      @cctype
      end
    end

    def cloud_instruction_group_array(arg=nil)
      if arg != nil
        @cloud_instruction_group_array = arg
      else
      @cloud_instruction_group_array
      end
    end

    def cloud_instruction_group_by_name(arg=nil)
      if arg != nil
        @cloud_instruction_group_by_name = arg
      else
      @cloud_instruction_group_by_name
      end
    end

    #returns a cloud instruction for a particular group
    def lookup_by_group_name(group)
      res =@cloud_instruction_group_by_name[group]
      unless res
        raise ArgumentError, "Cannot find a cloudgroup matching #{group} (did you define it first?)"
      end
    end

    #returns a cloud instruction for a particular group, action
    def lookup_by_instruction(group,action)
      single_cig = lookup_by_group_name(group)
      single_cig.cloud_instruction_array.select { |cloudinstructions| cloudinstructions.lookup(action) }
    end

    def error?
      crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["json_claz"] = self.class.name
      index_hash["cctype"] = cctype
	puts "======================> BEFORE EACH <================================== "
      cloud_instruction_group_array.each do |single_cig|
	puts "======================> AFTER EACH <================================== "
        index_hash[single_cig.group] = single_cig
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
        "cctype" => cctype,
        "cloud_instruction_group_array" =>  cloud_instruction_group_array
      }
      result
    end

    #
    def self.json_create(o)
      cloudtemplate = new
      cloudtemplate.cctype(o["cctype"]) if o.has_key?("cctype")
      #cloudtemplate.cloud_instruction_group_array(o["cloud_instruction_group"]) if o.has_key?("cloud_instruction_group")

      cloudtemplate.cloud_instruction_group(o["cloud_instruction_group"]) if o.has_key?("cloud_instruction_group")
      cloudtemplate.cloud_instruction_group.each do |single_cig|
        cloudtemplate.cloud_instruction_group_by_name[single_cig.group] = single_cig
      end
      cloudtemplate
    end


    def self.from_hash(o)
      cloudtemplate = self.new()
      cloudtemplate.from_hash(o)
      cloudtemplate
    end

    def from_hash(o)
      @cctype   = o[:cctype] if o.has_key?(:cctype)
      self
    end

    def lookup_cig(single_cloud_instruction_group, action)
	self.cloud_instruction_group_array.each do |single_cig|
	if single_cig.group == single_cloud_instruction_group
		single_cig.cloud_instructions_array.each do |cia|
	puts "TEST 1 ==============================>>>>> "
			cia.each do |ci|
	puts "TEST 2 ==============================>>>>> "
				if ci.action == action
	puts "TEST 3 ==============================>>>>> "
					@ci = ci
				end
			end
			@cloudinstructiongroup_by_name = { single_cloud_instruction_group => single_cig, action => @ci}
		end
     	end
      end
	@cloudinstructiongroup_by_name
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
