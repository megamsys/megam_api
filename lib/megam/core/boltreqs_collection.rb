# Copyright:: Copyright (c) 2012, 2013 Megam Systems
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
  class BoltreqsCollection
    include Enumerable

    
    attr_reader :iterator
    def initialize
      @boltreqs = Array.new
      @boltreqs_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_boltreqs
      @boltreqs
    end

    def [](index)
      @boltreqs[index]
    end

    def []=(index, arg)
      is_megam_boltreq(arg)
      @boltreqs[index] = arg
      @boltreqs_by_name[arg.id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_boltreq(a)
        @boltreqs << a
        @boltreqs_by_name[a.id] = @boltreqs.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(boltreq)
      is_megam_boltreq(boltreq)
      if @insert_after_idx
        # in the middle of executing a run, so any boltreqss inserted now should
        # be placed after the most recent addition done by the currently executing
        # boltreqs
        @boltreqs.insert(@insert_after_idx + 1, boltreq)
        # update name -> location mboltings and register new boltreqs
        @boltreqs_by_name.each_key do |key|
        @boltreqs_by_name[key] += 1 if @boltreqs_by_name[key] > @insert_after_idx
        end
        @boltreqs_by_name[boltreq.id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @boltreqs << boltreq
      @boltreqs_by_name[boltreq.id] = @boltreqs.length - 1 
      end
    end

    def each
      @boltreqs.each do |boltreq|
        yield boltreq
      end
    end

    def each_index
      @boltreqs.each_index do |i|
        yield i
      end
    end

    def empty?
      @boltreqs.empty?
    end

    def lookup(boltreq)
      lookup_by = nil
      if boltreq.kind_of?(Megam::Boltreqs)
      lookup_by = boltreq.id
      elsif boltreq.kind_of?(String)
      lookup_by = boltreq
      else
        raise ArgumentError, "Must pass a Megam::Boltreqs or String to lookup"
      end
      res = @boltreqs_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a boltreq matching #{lookup_by} (did you define it first?)"
      end
      @boltreqs[res]
    end
    
     # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |boltreq|
        index_hash[boltreq.id] = boltreq.to_s
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
      o["results"].each do |boltreqs_list|
       boltreqs_array = boltreqs_list.kind_of?(Array) ? boltreqs_list : [ boltreqs_list ]
        boltreqs_array.each do |boltreq|
          collection.insert(boltreq)
        end
      end
      collection
    end

    private

    
    
    def is_megam_boltreq(arg)
      unless arg.kind_of?(Megam::Boltreqs)
        raise ArgumentError, "Members must be Megam::Boltreq's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
