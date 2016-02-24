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
  class MarketPlaceCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @apps = Array.new
      @apps_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_apps
      @apps
    end

    def [](index)
      @apps[index]
    end

    def []=(index, arg)
      is_megam_app(arg)
      @apps[index] = arg
      @apps_by_name[arg.flavor] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_app(a)
        @apps << a
        @apps_by_name[a.flavor] = @apps.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(app)
      is_megam_app(app)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @apps.insert(@insert_after_idx + 1, app)
        # update name -> location mappings and register new node
        @apps_by_name.each_key do |key|
        @apps_by_name[key] += 1 if @apps_by_name[key] > @insert_after_idx
        end
        @apps_by_name[app.flavor] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @apps << app
      @apps_by_name[app.flavor] = @apps.length - 1
      end
    end

    def each
      @apps.each do |app|
        yield app
      end
    end

    def each_index
      @apps.each_index do |i|
        yield i
      end
    end

    def empty?
      @apps.empty?
    end

    def lookup(app)
      lookup_by = nil
      if app.kind_of?(Megam::MarketPlace)
      lookup_by = app.flavor
      elsif app.kind_of?(String)
      lookup_by = app
      else
        raise ArgumentError, "Must pass a Megam::MarketPlace or String to lookup"
      end
      res = @apps_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a app matching #{lookup_by} (did you define it first?)"
      end
      @apps[res]
    end

     # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |app|
        index_hash[app.flavor] = app.to_s
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
      o["results"].each do |apps_list|
        apps_array = apps_list.kind_of?(Array) ? apps_list : [ apps_list ]
        apps_array.each do |app|
          collection.insert(app)
        end
      end
      collection
    end

    private



    def is_megam_app(arg)
      unless arg.kind_of?(Megam::MarketPlace)
        raise ArgumentError, "Members must be Megam::MarketPlace's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
