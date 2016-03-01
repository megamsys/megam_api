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

require File.expand_path("#{File.dirname(__FILE__)}/common_deployable")
require File.expand_path("#{File.dirname(__FILE__)}/components")
require File.expand_path("#{File.dirname(__FILE__)}/outputs")

module Megam
  class Mixins
    class Assembly
      attr_reader :id, :name, :components, :policies, :outputs, :envs, :mixins
      def initialize(params)
        params = Hash[params.map { |k, v| [k.to_sym, v] }]
        @id = params[:id] || params[:assemblyID] || ''
        @name = params[:assemblyname]
        @mixins = CommonDeployable.new(params)
        @outputs = Outputs.new(params)
        @components = add_components(params)
        @policies = []
      end

      def to_hash
        result = @mixins.to_hash
        result[:id] = @id if @id
        result[:name] = @name if @name
        result[:components] = @components if @components
        result[:outputs] = @outputs.to_array if @outputs
        result[:policies] = @policies if @policies
        result
      end

      private

      # If @components_enabled for type
      def components_enabled?(params)
        true if params[:cattype] != 'TORPEDO'.freeze
      end

      def add_components(params)
        if components_enabled?(params)
          @components = Components.new(params).to_a
        else
          @components = []
        end
      end
    end
  end
end
