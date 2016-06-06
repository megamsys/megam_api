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
  class RequestCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @requests = Array.new
      @requests_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_requests
      @requests
    end

    def [](index)
      @requests[index]
    end

    def []=(index, arg)
      is_megam_request(arg)
      @requests[index] = arg
      @requests_by_name[arg.node_name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_request(a)
        @requests << a
        @requests_by_name[a.node_name] = @requests.length - 1
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
        @requests.insert(@insert_after_idx + 1, request)
        # update name -> location mappings and register new request
        @requests_by_name.each_key do |key|
        @requests_by_name[key] += 1 if @requests_by_name[key] > @insert_after_idx
        end
        @requests_by_name[request.node_name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @requests << request
      @requests_by_name[request.node_name] = @requests.length - 1
      end
    end

    def each
      @requests.each do |request|
        yield request
      end
    end

    def each_index
      @requests.each_index do |i|
        yield i
      end
    end

    def empty?
      @requests.empty?
    end

    def lookup(request)
      lookup_by = nil
      if request.kind_of?(Megam::Request)
      lookup_by = request.node_name
      elsif request.kind_of?(String)
      lookup_by = request
      else
        raise ArgumentError, "Must pass a Megam::Request or String to lookup"
      end
      res = @requests_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a request matching #{lookup_by} (did you define it first?)"
      end
      @requests[res]
    end

    def to_s
        @requests.join(", ")
    end

    def for_json
      to_a.map { |item| item.to_s }
    end

    def to_json(*a)
      Megam::JSONCompat.to_json(for_json, *a)
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
      unless arg.kind_of?(Megam::Request)
        raise ArgumentError, "Members must be Megam::Request's"
      end
      true
    end
  end
end
