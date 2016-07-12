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
  class Mixins
    class CommonDeployable
      include Nilavu::MegamAttributes
      attr_reader :status, :inputs, :tosca_type

      DEFAULT_TOSCA_PREFIX = 'tosca'.freeze
      # this is a mutable string, if nothing exists then we use ubuntu
      DEFAULT_TOSCA_SUFFIX = 'ubuntu'.freeze

      ATTRIBUTES = [
        :tosca_type,
        :status,
        :inputs]

      def attributes
        ATTRIBUTES
      end

      def initialize(params)
        @tosca_type = ''
        @status = 'launching'
        bld_toscatype(params)
        set_attributes(params)
        @inputs = InputGroupData.new(params)

      end

      def to_hash
        h = {
          status: status,
          tosca_type: tosca_type,
          inputs: inputs.to_hash
        }
      end

      def bld_toscatype(params)
        tosca_suffix = DEFAULT_TOSCA_SUFFIX
        tosca_suffix = "#{params[:mkp_name]}" unless params[:cattype] != 'TORPEDO'.freeze
        @tosca_type = DEFAULT_TOSCA_PREFIX + ".#{params[:cattype].downcase}.#{params[:mkp_name].downcase}" if params[:cattype] != nil  && params[:mkp_name] != nil
      end
    end

    class InputGroupData
      include Nilavu::MegamAttributes

      attr_reader :domain, :keypairoption, :sshkey, :provider, :cpu, :ram, :hdd,
      :version, :display_name, :password, :region, :resource, :storage_hddtype,
      :publicipv4, :privateipv4, :publicipv6, :privateipv6

      ATTRIBUTES = [
        :domain,
        :keypairoption,
        :sshkey,
        :provider,
        :cpu,
        :ram,
        :hdd,
        :version,
        :display_name,
        :password,
        :region,
        :resource,
        :storage_hddtype,
        :privateipv4,
        :publicipv4,
        :privateipv6,
        :publicipv6]

      def attributes
        ATTRIBUTES
      end

      def initialize(params)
        set_attributes(params)
      end

    end
  end
end
