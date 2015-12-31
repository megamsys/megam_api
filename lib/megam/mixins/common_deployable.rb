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
      attr_reader :domain, :sshkey, :provider, :cpu, :ram, :hdd, :version, :display_name, :password
      ATTRIBUTES = [
        :domain,
        :sshkey,
        :provider,
        :cpu,
        :ram,
        :hdd,
        :version,
        :display_name,
        :password]

      def attributes
        ATTRIBUTES
      end

      def initialize(params)
        set_attributes(params)
      end
    end
  end
end
