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
  class Mixins
    class Policies
      attr_reader :bind_type, :policymembers

      def initialize(params)
        @bind_type = params[:bind_type] if params.key?(:bind_type)
        @policymembers = params[:policymembers] if params.key?(:policymembers)
      end

      def to_array
        com = []
        if @bind_type && @bind_type != 'Unbound service'
          value = {
            name: 'bind policy',
            ptype: 'colocated',
            members: [
              @policymembers
            ]
          }
          com << value
        end
        com
      end
    end
  end
end
