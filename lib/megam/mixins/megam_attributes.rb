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
module Nilavu
  module MegamAttributes
    ATTRIBUTES = []
    KEY = 'key'.freeze
    VALUE = 'value'.freeze

    attr_accessor *ATTRIBUTES

    def attributes
      NotImplementedError
    end

    def initialize(control_data = {})
      set_attributes(control_data)
    end

    def set_attributes(control_data)
      attributes.each { |a| instance_variable_set("@#{a}", control_data[a]) unless control_data[a].nil? }
    end

    def to_hash
      h = attributes.reduce([]) do |res, key|
        val = instance_variable_get("@#{key}".to_sym)
        res << { KEY => key.to_s, VALUE => val } unless val.nil?
        res
      end
      h
    end
  end
end
