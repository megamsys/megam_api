# Copyright:: Copyright (c) 2012, 2013 Megam Systems
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
  class MarketPlaceAddonsCollection
    include Enumerable

    
    attr_reader :iterator
    def initialize
      @addons = Array.new
      @addons_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_addons
      @addons
    end

    def [](index)
      @addons[index]
    end

    def []=(index, arg)
      is_megam_addon(arg)
      @addons[index] = arg
      @addons_by_name[arg.id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_addon(a)
        @addons << a
        @addons_by_name[a.id] = @addons.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(addon)
      is_megam_addon(addon)
      if @insert_after_idx
        # in the middle of executing a run, so any addons inserted now should
        # be placed after the most recent addition done by the currently executing
        # addons
        @addons.insert(@insert_after_idx + 1, addon)
        # update name -> location mappings and register new addons
        @addons_by_name.each_key do |key|
        @addons_by_name[key] += 1 if @addons_by_name[key] > @insert_after_idx
        end
        @addons_by_name[addon.id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @addons << addon
      @addons_by_name[addon.id] = @addons.length - 1 
      end
    end

    def each
      @addons.each do |addon|
        yield addon
      end
    end

    def each_index
      @addons.each_index do |i|
        yield i
      end
    end

    def empty?
      @addons.empty?
    end

    def lookup(addon)
      lookup_by = nil
      if addon.kind_of?(Megam::MarketPlaceAddons)
      lookup_by = addon.id
      elsif addon.kind_of?(String)
      lookup_by = addon
      else
        raise ArgumentError, "Must pass a Megam::MarketPlaceAddons or String to lookup"
      end
      res = @addons_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a appreq matching #{lookup_by} (did you define it first?)"
      end
      @addons[res]
    end
    
     # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |addon|
        index_hash[addon.id] = addon.to_s
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
      o["results"].each do |addons_list|
       addons_array = addons_list.kind_of?(Array) ? addons_list : [ addons_list ]
        addons_array.each do |addon|
          collection.insert(addon)
        end
      end
      collection
    end

    private

    
    
    def is_megam_addon(arg)
      unless arg.kind_of?(Megam::MarketPlaceAddons)
        raise ArgumentError, "Members must be Megam::MarketPlaceAddons"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
