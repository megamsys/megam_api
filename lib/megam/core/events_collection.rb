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
  class EventsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @events = Array.new
      @events_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_events
      @events
    end

    def [](index)
      @events[index]
    end

    def []=(index, arg)
      is_megam_events(arg)
      @events[index] = arg
      @events_by_name[arg.account_id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_events(a)
        @events << a
        @events_by_name[a.account_id] = @events.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(events)
      is_megam_events(events)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @events.insert(@insert_after_idx + 1, events)
        # update name -> location mappings and register new node
        @events_by_name.each_key do |key|
        @events_by_name[key] += 1 if @events_by_name[key] > @insert_after_idx
        end
        @events_by_name[events.account_id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @events << events
      @events_by_name[events.account_id] = @events.length - 1
      end
    end

    def each
      @events.each do |events|
        yield events
      end
    end

    def each_index
      @events.each_index do |i|
        yield i
      end
    end

    def empty?
      @events.empty?
    end

    def lookup(events)
      lookup_by = nil
      if events.kind_of?(Megam::Events)
      lookup_by = events.account_id
    elsif events.kind_of?(String)
      lookup_by = events
      else
        raise ArgumentError, "Must pass a Megam::Events or String to lookup"
      end
      res = @events_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @events[res]
    end

    def to_s
        @events.join(", ")
    end

    def for_json
        to_a.map { |item| item.to_s }
    end

    def to_json(*a)
        Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |events_list|
        events_array = events_list.kind_of?(Array) ? events_list : [ events_list ]
        events_array.each do |events|
          collection.insert(events)

        end
      end
      collection
    end

    private

    def is_megam_events(arg)
      unless arg.kind_of?(Megam::Events)
        raise ArgumentError, "Members must be Megam::Events's"
      end
      true
    end
  end
end
