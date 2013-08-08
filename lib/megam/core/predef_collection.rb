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
  class PredefCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @predefs = Array.new
      @predefs_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_predefs
      @predefs
    end

    def [](index)
      @predefs[index]
    end

    def []=(index, arg)
      is_megam_predef(arg)
      @predefs[index] = arg
      @predefs_by_name[arg.name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_predef(a)
        @predefs << a
        @predefs_by_name[a.name] = @predefs.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(predef)
      is_megam_predef(predef)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # predef
        @predefs.insert(@insert_after_idx + 1, predef)
        # update name -> location mappings and register new predef
        @predefs_by_name.each_key do |key|
        @predefs_by_name[key] += 1 if @predefs_by_name[key] > @insert_after_idx
        end
        @predefs_by_name[predef.name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @predefs << predef
      @predefs_by_name[predef.name] = @predefs.length - 1
      end
    end

    def each
      @predefs.each do |predef|
        yield predef
      end
    end

    def each_index
      @predefs.each_index do |i|
        yield i
      end
    end

    def empty?
      @predefs.empty?
    end

    def lookup(predef)
      lookup_by = nil
      if predef.kind_of?(Megam::Predef)
      lookup_by = predef.name
      elsif predef.kind_of?(String)
      lookup_by = predef
      else
        raise ArgumentError, "Must pass a Megam::Predef or String to lookup"
      end
      res = @predefs_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a predef matching #{lookup_by} (did you define it first?)"
      end
      @predefs[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |predef|
        index_hash[predef.name] = predef.to_s
      end
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

=begin
{
  "json_claz":"Megam::PredefCollection",
  "results":[{
    "id":"PRE362554468593565696",
    "name":"rabbitmq",
    "provider":"chef",
    "provider_role":"rabbitmq",
    "build_monkey":"none",
    "json_claz":"Megam::Predef"
  },{
    "id":"PRE362554470090932224",
    "name":"mobhtml5",
    "provider":"chef",
    "provider_role":"sencha",
    "build_monkey":"none",
    "json_claz":"Megam::Predef"
  }]
}
=end
    def self.json_create(o)
      collection = self.new()
      o["results"].each do |predefs_list|
        predefs_array = predefs_list.kind_of?(Array) ? predefs_list : [ predefs_list ]
        predefs_array.each do |predef|
          collection.insert(predef)
        end
      end
      collection
    end

    private

    def is_megam_predef(arg)
      unless arg.kind_of?(Megam::Predef)
        raise ArgumentError, "Members must be Megam::Predef's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end