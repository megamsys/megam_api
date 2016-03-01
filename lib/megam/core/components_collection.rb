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
  class ComponentsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @components = Array.new
      @components_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_components
      @components
    end

    def [](index)
      @components[index]
    end

    def []=(index, arg)
      is_megam_components(arg)
      @components[index] = arg
      @components_by_name[arg.name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_components(a)
        @components << a
        @components_by_name[a.name] = @components.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(components)
      is_megam_components(components)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @components.insert(@insert_after_idx + 1, components)
        # update name -> location mappings and register new node
        @components_by_name.each_key do |key|
        @components_by_name[key] += 1 if @components_by_name[key] > @insert_after_idx
        end
        @components_by_name[components.name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @components << components
      @components_by_name[components.name] = @components.length - 1
      end
    end

    def each
      @components.each do |components|
        yield components
      end
    end

    def each_index
      @components.each_index do |i|
        yield i
      end
    end

    def empty?
      @components.empty?
    end

    def lookup(components)
      lookup_by = nil
      if components.kind_of?(Megam::Components)
      lookup_by = components.name
      elsif components.kind_of?(String)
      lookup_by = components
      else
        raise ArgumentError, "Must pass a Megam::components or String to lookup"
      end
      res = @components_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @components[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |components|
        index_hash[components.name] = components.to_s
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
      o["results"].each do |components_list|
        components_array = components_list.kind_of?(Array) ? components_list : [ components_list ]
        components_array.each do |components|
          collection.insert(components)

        end
      end
      collection
    end

    private

    def is_megam_components(arg)
      unless arg.kind_of?(Megam::Components)
        raise ArgumentError, "Members must be Megam::components"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
