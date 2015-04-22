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
  class CredithistoriesCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @credithistories = Array.new
      @credithistories_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_credithistories
      @credithistories
    end

    def [](index)
      @credithistories[index]
    end

    def []=(index, arg)
      is_megam_credithistories(arg)
      @credithistories[index] = arg
      @credithistories_by_name[arg.repo_name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_credithistories(a)
        @credithistories << a
        @credithistories_by_name[a.repo_name] =@credithistories.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(credithistories)
      is_megam_credithistories(credithistories)
      if @insert_after_idx
        # in the middle of executing a run, so any credithistories inserted now should
        # be placed after the most recent addition done by the currently executing
        # credithistories
        @credithistories.insert(@insert_after_idx + 1, credithistories)
        # update name -> location mappings and register new credithistories
        @credithistories_by_name.each_key do |key|
        @credithistories_by_name[key] += 1 if@credithistories_by_name[key] > @insert_after_idx
        end
        @credithistories_by_name[credithistories.repo_name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @credithistories << credithistories
      @credithistories_by_name[credithistories.repo_name] =@credithistories.length - 1
      end
    end

    def each
      @credithistories.each do |credithistories|
        yield credithistories
      end
    end

    def each_index
      @credithistories.each_index do |i|
        yield i
      end
    end

    def empty?
      @credithistories.empty?
    end

    def lookup(credithistories)
      lookup_by = nil
      if credithistories.kind_of?(Megam::Credithistories)
      lookup_by = credithistories.repo_name
      elsif credithistories.kind_of?(String)
      lookup_by = credithistories
      else
        raise ArgumentError, "Must pass a Megam::credithistories or String to lookup"
      end
      res =@credithistories_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a credithistories matching #{lookup_by} (did you define it first?)"
      end
      @credithistories[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |credithistories|
        index_hash[credithistories.repo_name] = credithistories.to_s
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
      o["results"].each do |credithistories_list|
        credithistories_array = credithistories_list.kind_of?(Array) ? credithistories_list : [ credithistories_list ]
        credithistories_array.each do |credithistories|
          collection.insert(credithistories)
        end
      end
      collection
    end

    private

    def is_megam_credithistories(arg)
      unless arg.kind_of?(Megam::Credithistories)
        raise ArgumentError, "Members must be Megam::Credithistories"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end