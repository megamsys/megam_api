# Copyright:: Copyright (c) 2012, 2014 Megam Systems
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by csarlicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module Megam
  class CSARCollection
    include Enumerable


    attr_reader :iterator
    def initialize
      @csars = Array.new
      @csars_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_csars
      @csars
    end

    def [](index)
      @csars[index]
    end

    def []=(index, arg)
      is_megam_csar(arg)
      @csars[index] = arg
      @csars_by_name[arg.name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_csar(a)
        @csars << a
        @csars_by_name[a.name] = @csars.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(csar)
      is_megam_csar(csar)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @csars.insert(@insert_after_idx + 1, csar)
        # update name -> location mcsarings and register new node
        @csars_by_name.each_key do |key|
        @csars_by_name[key] += 1 if @csars_by_name[key] > @insert_after_idx
        end
        @csars_by_name[csar.link] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @csars << csar
      @csars_by_name[csar.link] = @csars.length - 1
      end
    end

    def each
      @csars.each do |csar|
        yield csar
      end
    end

    def each_index
      @csars.each_index do |i|
        yield i
      end
    end

    def empty?
      @csars.empty?
    end

    def lookup(csar)
      lookup_by = nil
      if csar.kind_of?(Megam::CSAR)
      lookup_by = csar.link
      elsif csar.kind_of?(String)
      lookup_by = csar
      else
        raise ArgumentError, "Must pass a Megam::CSAR or String to lookup"
      end
      res = @csars_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a csar matching #{lookup_by} (did you define it first?)"
      end
      @csars[res]
    end

     # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |csar|
        index_hash[csar.link] = csar.to_s
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
      o["results"].each do |csars_list|
        csars_array = csars_list.kind_of?(Array) ? csars_list : [ csars_list ]
        csars_array.each do |csar|
          collection.insert(csar)
        end
      end
      collection
    end

    private



    def is_megam_csar(arg)
      unless arg.kind_of?(Megam::CSAR)
        raise ArgumentError, "Members must be Megam::CSAR's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
