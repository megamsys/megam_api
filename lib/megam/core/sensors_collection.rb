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
  class SensorsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @sensors = []
      @sensors_by_name = {}
      @insert_after_idx = nil
    end

    def all_sensor
      @sensors
    end

    def [](index)
      @sensors[index]
    end

    def []=(index, arg)
      is_megam_sensors(arg)
      @sensors[index] = arg
      @sensors_by_name[arg.id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_sensors(a)
        @sensors << a
        @sensors_by_name[a.id] = @sensors.length - 1
      end
      self
    end

    # 'push' is an alias method to <<s
    alias_method :push, :<<

    def insert(sensors)
      is_megam_sensors(sensors)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # sensors
        @sensors.insert(@insert_after_idx + 1, sensors)
        # update name -> location mappings and register new sensors
        @sensors_by_name.each_key do |key|
          @sensors_by_name[key] += 1 if@sensors_by_name[key] > @insert_after_idx
        end
        @sensors_by_name[sensors.id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
        @sensors << sensors
        @sensors_by_name[sensors.id] = @sensors.length - 1
      end
    end

    def each
      @sensors.each do |sensors|
        yield sensors
      end
    end

    def each_index
      @sensors.each_index do |i|
        yield i
      end
    end

    def empty?
      @sensors.empty?
    end

    def lookup(sensors)
      lookup_by = nil
      if sensors.is_a?(Megam.sensors)
        lookup_by = sensors.id
      elsif sensors.is_a?(String)
        lookup_by = sensors
      else
        fail ArgumentError, 'Must pass a Megam::sensors or String to lookup'
      end
      res = @sensors_by_name[lookup_by]
      unless res
        fail ArgumentError, "Cannot find a sensors matching #{lookup_by} (did you define it first?)"
      end
      @sensors[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = {}
      each do |sensors|
        index_hash[sensors.id] = sensors.to_s
      end
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

    def self.json_create(o)
      collection = new
      o['results'].each do |sensors_list|
        sensors_array = sensors_list.is_a?(Array) ? sensors_list : [sensors_list]
        sensors_array.each do |sensors|
          collection.insert(sensors)
        end
      end
      collection
    end

    private

    def is_megam_sensors(arg)
      unless arg.is_a?(Megam::Sensors)
        fail ArgumentError, "Members must be Megam::sensors's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end
  end
end
