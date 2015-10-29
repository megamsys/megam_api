require File.expand_path("#{File.dirname(__FILE__)}/megam_attributes")

module Megam
  class Mixins
    class CommonDeployable
      include Nilavu::MegamAttributes
      attr_reader :assemblyname, :componentname, :status, :inputs, :tosca_type

  DEFAULT_TOSCA_PREFIX = 'tosca'.freeze
  # this is a mutable string, if nothing exists then we use ubuntu
  DEFAULT_TOSCA_SUFFIX = 'ubuntu'.freeze

      ATTRIBUTES = [
        :assemblyname,
        :componentname,
        :tosca_type,
        :status,
        :inputs]

	def attributes
		ATTRIBUTES
	end
      def initialize(params)
        @assemblyname = ""
        @tosca_type = ""
        @status = "launching"
	bld_toscatype(params)
        @inputs = InputGroupData.new(params)
        set_attributes(params)
      end


      def to_hash
        h = {
          :name => assemblyname,
          :status => status,
          :tosca_type => tosca_type,
          :inputs => inputs.to_hash  
        }
      end

  def bld_toscatype(mkp)
    tosca_suffix = DEFAULT_TOSCA_SUFFIX
    tosca_suffix = "#{mkp[:mkp_name]}" unless mkp[:cattype] != 'TORPEDO'.freeze
    @tosca_type = DEFAULT_TOSCA_PREFIX + ".#{mkp[:cattype].downcase}.#{mkp[:mkp_name].downcase}"
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
