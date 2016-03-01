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
require File.expand_path("#{File.dirname(__FILE__)}/megam_attributes")

module Megam
  class Outputs
    include Nilavu::MegamAttributes

    attr_reader :nodeip, :publicip, :privateip, :lastsuccessfulupdate, :laststatus

    ATTRIBUTES = [
    ]
    def attributes
      ATTRIBUTES
    end

    def initialize(params)
      set_attributes(params)
    end

    def to_array
      array = []
    end
  end
end
