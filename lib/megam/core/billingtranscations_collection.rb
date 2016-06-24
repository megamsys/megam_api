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
  class BillingtranscationsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @billingtranscations = Array.new
      @billingtranscations_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_billingtranscations
      @billingtranscations
    end

    def [](index)
      @billingtranscations[index]
    end

    def []=(index, arg)
      is_megam_billingtranscations(arg)
      @billingtranscations[index] = arg
      @billingtranscations_by_name[arg.accounts_id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_billingtranscations(a)
        @billingtranscations << a
        @billingtranscations_by_name[a.accounts_id] =@billingtranscations.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(billingtranscations)
      is_megam_billingtranscations(billingtranscations)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # billingtranscations
        @billingtranscations.insert(@insert_after_idx + 1, billingtranscations)
        # update name -> location mappings and register new billingtranscations
        @billingtranscations_by_name.each_key do |key|
        @billingtranscations_by_name[key] += 1 if@billingtranscations_by_name[key] > @insert_after_idx
        end
        @billingtranscations_by_name[billingtranscations.accounts_id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @billingtranscations << billingtranscations
      @billingtranscations_by_name[billingtranscations.accounts_id] =@billingtranscations.length - 1
      end
    end

    def each
      @billingtranscations.each do |billingtranscations|
        yield billingtranscations
      end
    end

    def each_index
      @billingtranscations.each_index do |i|
        yield i
      end
    end

    def empty?
      @billingtranscations.empty?
    end

    def lookup(billingtranscations)
      lookup_by = nil
      if billingtranscations.kind_of?(Megam::billingtranscations)
      lookup_by = billingtranscations.accounts_id
    elsif billingtranscations.kind_of?(String)
      lookup_by = billingtranscations
      else
        raise ArgumentError, "Must pass a Megam::billingtranscations or String to lookup"
      end
      res =@billingtranscations_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a billingtranscations matching #{lookup_by} (did you define it first?)"
      end
      @billingtranscations[res]
    end

    def to_s
        @billingtranscations.join(", ")
    end

    def for_json
        to_a.map { |item| item.to_s }
    end

    def to_json(*a)
        Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |billingtranscations_list|
        billingtranscations_array = billingtranscations_list.kind_of?(Array) ? billingtranscations_list : [ billingtranscations_list ]
        billingtranscations_array.each do |billingtranscations|
          collection.insert(billingtranscations)
        end
      end
      collection
    end

    private

    def is_megam_billingtranscations(arg)
      unless arg.kind_of?(Megam::Billingtranscations)
        raise ArgumentError, "Members must be Megam::billingtranscations's"
      end
      true
    end
  end
end
