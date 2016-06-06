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
  class OrganizationsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @organizations = Array.new
      @organizations_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_organizations
      @organizations
    end

    def [](index)
      @organizations[index]
    end

    def []=(index, arg)
      is_megam_organizations(arg)
      @organizations[index] = arg
      @organizations_by_name[arg.name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_organizations(a)
        @organizations << a
        @organizations_by_name[a.name] =@organizations.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(organizations)
      is_megam_organizations(organizations)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # predefclouds
        @organizations.insert(@insert_after_idx + 1, organizations)
        # update name -> location mappings and register new predefclouds
        @organizations_by_name.each_key do |key|
        @organizations_by_name[key] += 1 if@organizations_by_name[key] > @insert_after_idx
        end
        @organizations_by_name[organizations.name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @organizations << organizations
      @organizations_by_name[organizations.name] =@organizations.length - 1
      end
    end

    def each
      @organizations.each do |organizations|
        yield organizations
      end
    end

    def each_index
      @organizations.each_index do |i|
        yield i
      end
    end

    def empty?
      @organizations.empty?
    end

    def lookup(organizations)
      lookup_by = nil
      if organizations.kind_of?(Megam::Organizations)
      lookup_by = organizations.name
      elsif organizations.kind_of?(String)
      lookup_by = organizations
      else
        raise ArgumentError, "Must pass a Megam::PredefClouds or String to lookup"
      end
      res =@organizations_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a predefclouds matching #{lookup_by} (did you define it first?)"
      end
      @organizations[res]
    end

    def to_s
        @organizations.join(", ")
    end

    def for_json
      to_a.map { |item| item.to_s }
    end

    def to_json(*a)
      Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |organizations_list|
        organizations_array = organizations_list.kind_of?(Array) ? organizations_list : [ organizations_list ]
        organizations_array.each do |organizations|
          collection.insert(organizations)
        end
      end
      collection
    end

    private

    def is_megam_organizations(arg)
      unless arg.kind_of?(Megam::Organizations)
        raise ArgumentError, "Members must be Megam::Organizations's"
      end
      true
    end
  end
end
