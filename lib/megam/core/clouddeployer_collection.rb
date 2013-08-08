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
  class CloudDeployerCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @clouddeployers = Array.new
      @clouddeployers_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_clouddeployers
      @clouddeployers
    end

    def [](index)
      @clouddeployers[index]
    end

    def []=(index, arg)
      is_megam_clouddeployers(arg)
      @clouddeployers[index] = arg
      @clouddeployers_by_name[arg.name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_clouddeployers(a)
        @clouddeployers << a
        @clouddeployers_by_name[a.name] =@clouddeployers.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(clouddeployers)
      is_megam_clouddeployers(clouddeployers)
      if @insert_after_idx
        # in the middle of executing a run, so any predefs inserted now should
        # be placed after the most recent addition done by the currently executing
        # clouddeployers
        @clouddeployers.insert(@insert_after_idx + 1, clouddeployers)
        # update name -> location mappings and register new clouddeployers
        @clouddeployers_by_name.each_key do |key|
        @clouddeployers_by_name[key] += 1 if@clouddeployers_by_name[key] > @insert_after_idx
        end
        @clouddeployers_by_name[clouddeployers.name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @clouddeployers << clouddeployers
      @clouddeployers_by_name[clouddeployers.name] =@clouddeployers.length - 1
      end
    end

    def each
      @clouddeployers.each do |clouddeployers|
        yield clouddeployers
      end
    end

    def each_index
      @clouddeployers.each_index do |i|
        yield i
      end
    end

    def empty?
      @clouddeployers.empty?
    end

    def lookup(clouddeployers)
      lookup_by = nil
      if clouddeployers.kind_of?(Megam::CloudDeployer)
      lookup_by = clouddeployers.name
      elsif clouddeployers.kind_of?(String)
      lookup_by = clouddeployers
      else
        raise ArgumentError, "Must pass a Megam::CloudDeployers or String to lookup"
      end
      res =@clouddeployers_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a clouddeployers matching #{lookup_by} (did you define it first?)"
      end
      @clouddeployers[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |clouddeployers|
        index_hash[clouddeployers.name] = clouddeployers.to_s
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
"json_claz":"Megam::CloudDeployerCollection",
"results":[{
"id":"NOD362554470640386048",
"name":"ec2_rails",
"account_id":"ACT362544229488001024",
"json_claz":"Megam::CloudDeployer",
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
      o["results"].each do |clouddeployers_list|
        clouddeployers_array = clouddeployers_list.kind_of?(Array) ? clouddeployers_list : [ clouddeployers_list ]
        clouddeployers_array.each do |clouddeployers|
          collection.insert(clouddeployers)
        end
      end
      collection
    end

    private

    def is_megam_clouddeployers(arg)
      unless arg.kind_of?(Megam::CloudDeployer)
        raise ArgumentError, "Members must be Megam::CloudDeployers's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end