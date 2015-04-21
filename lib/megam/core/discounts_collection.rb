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
  class DiscountsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @discounts = Array.new
      @discounts_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_discounts
      @discounts
    end

    def [](index)
      @discounts[index]
    end

    def []=(index, arg)
      is_megam_discounts(arg)
      @discounts[index] = arg
      @discounts_by_name[arg.repo_name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_discounts(a)
        @discounts << a
        @discounts_by_name[a.repo_name] =@discounts.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(discounts)
      is_megam_discounts(discounts)
      if @insert_after_idx
        # in the middle of executing a run, so any discounts inserted now should
        # be placed after the most recent addition done by the currently executing
        # discounts
        @discounts.insert(@insert_after_idx + 1, discounts)
        # update name -> location mappings and register new discounts
        @discounts_by_name.each_key do |key|
        @discounts_by_name[key] += 1 if@discounts_by_name[key] > @insert_after_idx
        end
        @discounts_by_name[discounts.repo_name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @discounts << discounts
      @discounts_by_name[discounts.repo_name] =@discounts.length - 1
      end
    end

    def each
      @discounts.each do |discounts|
        yield discounts
      end
    end

    def each_index
      @discounts.each_index do |i|
        yield i
      end
    end

    def empty?
      @discounts.empty?
    end

    def lookup(discounts)
      lookup_by = nil
      if discounts.kind_of?(Megam::Discounts)
      lookup_by = discounts.repo_name
      elsif discounts.kind_of?(String)
      lookup_by = discounts
      else
        raise ArgumentError, "Must pass a Megam::discounts or String to lookup"
      end
      res =@discounts_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a discounts matching #{lookup_by} (did you define it first?)"
      end
      @discounts[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |discounts|
        index_hash[discounts.repo_name] = discounts.to_s
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
      o["results"].each do |discounts_list|
        discounts_array = discounts_list.kind_of?(Array) ? discounts_list : [ discounts_list ]
        discounts_array.each do |discounts|
          collection.insert(discounts)
        end
      end
      collection
    end

    private

    def is_megam_discounts(arg)
      unless arg.kind_of?(Megam::Discounts)
        raise ArgumentError, "Members must be Megam::discounts"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end