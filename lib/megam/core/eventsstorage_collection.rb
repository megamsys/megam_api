# Copyright:: Copyright (c) 2013-2016 Megam Systems
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
  class EventsStorageCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @eventsstorage = Array.new
      @eventsstorage_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_eventsstorage
      @eventsstorage
    end

    def [](index)
      @eventsstorage[index]
    end

    def []=(index, arg)
      is_megam_eventsstorage(arg)
      @eventsstorage[index] = arg
      @eventsstorage_by_name[arg.account_id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_events(a)
        @eventsstorage << a
        @eventsstorage_by_name[a.account_id] = @eventsstorage.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(eventsstorage)
      is_megam_eventsstorage(eventsstorage)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @eventsstorage.insert(@insert_after_idx + 1, eventsstorage)
        # update name -> location mappings and register new node
        @eventsstorage_by_name.each_key do |key|
        @eventsstorage_by_name[key] += 1 if @eventsstorage_by_name[key] > @insert_after_idx
        end
        @eventsstorage_by_name[eventsstorage.account_id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @eventsstorage << eventsstorage
      @eventsstorage_by_name[eventsstorage.account_id] = @eventsstorage.length - 1
      end
    end

    def each
      @eventsstorage.each do |eventsstorage|
        yield eventsstorage
      end
    end

    def each_index
      @eventsstorage.each_index do |i|
        yield i
      end
    end

    def empty?
      @eventsstorage.empty?
    end

    def lookup(eventsstorage)
      lookup_by = nil
      if events.kind_of?(Megam::EventsStorage)
      lookup_by = eventsstorage.account_id
    elsif events.kind_of?(String)
      lookup_by = eventsstorage
      else
        raise ArgumentError, "Must pass a Megam::EventsStorage or String to lookup"
      end
      res = @eventsstorage_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @eventsstorage[res]
    end

    def to_s
        @eventsstorage.join(", ")
    end

    def for_json
        to_a.map { |item| item.to_s }
    end

    def to_json(*a)
        Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |eventsstorage_list|
        eventsstorage_array = eventsstorage_list.kind_of?(Array) ? eventsstorage_list : [ eventsstorage_list ]
        eventsstorage_array.each do |eventsstorage|
          collection.insert(eventsstorage)

        end
      end
      collection
    end

    private

    def is_megam_eventsstorage(arg)
      unless arg.kind_of?(Megam::EventsStorage)
        raise ArgumentError, "Members must be Megam::EventsStorage's"
      end
      true
    end
  end
end
