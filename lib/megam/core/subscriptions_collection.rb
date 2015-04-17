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
  class SubscriptionsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @subscriptions = Array.new
      @subscriptions_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_subscriptions
      @subscriptions
    end

    def [](index)
      @subscriptions[index]
    end

    def []=(index, arg)
      is_megam_subscriptions(arg)
      @subscriptions[index] = arg
      @subscriptions_by_name[arg.repo_name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_subscriptions(a)
        @subscriptions << a
        @subscriptions_by_name[a.repo_name] =@subscriptions.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(subscriptions)
      is_megam_subscriptions(subscriptions)
      if @insert_after_idx
        # in the middle of executing a run, so any subscriptions inserted now should
        # be placed after the most recent addition done by the currently executing
        # subscriptions
        @subscriptions.insert(@insert_after_idx + 1, subscriptions)
        # update name -> location mappings and register new subscriptions
        @subscriptions_by_name.each_key do |key|
        @subscriptions_by_name[key] += 1 if@subscriptions_by_name[key] > @insert_after_idx
        end
        @subscriptions_by_name[subscriptions.repo_name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @subscriptions << subscriptions
      @subscriptions_by_name[subscriptions.repo_name] =@subscriptions.length - 1
      end
    end

    def each
      @subscriptions.each do |subscriptions|
        yield subscriptions
      end
    end

    def each_index
      @subscriptions.each_index do |i|
        yield i
      end
    end

    def empty?
      @subscriptions.empty?
    end

    def lookup(subscriptions)
      lookup_by = nil
      if subscriptions.kind_of?(Megam::Subscriptions)
      lookup_by = subscriptions.repo_name
      elsif subscriptions.kind_of?(String)
      lookup_by = subscriptions
      else
        raise ArgumentError, "Must pass a Megam::subscriptions or String to lookup"
      end
      res =@subscriptions_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a subscriptions matching #{lookup_by} (did you define it first?)"
      end
      @subscriptions[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |subscriptions|
        index_hash[subscriptions.repo_name] = subscriptions.to_s
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
      o["results"].each do |subscriptions_list|
        subscriptions_array = subscriptions_list.kind_of?(Array) ? subscriptions_list : [ subscriptions_list ]
        subscriptions_array.each do |subscriptions|
          collection.insert(subscriptions)
        end
      end
      collection
    end

    private

    def is_megam_subscriptions(arg)
      unless arg.kind_of?(Megam::Subscriptions)
        raise ArgumentError, "Members must be Megam::Subscriptions"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end