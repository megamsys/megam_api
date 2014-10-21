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
      @apprequests = Array.new
      @apprequests_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_requests
      @apprequests
    end

    def [](index)
      @apprequests[index]
    end

    def []=(index, arg)
      is_megam_request(arg)
      @apprequests[index] = arg
      @apprequests_by_name[arg.app_id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_request(a)
        @apprequests << a
        @apprequests_by_name[a.app_id] = @apprequests.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(request)
      is_megam_request(request)
      if @insert_after_idx
        # in the middle of executing a run, so any requests inserted now should
        # be placed after the most recent addition done by the currently executing
        # request
        @apprequests.insert(@insert_after_idx + 1, request)
        # update name -> location mappings and register new request
        @apprequests_by_name.each_key do |key|
        @apprequests_by_name[key] += 1 if @apprequests_by_name[key] > @insert_after_idx
        end
        @apprequests_by_name[request.app_id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @apprequests << request
      @apprequests_by_name[request.app_id] = @apprequests.length - 1
      end
    end

    def each
      @apprequests.each do |request|
        yield request
      end
    end

    def each_index
      @apprequests.each_index do |i|
        yield i
      end
    end

    def empty?
      @apprequests.empty?
    end

    def lookup(request)
      lookup_by = nil
      if request.kind_of?(Megam::AppRequest)
      lookup_by = request.app_id
      elsif request.kind_of?(String)
      lookup_by = request
      else
        raise ArgumentError, "Must pass a Megam::AppRequest or String to lookup"
      end
      res = @apprequests_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a request matching #{lookup_by} (did you define it first?)"
      end
      @apprequests[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |request|
        index_hash[request.app_id] = request.to_s
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
      o["results"].each do |requests_list|
        requests_array = requests_list.kind_of?(Array) ? requests_list : [ requests_list ]
        requests_array.each do |request|
          collection.insert(request)
        end
      end
      collection
    end

    private

    def is_megam_request(arg)
      unless arg.kind_of?(Megam::AppRequest)
        raise ArgumentError, "Members must be Megam::AppRequest's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
