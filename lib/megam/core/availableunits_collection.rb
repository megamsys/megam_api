##
## Copyright [2013-2015] [Megam Systems]
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
module Megam
  class AvailableunitsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @availableunits = Array.new
      @availableunits_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_availableunits
      @availableunits
    end

    def [](index)
      @availableunits[index]
    end

    def []=(index, arg)
      is_megam_availableunits(arg)
      @availableunits[index] = arg
      @availableunits_by_name[arg.name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_availableunits(a)
        @availableunits << a
        @availableunits_by_name[a.name] =@availableunits.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(availableunits)
      is_megam_availableunits(availableunits)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # availableunits
        @availableunits.insert(@insert_after_idx + 1, availableunits)
        # update name -> location mappings and register new availableunits
        @availableunits_by_name.each_key do |key|
        @availableunits_by_name[key] += 1 if@availableunits_by_name[key] > @insert_after_idx
        end
        @availableunits_by_name[availableunits.name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @availableunits << availableunits
      @availableunits_by_name[availableunits.name] =@availableunits.length - 1
      end
    end

    def each
      @availableunits.each do |availableunits|
        yield availableunits
      end
    end

    def each_index
      @availableunits.each_index do |i|
        yield i
      end
    end

    def empty?
      @availableunits.empty?
    end

    def lookup(availableunits)
      lookup_by = nil
      if availableunits.kind_of?(Megam::Availableunits)
      lookup_by = availableunits.name
      elsif availableunits.kind_of?(String)
      lookup_by = availableunits
      else
        raise ArgumentError, "Must pass a Megam::Availableunits or String to lookup"
      end
      res =@availableunits_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a availableunits matching #{lookup_by} (did you define it first?)"
      end
      @availableunits[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |availableunits|
        index_hash[availableunits.name] = availableunits.to_s
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
      o["results"].each do |availableunits_list|
        availableunits_array = availableunits_list.kind_of?(Array) ? availableunits_list : [ availableunits_list ]
        availableunits_array.each do |availableunits|
          collection.insert(availableunits)
        end
      end
      collection
    end

    private

    def is_megam_availableunits(arg)
      unless arg.kind_of?(Megam::Availableunits)
        raise ArgumentError, "Members must be Megam::availableunits's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end