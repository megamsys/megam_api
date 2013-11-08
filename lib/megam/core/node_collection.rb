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
  class NodeCollection
    include Enumerable

    
    attr_reader :iterator
    def initialize
      @nodes = Array.new
      @nodes_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_nodes
      @nodes
    end

    def [](index)
      @nodes[index]
    end

    def []=(index, arg)
      is_megam_node(arg)
      @nodes[index] = arg
      @nodes_by_name[arg.node_name] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_node(a)
        @nodes << a
        @nodes_by_name[a.node_name] = @nodes.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(node)
      is_megam_node(node)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @nodes.insert(@insert_after_idx + 1, node)
        # update name -> location mappings and register new node
        @nodes_by_name.each_key do |key|
        @nodes_by_name[key] += 1 if @nodes_by_name[key] > @insert_after_idx
        end
        @nodes_by_name[node.node_name] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @nodes << node
      @nodes_by_name[node.node_name] = @nodes.length - 1 
      end
    end

    def each
      @nodes.each do |node|
        yield node
      end
    end

    def each_index
      @nodes.each_index do |i|
        yield i
      end
    end

    def empty?
      @nodes.empty?
    end

    def lookup(node)
      lookup_by = nil
      if node.kind_of?(Megam::Node)
      lookup_by = node.node_name
      elsif node.kind_of?(String)
      lookup_by = node
      else
        raise ArgumentError, "Must pass a Megam::Node or String to lookup"
      end
      res = @nodes_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @nodes[res]
    end
    
     # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      self.each do |node|
        index_hash[node.node_name] = node.to_s
      end
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end


=begin
["json_claz":"Megam::NodeCollection",{
"id":"NOD362428315933343744",
"accounts_id":"ACT362211963352121344",
"json_claz":"Megam::Node",
"request":{
"req_id":"NOD362428315933343744",
"command":"commands"
},
"predefs":{
"name":"",
"scm":"",
"war":"",
"db":"",
"queue":""
}
}]
=end
    def self.json_create(o)
      collection = self.new()
      o["results"].each do |nodes_list|
        nodes_array = nodes_list.kind_of?(Array) ? nodes_list : [ nodes_list ]
        nodes_array.each do |node|
          collection.insert(node)
        end
      end
      collection
    end

    private

    
    
    def is_megam_node(arg)
      unless arg.kind_of?(Megam::Node)
        raise ArgumentError, "Members must be Megam::Node's"
      end
      true
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
