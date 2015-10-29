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
        @inputs = []
	puts "=============> CommonDeployable ATTRIBUTES <============="
	puts ATTRIBUTES.inspect
	bld_toscatype(params[:mkp])
	#bld_inputs(params)
	puts "=============> CommonDeployable INPUTS <============="
	puts @inputs.inspect
        set_attributes(params)
      end

      def add_input(input)
        inputs << input
      end

      def to_hash
        #controls.sort! {|x,y| x.line_number <=> y.line_number}
        h = {
          :name => assemblyname,
          :status => status,
          :tosca_type => tosca_type,
          :inputs => inputs

          #:controls => controls.collect { |c| c.to_hash }
        }
      end

  def bld_toscatype(mkp)
    tosca_suffix = DEFAULT_TOSCA_SUFFIX
    tosca_suffix = "#{mkp[:name]}" unless mkp[:cattype] != 'TORPEDO'.freeze
    @tosca_type = DEFAULT_TOSCA_PREFIX + ".#{mkp[:cattype].downcase}.#{mkp[:name].downcase}"
  end

  def bld_inputs(params)
    mkp = params[:mkp]
    @inputs << { 'key' => 'domain', 'value' => params[:domain] } if params.key?(:domain)
    @inputs << { 'key' => 'sshkey', 'value' => "#{params[:email]}_#{params[:ssh_keypair_name]}" } if params[:ssh_keypair_name]
    @inputs << { 'key' => 'provider', 'value' => params[:provider] } if params.key?(:provider)
    @inputs << { 'key' => 'endpoint', 'value' => params[:endpoint] } if params.key?(:endpoint)
    @inputs << { 'key' => 'cpu', 'value' => params[:cpu] } if params.key?(:cpu)
    @inputs << { 'key' => 'ram', 'value' => params[:ram] } if params.key?(:ram)
    @inputs << { 'key' => 'version', 'value' => params[:version] } #if mkp[:cattype] == Assemblies::TORPEDO
  end

    end

    class InputGroupData
      include Nilavu::MegamAttributes

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

      def initialize(params)
        to_hash(params)
      end
    end
  end
end
