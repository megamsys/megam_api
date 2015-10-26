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
  class SensorCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @sensor = Array.new
      @sensor_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_sensor
      @sensor
    end

    def [](index)
      @sensor[index]
    end

    def []=(index, arg)
      is_megam_sensor(arg)
      @sensor[index] = arg
      @sensor_by_name[arg.accounts_id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_sensor(a)
        @sensor << a
        @sensor_by_name[a.accounts_id] =@sensor.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(sensor)
      is_megam_sensor(sensor)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # sensor
        @sensor.insert(@insert_after_idx + 1, sensor)
        # update name -> location mappings and register new sensor
        @sensor_by_name.each_key do |key|
        @sensor_by_name[key] += 1 if@sensor_by_name[key] > @insert_after_idx
        end
        @sensor_by_name[sensor.accounts_id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @sensor << sensor
      @sensor_by_name[sensor.accounts_id] =@sensor.length - 1
      end
    end

    def each
      @sensor.each do |sensor|
        yield sensor
      end
    end

    def each_index
      @sensor.each_index do |i|
        yield i
      end
    end

    def empty?
      @sensor.empty?
    end

    def lookup(sensor)
      lookup_by = nil
      if sensor.kind_of?(Megam::sensor)
      lookup_by = sensor.accounts_id
    elsif sensor.kind_of?(String)
      lookup_by = sensor
      else
        raise ArgumentError, "Must pass a Megam::sensor or String to lookup"
      end
      res =@sensor_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a sensor matching #{lookup_by} (did you define it first?)"
      end
      @sensor[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |sensor|
        index_hash[sensor.accounts_id] = sensor.to_s
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
      o["results"].each do |sensor_list|
        sensor_array = sensor_list.kind_of?(Array) ? sensor_list : [ sensor_list ]
        sensor_array.each do |sensor|
          collection.insert(sensor)
        end
      end
      collection
    end

    private

    def is_megam_sensor(arg)
      unless arg.kind_of?(Megam::Sensor)
        raise ArgumentError, "Members must be Megam::sensor's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
