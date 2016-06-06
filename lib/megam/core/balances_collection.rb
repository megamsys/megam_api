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
  class BalancesCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @balance = Array.new
      @balance_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_balance
      @balance
    end

    def [](index)
      @balance[index]
    end

    def []=(index, arg)
      is_megam_balance(arg)
      @balance[index] = arg
      @balance_by_name[arg.name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_balance(a)
        @balance << a
        @balance_by_name[a.name] =@balance.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(balance)
      is_megam_balance(balance)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # balance
        @balance.insert(@insert_after_idx + 1, balance)
        # update name -> location mappings and register new balance
        @balance_by_name.each_key do |key|
        @balance_by_name[key] += 1 if@balance_by_name[key] > @insert_after_idx
        end
        @balance_by_name[balance.name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @balance << balance
      @balance_by_name[balance.name] =@balance.length - 1
      end
    end

    def each
      @balance.each do |balance|
        yield balance
      end
    end

    def each_index
      @balance.each_index do |i|
        yield i
      end
    end

    def empty?
      @balance.empty?
    end

    def lookup(balance)
      lookup_by = nil
      if balance.kind_of?(Megam::Balances)
      lookup_by = balance.name
      elsif balance.kind_of?(String)
      lookup_by = balance
      else
        raise ArgumentError, "Must pass a Megam::Balance or String to lookup"
      end
      res =@balance_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a balance matching #{lookup_by} (did you define it first?)"
      end
      @balance[res]
    end

    def to_s
        @balance.join(", ")
    end

    def for_json
        to_a.map { |item| item.to_s }
    end

    def to_json(*a)
        Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |balance_list|
        balance_array = balance_list.kind_of?(Array) ? balance_list : [ balance_list ]
        balance_array.each do |balance|
          collection.insert(balance)
        end
      end
      collection
    end

    private

    def is_megam_balance(arg)
      unless arg.kind_of?(Megam::Balances)
        raise ArgumentError, "Members must be Megam::balance's"
      end
      true
    end
  end
end
