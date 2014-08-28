# Copyright:: Copyright (c) 2012, 2014 Megam Systems
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by boltlicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module Megam
  class BoltdefnsCollection
    include Enumerable

    
    attr_reader :iterator
    def initialize
      @boltdefns = Array.new
      @boltdefns_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_boltdefns
      @boltdefns
    end

    def [](index)
      @boltdefns[index]
    end

    def []=(index, arg)
      is_megam_boltdefn(arg)
      @boltdefns[index] = arg
      @boltdefns_by_name[arg.id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_boltdefn(a)
        @boltdefns << a
        @boltdefns_by_name[a.id] = @boltdefns.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(boltdefn)
      is_megam_boltdefn(boltdefn)
      if @insert_after_idx
        # in the middle of executing a run, so any boltdefnss inserted now should
        # be placed after the most recent addition done by the currently executing
        # boltdefns
        @boltdefns.insert(@insert_after_idx + 1, boltdefn)
        # update name -> location mappings and register new boltdefns
        @boltdefns_by_name.each_key do |key|
        @boltdefns_by_name[key] += 1 if @boltdefns_by_name[key] > @insert_after_idx
        end
        @boltdefns_by_name[boltdefn.id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @boltdefns << boltdefn
      @boltdefns_by_name[boltdefn.id] = @boltdefns.length - 1 
      end
    end

    def each
      @boltdefns.each do |boltdefn|
        yield boltdefn
      end
    end

    def each_index
      @boltdefns.each_index do |i|
        yield i
      end
    end

    def empty?
      @boltdefns.empty?
    end

    def lookup(boltdefn)
      lookup_by = nil
      if boltdefn.kind_of?(Megam::Boltdefns)
      lookup_by = boltdefn.id
      elsif boltdefn.kind_of?(String)
      lookup_by = boltdefn
      else
        raise ArgumentError, "Must pass a Megam::Boltdefns or String to lookup"
      end
      res = @boltdefns_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a boltdefn matching #{lookup_by} (did you define it first?)"
      end
      @boltdefns[res]
    end
    
     # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |boltdefn|
        index_hash[boltdefn.id] = boltdefn.to_s
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
      o["results"].each do |boltdefns_list|
       boltdefns_array = boltdefns_list.kind_of?(Array) ? boltdefns_list : [ boltdefns_list ]
        boltdefns_array.each do |boltdefn|
          collection.insert(boltdefn)
        end
      end
      collection
    end

    private

    
    
    def is_megam_boltdefn(arg)
      unless arg.kind_of?(Megam::Boltdefns)
        raise ArgumentError, "Members must be Megam::Boltdefn's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
