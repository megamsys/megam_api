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
  class SshKeyCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @sshkeys = Array.new
      @sshkeys_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_sshkeys
      @sshkeys
    end

    def [](index)
      @sshkeys[index]
    end

    def []=(index, arg)
      is_megam_sshkeys(arg)
      @sshkeys[index] = arg
      @sshkeys_by_name[arg.name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_sshkeys(a)
        @sshkeys << a
        @sshkeys_by_name[a.name] =@sshkeys.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(sshkeys)
      is_megam_sshkeys(sshkeys)
      if @insert_after_idx
        # in the middle of executing a run, so any sshkeys inserted now should
        # be placed after the most recent addition done by the currently executing
        # sshkey
        @sshkeys.insert(@insert_after_idx + 1, sshkeys)
        # update name -> location mappings and register new sshkeys
        @sshkeys_by_name.each_key do |key|
        @sshkeys_by_name[key] += 1 if@sshkeys_by_name[key] > @insert_after_idx
        end
        @sshkeys_by_name[sshkeys.name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @sshkeys << sshkeys
      @sshkeys_by_name[sshkeys.name] =@sshkeys.length - 1
      end
    end

    def each
      @sshkeys.each do |sshkeys|
        yield sshkeys
      end
    end

    def each_index
      @sshkeys.each_index do |i|
        yield i
      end
    end

    def empty?
      @sshkeys.empty?
    end

    def lookup(sshkeys)
      lookup_by = nil
      if sshkeys.kind_of?(Megam::SshKey)
      lookup_by = sshkeys.name
      elsif sshkeys.kind_of?(String)
      lookup_by = sshkeys
      else
        raise ArgumentError, "Must pass a Megam::sshkeys or String to lookup"
      end
      res =@sshkeys_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a sshkeys matching #{lookup_by} (did you define it first?)"
      end
      @sshkeys[res]
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |sshkeys|
        index_hash[sshkeys.name] = sshkeys.to_s
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
      o["results"].each do |sshkeys_list|
        sshkeys_array = sshkeys_list.kind_of?(Array) ? sshkeys_list : [ sshkeys_list ]
        sshkeys_array.each do |sshkeys|
          collection.insert(sshkeys)
        end
      end
      collection
    end

    private

    def is_megam_sshkeys(arg)
      unless arg.kind_of?(Megam::SshKey)
        raise ArgumentError, "Members must be Megam::SshKeys's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end