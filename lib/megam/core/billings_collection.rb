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
  class BillingsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @billings = Array.new
      @billings_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_billings
      @billings
    end

    def [](index)
      @billings[index]
    end

    def []=(index, arg)
      is_megam_billings(arg)
      @billings[index] = arg
      @billings_by_name[arg.repo_name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_billings(a)
        @billings << a
        @billings_by_name[a.repo_name] =@billings.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(billings)
      is_megam_billings(billings)
      if @insert_after_idx
        # in the middle of executing a run, so any billings inserted now should
        # be placed after the most recent addition done by the currently executing
        # billings
        @billings.insert(@insert_after_idx + 1, billings)
        # update name -> location mappings and register new billings
        @billings_by_name.each_key do |key|
        @billings_by_name[key] += 1 if@billings_by_name[key] > @insert_after_idx
        end
        @billings_by_name[billings.repo_name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @billings << billings
      @billings_by_name[billings.repo_name] =@billings.length - 1
      end
    end

    def each
      @billings.each do |billings|
        yield billings
      end
    end

    def each_index
      @billings.each_index do |i|
        yield i
      end
    end

    def empty?
      @billings.empty?
    end

    def lookup(billings)
      lookup_by = nil
      if billings.kind_of?(Megam::Billings)
      lookup_by = billings.repo_name
      elsif billings.kind_of?(String)
      lookup_by = billings
      else
        raise ArgumentError, "Must pass a Megam::billings or String to lookup"
      end
      res =@billings_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a billings matching #{lookup_by} (did you define it first?)"
      end
      @billings[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |billings|
        index_hash[billings.repo_name] = billings.to_s
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
      o["results"].each do |billings_list|
        billings_array = billings_list.kind_of?(Array) ? billings_list : [ billings_list ]
        billings_array.each do |billings|
          collection.insert(billings)
        end
      end
      collection
    end

    private

    def is_megam_billings(arg)
      unless arg.kind_of?(Megam::Billings)
        raise ArgumentError, "Members must be Megam::Billings"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end