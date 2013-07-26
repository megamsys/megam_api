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
  class Node

    attr_accessor :provider
    attr_accessor :allowed_actions
    attr_accessor :run_context
    attr_accessor :cookbook_name
    attr_accessor :recipe_name
    attr_accessor :enclosing_provider
    attr_accessor :source_line
    attr_accessor :retries
    attr_accessor :retry_delay

    attr_reader :updated
    attr_reader :elapsed_time

    # Each notify entry is a resource/action pair, modeled as an
    # Struct with a #resource and #action member
    def initialize(name, run_context=nil)
      @name = name
      @noop = nil
      @provider = nil
      @source_line = nil
      @elapsed_time = 0
    end

    def node
      self
    end

    def name(name=nil)
      if !name.nil?
        raise ArgumentError, "name must be a string!" unless name.kind_of?(String)
        @name = name
      end
      @name
    end

    def noop(tf=nil)
      if !tf.nil?
        raise ArgumentError, "noop must be true or false!" unless tf == true || tf == false
        @noop = tf
      end
      @noop
    end

    # as_json does most of the to_json heavy lifted. It exists here in case activesupport
    # is loaded. activesupport will call as_json and skip over to_json. This ensure
    # json is encoded as expected
    def as_json(*a)
      safe_ivars = instance_variables.map { |ivar| ivar.to_sym } - FORBIDDEN_IVARS
      instance_vars = Hash.new
      safe_ivars.each do |iv|
        instance_vars[iv.to_s.sub(/^@/, '')] = instance_variable_get(iv)
      end
      {
        'json_class' => self.class.name,
        'instance_vars' => instance_vars
      }
    end

    # Serialize this object as a hash
    def to_json(*a)
      results = as_json
      results.to_json(*a)
    end

    def to_hash
      safe_ivars = instance_variables.map { |ivar| ivar.to_sym } - FORBIDDEN_IVARS
      instance_vars = Hash.new
      safe_ivars.each do |iv|
        key = iv.to_s.sub(/^@/,'').to_sym
        instance_vars[key] = instance_variable_get(iv)
      end
      instance_vars
    end

    def self.json_create(o)
      resource = self.new(o["instance_vars"]["@name"])
      o["instance_vars"].each do |k,v|
        resource.instance_variable_set("@#{k}".to_sym, v)
      end
      resource
    end

  end
end