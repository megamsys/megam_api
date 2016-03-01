##
## Copyright 2013-2016 Megam Systems
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
  class BilledhistoriesCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @billedhistories = Array.new
      @billedhistories_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_billedhistories
      @billedhistories
    end

    def [](index)
      @billedhistories[index]
    end

    def []=(index, arg)
      is_megam_billedhistories(arg)
      @billedhistories[index] = arg
      @billedhistories_by_name[arg.accounts_id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_billedhistories(a)
        @billedhistories << a
        @billedhistories_by_name[a.accounts_id] =@billedhistories.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(billedhistories)
      is_megam_billedhistories(billedhistories)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # billedhistories
        @billedhistories.insert(@insert_after_idx + 1, billedhistories)
        # update name -> location mappings and register new billedhistories
        @billedhistories_by_name.each_key do |key|
        @billedhistories_by_name[key] += 1 if@billedhistories_by_name[key] > @insert_after_idx
        end
        @billedhistories_by_name[billedhistories.accounts_id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @billedhistories << billedhistories
      @billedhistories_by_name[billedhistories.accounts_id] =@billedhistories.length - 1
      end
    end

    def each
      @billedhistories.each do |billedhistories|
        yield billedhistories
      end
    end

    def each_index
      @billedhistories.each_index do |i|
        yield i
      end
    end

    def empty?
      @billedhistories.empty?
    end

    def lookup(billedhistories)
      lookup_by = nil
      if Billedhistories.kind_of?(Megam::Billedhistories)
      lookup_by = billedhistories.accounts_id
    elsif billedhistories.kind_of?(String)
      lookup_by = billedhistories
      else
        raise ArgumentError, "Must pass a Megam::billedhistories or String to lookup"
      end
      res =@billedhistories_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a billedhistories matching #{lookup_by} (did you define it first?)"
      end
      @billedhistories[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |billedhistories|
        index_hash[billedhistories.accounts_id] = billedhistories.to_s
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
      o["results"].each do |billedhistories_list|
        billedhistories_array = billedhistories_list.kind_of?(Array) ? billedhistories_list : [ billedhistories_list ]
        billedhistories_array.each do |billedhistories|
          collection.insert(billedhistories)
        end
      end
      collection
    end

    private

    def is_megam_billedhistories(arg)
      unless arg.kind_of?(Megam::Billedhistories)
        raise ArgumentError, "Members must be Megam::billedhistories's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
