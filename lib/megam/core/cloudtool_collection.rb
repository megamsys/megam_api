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
  class CloudToolCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @cloudtools = Array.new
      @cloudtools_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_cloudtools
      @cloudtools
    end

    def [](index)
      @cloudtools[index]
    end

    def []=(index, arg)
      is_megam_cloudtool(arg)
      @cloudtools[index] = arg
      @cloudtools_by_name[arg.name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_cloudtool(a)
        @cloudtools << a
        @cloudtools_by_name[a.name] =@cloudtools.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(cloudtool)
      is_megam_cloudtool(cloudtool)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # cloudtools
        @cloudtools.insert(@insert_after_idx + 1, cloudtool)
        # update name -> location mappings and register new cloudtools
        @cloudtools_by_name.each_key do |key|
        @cloudtools_by_name[key] += 1 if@cloudtools_by_name[key] > @insert_after_idx
        end
        @cloudtools_by_name[cloudtool.name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @cloudtools << cloudtool
      @cloudtools_by_name[cloudtool.name] =@cloudtools.length - 1
      end
    end

    def each
      @cloudtools.each do |cloudtool|
        yield cloudtool
      end
    end

    def each_index
      @cloudtools.each_index do |i|
        yield i
      end
    end

    def empty?
      @cloudtools.empty?
    end

    def lookup(cloudtool)
      lookup_by = nil
      if cloudtool.kind_of?(Megam::CloudTool)
      lookup_by = cloudtool.name
      elsif cloudtool.kind_of?(String)
      lookup_by = cloudtool
      else
        raise ArgumentError, "Must pass a Megam::CloudTools or String to lookup"
      end
      res =@cloudtools_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a cloudtools matching #{lookup_by} (did you define it first?)"
      end
      @cloudtools[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |cloudtool|
        index_hash[cloudtool.name] = cloudtool.to_s
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
      o["results"].each do |cloudtools_list|
        cloudtools_array = cloudtools_list.kind_of?(Array) ? cloudtools_list : [ cloudtools_list ]
        cloudtools_array.each do |cloudtool|
          collection.insert(cloudtool)
        end
      end
      collection
    end

    private

    def is_megam_cloudtool(arg)
      unless arg.kind_of?(Megam::CloudTool)
        raise ArgumentError, "Members must be Megam::CloudTool's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
