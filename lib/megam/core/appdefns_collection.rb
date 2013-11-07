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
  class AppdefnsCollection
    include Enumerable

    
    attr_reader :iterator
    def initialize
      @appdefns = Array.new
      @appdefns_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_appdefns
      @appdefns
    end

    def [](index)
      @appdefns[index]
    end

    def []=(index, arg)
      is_megam_appdefn(arg)
      @appdefns[index] = arg
      @appdefns_by_name[arg.id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_appdefn(a)
        @appdefns << a
        @appdefns_by_name[a.id] = @appdefns.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(appdefn)
      is_megam_appdefn(appdefn)
      if @insert_after_idx
        # in the middle of executing a run, so any Appdefnss inserted now should
        # be placed after the most recent addition done by the currently executing
        # appdefns
        @appdefns.insert(@insert_after_idx + 1, appdefn)
        # update name -> location mappings and register new appdefns
        @appdefns_by_name.each_key do |key|
        @appdefns_by_name[key] += 1 if @appdefns_by_name[key] > @insert_after_idx
        end
        @appdefns_by_name[appdefn.id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @appdefns << appdefn
      @appdefns_by_name[appdefn.id] = @appdefns.length - 1 
      end
    end

    def each
      @appdefns.each do |appdefn|
        yield appdefn
      end
    end

    def each_index
      @appdefns.each_index do |i|
        yield i
      end
    end

    def empty?
      @appdefns.empty?
    end

    def lookup(appdefn)
      lookup_by = nil
      if appdefn.kind_of?(Megam::Appdefns)
      lookup_by = appdefn.id
      elsif appdefn.kind_of?(String)
      lookup_by = appdefn
      else
        raise ArgumentError, "Must pass a Megam::Appdefns or String to lookup"
      end
      res = @appdefns_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a appdefn matching #{lookup_by} (did you define it first?)"
      end
      @appdefns[res]
    end
    
     # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |appdefn|
        index_hash[appdefn.id] = appdefn.to_s
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
      o["results"].each do |appdefns_list|
       appdefns_array = appdefns_list.kind_of?(Array) ? appdefns_list : [ appdefns_list ]
        appdefns_array.each do |appdefn|
          collection.insert(appdefn)
        end
      end
      collection
    end

    private

    
    
    def is_megam_appdefn(arg)
      unless arg.kind_of?(Megam::Appdefns)
        raise ArgumentError, "Members must be Megam::Appdefn's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
