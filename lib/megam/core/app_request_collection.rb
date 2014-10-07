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
  class AppRequestCollection
    include Enumerable

    
    attr_reader :iterator
    def initialize
      @appreqs = Array.new
      @appreqs_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_appreqs
      @appreqs
    end

    def [](index)
      @appreqs[index]
    end

    def []=(index, arg)
      is_megam_appreq(arg)
      @appreqs[index] = arg
      @appreqs_by_name[arg.id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_appreq(a)
        @appreqs << a
        @appreqs_by_name[a.id] = @appreqs.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(appreq)
      is_megam_appreq(appreq)
      if @insert_after_idx
        # in the middle of executing a run, so any Appreqss inserted now should
        # be placed after the most recent addition done by the currently executing
        # appreqs
        @appreqs.insert(@insert_after_idx + 1, appreq)
        # update name -> location mappings and register new appreqs
        @appreqs_by_name.each_key do |key|
        @appreqs_by_name[key] += 1 if @appreqs_by_name[key] > @insert_after_idx
        end
        @appreqs_by_name[appreq.id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @appreqs << appreq
      @appreqs_by_name[appreq.id] = @appreqs.length - 1 
      end
    end

    def each
      @appreqs.each do |appreq|
        yield appreq
      end
    end

    def each_index
      @appreqs.each_index do |i|
        yield i
      end
    end

    def empty?
      @appreqs.empty?
    end

    def lookup(appreq)
      lookup_by = nil
      if appreq.kind_of?(Megam::AppRequest)
      lookup_by = appreq.id
      elsif appreq.kind_of?(String)
      lookup_by = appreq
      else
        raise ArgumentError, "Must pass a Megam::Appreqs or String to lookup"
      end
      res = @appreqs_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a appreq matching #{lookup_by} (did you define it first?)"
      end
      @appreqs[res]
    end
    
     # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |appreq|
        index_hash[appreq.id] = appreq.to_s
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
      o["results"].each do |appreqs_list|
       appreqs_array = appreqs_list.kind_of?(Array) ? appreqs_list : [ appreqs_list ]
        appreqs_array.each do |appreq|
          collection.insert(appreq)
        end
      end
      collection
    end

    private

    
    
    def is_megam_appreq(arg)
      unless arg.kind_of?(Megam::AppRequest)
        raise ArgumentError, "Members must be Megam::Appreq's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
