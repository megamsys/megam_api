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
  class PredefCloudCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @predefclouds = Array.new
      @predefclouds_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_predefclouds
      @predefclouds
    end

    def [](index)
      @predefclouds[index]
    end

    def []=(index, arg)
      is_megam_predefclouds(arg)
      @predefclouds[index] = arg
      @predefclouds_by_name[arg.name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_predefclouds(a)
        @predefclouds << a
        @predefclouds_by_name[a.name] =@predefclouds.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(predefclouds)
      is_megam_predefclouds(predefclouds)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # predefclouds
        @predefclouds.insert(@insert_after_idx + 1, predefclouds)
        # update name -> location mappings and register new predefclouds
        @predefclouds_by_name.each_key do |key|
        @predefclouds_by_name[key] += 1 if@predefclouds_by_name[key] > @insert_after_idx
        end
        @predefclouds_by_name[predefclouds.name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @predefclouds << predefclouds
      @predefclouds_by_name[predefclouds.name] =@predefclouds.length - 1
      end
    end

    def each
      @predefclouds.each do |predefclouds|
        yield predefclouds
      end
    end

    def each_index
      @predefclouds.each_index do |i|
        yield i
      end
    end

    def empty?
      @predefclouds.empty?
    end

    def lookup(predefclouds)
      lookup_by = nil
      if predefclouds.kind_of?(Megam::PredefCloud)
      lookup_by = predefclouds.name
      elsif predefclouds.kind_of?(String)
      lookup_by = predefclouds
      else
        raise ArgumentError, "Must pass a Megam::PredefClouds or String to lookup"
      end
      res =@predefclouds_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a predefclouds matching #{lookup_by} (did you define it first?)"
      end
      @predefclouds[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |predefclouds|
        index_hash[predefclouds.name] = predefclouds.to_s
      end
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

=begin
{
"json_claz":"Megam::PredefCloudCollection",
"results":[{
"id":"NOD362554470640386048",
"name":"ec2_rails",
"account_id":"ACT362544229488001024",
"json_claz":"Megam::PredefCloud",
"spec":{
"type_name":"sensor-type",
"groups":"sens-group",
"image":"sens-image",
"flavor":"sens-flvr"
},
"access":{
"ssh_key":"sens-ssh",
"identity_file":"sens-identity-file",
"ssh_user":"sens-sshuser"
},
"ideal":"",
"performance":""
}]
}
=end
    def self.json_create(o)
      collection = self.new()
      o["results"].each do |predefclouds_list|
        predefclouds_array = predefclouds_list.kind_of?(Array) ? predefclouds_list : [ predefclouds_list ]
        predefclouds_array.each do |predefclouds|
          collection.insert(predefclouds)
        end
      end
      collection
    end

    private

    def is_megam_predefclouds(arg)
      unless arg.kind_of?(Megam::PredefCloud)
        raise ArgumentError, "Members must be Megam::PredefClouds's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end