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
  class CloudInstructionCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @cloudinstructions = Array.new
      @cloudinstructions_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_cloudinstructions
      @cloudinstructions
    end

    def [](index)
      @cloudinstructions[index]
    end

    def []=(index, arg)
      is_megam_cloudinstruction(arg)
      @cloudinstructions[index] = arg
      @cloudinstructions_by_name[arg.action] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_cloudinstruction(a)
        @cloudinstructions << a
        @cloudinstructions_by_name[a.action] =@cloudinstructions.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(cloudinstruction)
      is_megam_cloudinstruction(cloudinstruction)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # cloudinstructions
        @cloudinstructions.insert(@insert_after_idx + 1, cloudinstruction)
        # update name -> location mappings and register new cloudinstructions
        @cloudinstructions_by_name.each_key do |key|
        @cloudinstructions_by_name[key] += 1 if@cloudinstructions_by_name[key] > @insert_after_idx
        end
        @cloudinstructions_by_name[cloudinstruction.action] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @cloudinstructions << cloudinstruction
      @cloudinstructions_by_name[cloudinstruction.action] =@cloudinstructions.length - 1
      end
    end

    def each
      @cloudinstructions.each do |cloudinstruction|
        yield cloudinstruction
      end
    end

    def each_index
      @cloudinstructions.each_index do |i|
        yield i
      end
    end

    def empty?
      @cloudinstructions.empty?
    end

    def lookup(cloudinstruction)
      lookup_by = nil
      if cloudinstruction.kind_of?(Megam::CloudInstruction)
      lookup_by = cloudinstruction.action
      elsif cloudinstruction.kind_of?(String)
      lookup_by = cloudinstruction
      else
        raise ArgumentError, "Must pass a Megam::CloudInstruction or String to lookup"
      end
      res =@cloudinstructions_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a cloudinstruction matching #{lookup_by} (did you define it first?)"
      end
      @cloudinstructions[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |cloudinstruction|
        index_hash[cloudinstruction.action] = cloudinstruction
      end
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end


    def self.json_create(o)
      collection = self.new()
      o["results"].each do |cloudinstructions_list|
        cloudinstructions_array = cloudinstructions_list.kind_of?(Array) ? cloudinstructions_list : [ cloudinstructions_list ]
        cloudinstructions_array.each do |cloudinstruction|
          collection.insert(cloudinstruction)
        end
      end
      collection
    end

    private

    def is_megam_cloudinstruction(arg)
      unless arg.kind_of?(Megam::CloudInstruction)
        raise ArgumentError, "Members must be Megam::CloudInstruction's"
      end
      true
    end

    def to_s      
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end