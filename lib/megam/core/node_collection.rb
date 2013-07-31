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
class Megam
  class NodeCollection
    include Enumerable

    # Matches a multiple node lookup specification,
    # e.g., "service[nginx,unicorn]"
    MULTIPLE_NODE_MATCH = /^(.+)\[(.+?),(.+)\]$/

    # Matches a single node lookup specification,
    # e.g., "service[nginx]"
    SINGLE_NODE_MATCH = /^(.+)\[(.+)\]$/

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
      @nodes_by_name[arg.to_s] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_node(a)
        @nodes << a
        @nodes_by_name[a.to_s] = @nodes.length - 1
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
        @nodes_by_name[node.to_s] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @nodes << node
      @nodes_by_name[node.to_s] = @nodes.length - 1
      end
    end

    def each
      @nodes.each do |node|
        yield node
      end
    end

    def execute_each_resource(&node_exec_block)
      @iterator = StepableIterator.for_collection(@nodes)
      @iterator.each_with_index do |node, idx|
        @insert_after_idx = idx
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
      lookup_by = node.to_s
      elsif node.kind_of?(String)
      lookup_by = node
      else
        raise ArgumentError, "Must pass a Megam::Node or String to lookup"
      end
      res = @nodes_by_name[lookup_by]
      unless res
        raise Megam::Exceptions::ResourceNotFound, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @nodes[res]
    end

    # Find existing nodes by searching the list of existing nodes.  Possible
    # forms are:
    #
    # find(:file => "foobar")
    # find(:file => [ "foobar", "baz" ])
    # find("file[foobar]", "file[baz]")
    # find("file[foobar,baz]")
    #
    # Returns the matching node, or an Array of matching nodes.
    #
    # Raises an ArgumentError if you feed it bad lookup information
    # Raises a Runtime Error if it can't find the nodes you are looking for.
    def find(*args)
      results = Array.new
      args.each do |arg|
        case arg
        when Hash
          results << find_node_by_hash(arg)
        when String
          results << find_node_by_string(arg)
        else
        msg = "arguments to #{self.class.name}#find should be of the form :node => 'name' or node[name]"
        raise Megam::Exceptions::InvalidNodeSpecification, msg
        end
      end
      flat_results = results.flatten
      flat_results.length == 1 ? flat_results[0] : flat_results
    end

    # nodes is a poorly named
    alias_method :nodes, :find

    # Serialize this object as a hash
    def to_json(*a)
      instance_vars = Hash.new
      self.instance_variables.each do |iv|
        instance_vars[iv] = self.instance_variable_get(iv)
      end
      results = {
        'json_class' => self.class.name,
        'instance_vars' => instance_vars
      }
      results.to_json(*a)
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
      o["Megam::Node"].each do |k,v|
        collection.instance_variable_set(k.to_sym, v)
      end
      collection
    end

    private

    def find_node_by_hash(arg)
      results = Array.new
      arg.each do |node_name, name_list|
        names = name_list.kind_of?(Array) ? name_list : [ name_list ]
        names.each do |name|
          res_name = "#{node_name.to_s}[#{name}]"
          results << lookup(res_name)
        end
      end
      return results
    end

    def find_node_by_string(arg)
      results = Array.new
      case arg
      when MULTIPLE_RESOURCE_MATCH
        node_type = $1
        arg =~ /^.+\[(.+)\]$/
        node_list = $1
        node_list.split(",").each do |name|
          node_name = "#{node_type}[#{name}]"
          results << lookup(node_name)
        end
      when SINGLE_RESOURCE_MATCH
        node_type = $1
        name = $2
        node_name = "#{node_type}[#{name}]"
        results << lookup(node_name)
      else
      raise ArgumentError, "Bad string format #{arg}, you must have a string like node_type[name]!"
      end
      return results
    end

    def is_megam_node(arg)
      unless arg.kind_of?(Megam::Node)
        raise ArgumentError, "Members must be Megam::Node's"
      end
      true
    end
  end
end