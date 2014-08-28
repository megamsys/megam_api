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
  class CloudToolSettingCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @cloudtoolsettings = Array.new
      @cloudtoolsettings_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_cloudtoolsettings
      @cloudtoolsettings
    end

    def [](index)
      @cloudtoolsettings[index]
    end

    def []=(index, arg)
      is_megam_cloudtoolsettings(arg)
      @cloudtoolsettings[index] = arg
      @cloudtoolsettings_by_name[arg.repo_name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_cloudtoolsettings(a)
        @cloudtoolsettings << a
        @cloudtoolsettings_by_name[a.repo_name] =@cloudtoolsettings.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(cloudtoolsettings)
      is_megam_cloudtoolsettings(cloudtoolsettings)
      if @insert_after_idx
        # in the middle of executing a run, so any cloudtoolsettings inserted now should
        # be placed after the most recent addition done by the currently executing
        # cloudtoolsettings
        @cloudtoolsettings.insert(@insert_after_idx + 1, cloudtoolsettings)
        # update name -> location mappings and register new cloudtoolsettings
        @cloudtoolsettings_by_name.each_key do |key|
        @cloudtoolsettings_by_name[key] += 1 if@cloudtoolsettings_by_name[key] > @insert_after_idx
        end
        @cloudtoolsettings_by_name[cloudtoolsettings.repo_name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @cloudtoolsettings << cloudtoolsettings
      @cloudtoolsettings_by_name[cloudtoolsettings.repo_name] =@cloudtoolsettings.length - 1
      end
    end

    def each
      @cloudtoolsettings.each do |cloudtoolsettings|
        yield cloudtoolsettings
      end
    end

    def each_index
      @cloudtoolsettings.each_index do |i|
        yield i
      end
    end

    def empty?
      @cloudtoolsettings.empty?
    end

    def lookup(cloudtoolsettings)
      lookup_by = nil
      if cloudtoolsettings.kind_of?(Megam::CloudToolSetting)
      lookup_by = cloudtoolsettings.repo_name
      elsif cloudtoolsettings.kind_of?(String)
      lookup_by = cloudtoolsettings
      else
        raise ArgumentError, "Must pass a Megam::cloudtoolsettings or String to lookup"
      end
      res =@cloudtoolsettings_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a cloudtoolsettings matching #{lookup_by} (did you define it first?)"
      end
      @cloudtoolsettings[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |cloudtoolsettings|
        index_hash[cloudtoolsettings.repo_name] = cloudtoolsettings.to_s
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
      o["results"].each do |cloudtoolsettings_list|
        cloudtoolsettings_array = cloudtoolsettings_list.kind_of?(Array) ? cloudtoolsettings_list : [ cloudtoolsettings_list ]
        cloudtoolsettings_array.each do |cloudtoolsettings|
          collection.insert(cloudtoolsettings)
        end
      end
      collection
    end

    private

    def is_megam_cloudtoolsettings(arg)
      unless arg.kind_of?(Megam::CloudToolSetting)
        raise ArgumentError, "Members must be Megam::cloudtoolsetting's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end