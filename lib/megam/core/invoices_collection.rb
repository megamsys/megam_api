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
  class InvoicesCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @invoices = Array.new
      @invoices_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_invoices
      @invoices
    end

    def [](index)
      @invoices[index]
    end

    def []=(index, arg)
      is_megam_invoices(arg)
      @invoices[index] = arg
      @invoices_by_name[arg.accounts_id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_invoices(a)
        @invoices << a
        @invoices_by_name[a.accounts_id] =@invoices.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(invoices)
      is_megam_invoices(invoices)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # invoices
        @invoices.insert(@insert_after_idx + 1, invoices)
        # update name -> location mappings and register new invoices
        @invoices_by_name.each_key do |key|
        @invoices_by_name[key] += 1 if@invoices_by_name[key] > @insert_after_idx
        end
        @invoices_by_name[invoices.accounts_id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @invoices << invoices
      @invoices_by_name[invoices.accounts_id] =@invoices.length - 1
      end
    end

    def each
      @invoices.each do |invoices|
        yield invoices
      end
    end

    def each_index
      @invoices.each_index do |i|
        yield i
      end
    end

    def empty?
      @invoices.empty?
    end

    def lookup(invoices)
      lookup_by = nil
      if invoices.kind_of?(Megam::invoices)
      lookup_by = invoices.accounts_id
    elsif invoices.kind_of?(String)
      lookup_by = invoices
      else
        raise ArgumentError, "Must pass a Megam::invoices or String to lookup"
      end
      res =@invoices_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a invoices matching #{lookup_by} (did you define it first?)"
      end
      @invoices[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |invoices|
        index_hash[invoices.accounts_id] = invoices.to_s
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
      o["results"].each do |invoices_list|
        invoices_array = invoices_list.kind_of?(Array) ? invoices_list : [ invoices_list ]
        invoices_array.each do |invoices|
          collection.insert(invoices)
        end
      end
      collection
    end

    private

    def is_megam_invoices(arg)
      unless arg.kind_of?(Megam::Invoices)
        raise ArgumentError, "Members must be Megam::invoices's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
