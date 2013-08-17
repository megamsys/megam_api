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
  class CloudTemplateCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @cloudtemplates = Array.new
      @cloudtemplates_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_cloudtemplates
      @cloudtemplates
    end

    def [](index)
      @cloudtemplates[index]
    end

    def []=(index, arg)
      is_megam_cloudtemplate(arg)
      @cloudtemplates[index] = arg
      @cloudtemplates_by_name[arg.cctype] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_cloudtemplate(a)
        @cloudtemplates << a
        @cloudtemplates_by_name[a.cctype] =@cloudtemplates.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(cloudtemplate)
      is_megam_cloudtemplate(cloudtemplate)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # cloudtemplates
        @cloudtemplates.insert(@insert_after_idx + 1, cloudtemplate)
        # update name -> location mappings and register new cloudtemplates
        @cloudtemplates_by_name.each_key do |key|
        @cloudtemplates_by_name[key] += 1 if@cloudtemplates_by_name[key] > @insert_after_idx
        end
        @cloudtemplates_by_name[cloudtemplate.cctype] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @cloudtemplates << cloudtemplate
      @cloudtemplates_by_name[cloudtemplate.cctype] =@cloudtemplates.length - 1
      end
    end

    def each
      @cloudtemplates.each do |cloudtemplate|
        yield cloudtemplate
      end
    end

    def each_index
      @cloudtemplates.each_index do |i|
        yield i
      end
    end

    def empty?
      @cloudtemplates.empty?
    end

    def lookup(cloudtemplate)
      lookup_by = nil
      if cloudtemplate.kind_of?(Megam::CloudTemplate)
      lookup_by = cloudtemplate.cctype
      elsif cloudtemplate.kind_of?(String)
      lookup_by = cloudtemplate
      else
        raise ArgumentError, "Must pass a Megam::CloudTemplates or String to lookup"
      end
      res =@cloudtemplates_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a cloudtemplates matching #{lookup_by} (did you define it first?)"
      end
      @cloudtemplates[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |cloudtemplate|
        index_hash[cloudtemplate.cctype] = cloudtemplate.to_s
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
      o["results"].each do |cloudtemplates_list|
        cloudtemplates_array = cloudtemplates_list.kind_of?(Array) ? cloudtemplates_list : [ cloudtemplates_list ]
        cloudtemplates_array.each do |cloudtemplate|
          collection.insert(cloudtemplate)
        end
      end
      collection
    end

    private

    def is_megam_cloudtemplate(arg)
      unless arg.kind_of?(Megam::CloudTemplate)
        raise ArgumentError, "Members must be Megam::CloudTemplate's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end