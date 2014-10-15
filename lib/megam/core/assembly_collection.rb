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
  class AssemblyCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @assemblys = Array.new
      @assemblys_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_assemblys
      @assemblys
    end

    def [](index)
      @assemblys[index]
    end

    def []=(index, arg)
      is_megam_assemblys(arg)
      @assemblys[index] = arg
      @assemblys_by_name[arg.name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_assemblys(a)
        @assemblys << a
        @assemblys_by_name[a.name] = @assemblys.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(assemblys)
      is_megam_assemblys(assemblys)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @assemblys.insert(@insert_after_idx + 1, assemblys)
        # update name -> location mappings and register new node
        @assemblys_by_name.each_key do |key|
        @assemblys_by_name[key] += 1 if @assemblys_by_name[key] > @insert_after_idx
        end
        @assemblys_by_name[assemblys.name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @assemblys << assemblys
      @assemblys_by_name[assemblys.name] = @assemblys.length - 1
      end
    end

    def each
      @assemblys.each do |assemblys|
        yield assemblys
      end
    end

    def each_index
      @assemblys.each_index do |i|
        yield i
      end
    end

    def empty?
      @assemblys.empty?
    end

    def lookup(assemblys)
      lookup_by = nil
      if assemblys.kind_of?(Megam::Assembly)
      lookup_by = assemblys.name
      elsif assemblys.kind_of?(String)
      lookup_by = assemblys
      else
        raise ArgumentError, "Must pass a Megam::Assemblies or String to lookup"
      end
      res = @assemblys_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @assemblys[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |assemblys|
        index_hash[assemblys.name] = assemblys.to_s
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
      o["results"].each do |assemblys_list|
        assemblys_array = assemblys_list.kind_of?(Array) ? assemblys_list : [ assemblys_list ]
        assemblys_array.each do |assemblys|
          collection.insert(assemblys)

        end
      end
      collection
    end

    private

    def is_megam_assemblys(arg)
      unless arg.kind_of?(Megam::Assembly)
        raise ArgumentError, "Members must be Megam::Assembly's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
