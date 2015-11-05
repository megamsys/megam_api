require File.expand_path("#{File.dirname(__FILE__)}/megam_attributes")
require File.expand_path("#{File.dirname(__FILE__)}/common_deployable")
require File.expand_path("#{File.dirname(__FILE__)}/outputs")

module Megam
  class Mixins
    class Components
      attr_reader :mixins, :name, :repo, :related_components, :operations, :artifacts, :outputs
      def initialize(params)
        @mixins = CommonDeployable.new(params)
        @name = params[:componentname]
        @outputs = Outputs.new(params)
        @operations = add_operations(params)
        @related_components = add_related_components(params)
        @artifacts = add_artifacts(params)
        @repo = add_repo(params)
      end

      def to_hash
        result = @mixins.to_hash
        result[:name]  = @name if @name
        result[:artifacts]  = @artifacts if @artifacts
        result[:repo]  = @repo if @repo
        result[:operations]  = @operations if @operations
        result[:outputs] = @outputs.to_array  if @outputs
        result[:related_components] = @related_components if @related_components
        result
      end

	def to_a
		[to_hash]
	end

      private

      def add_repo(params)
        Repo.new(params).tohash
      end

      def add_related_components(params)
	related_components = []
        related_components << "#{params[:assemblyname]}.#{params[:domain]}/#{params[:componentname]}" if params.key?(:bind_type)
      end

      def add_operations(params)
        operations = []
        operations.push(create_operation(Operations::CI, Operations::CI_DESCRIPTON,  params)) unless params[:scm_name].strip.empty?
        operations.push(create_operation(Operations::BIND, Operations::BIND_DESCRIPTON, params)) if params.key?(:bind_type)
      end

      def create_operation(type, desc, params)
        Operations.new(params, type, desc).tohash
      end

      def add_artifacts(params)
        Artifacts.new(params).tohash
      end
    end

    class Repo
      include Nilavu::MegamAttributes
      attr_reader :type, :source, :url, :oneclick
      ATTRIBUTES = [
        :type,
        :source,
        :oneclick,
        :url]

      def attributes
        ATTRIBUTES
      end

      def initialize(params)
        set_attributes(params)
        @type = params[:type]
        @source = params[:scm_name]
	@url = params[:source]
	@oneclick = params[:oneclick]
      end

      def tohash
        {  :rtype => @type,
          :source => @source,
          :oneclick => @oneclick,
          :url => @url
        }
      end

    end

    class Operations
      include Nilavu::MegamAttributes
      attr_reader :type, :desc, :prop

      ATTRIBUTES = []

      CI = "CI".freeze
      CI_DESCRIPTON = "always up to date code. sweet."

      BIND = "bind".freeze
      BIND_DESCRIPTON = "bind. sweet."
      def initialize(params,type, desc)
        @type = type
        @desc = desc
        #set_attributes(params)
	@prop = prop(params)
      end

      def attributes
        ATTRIBUTES
      end

      def tohash
        {   :operation_type => @type,
          :description => @desc,
          :properties => @prop
        }
      end
#Key_name mismatch. Key_name is to be changed.
	def prop(params)
    op = []
    op << { 'key' => 'type', 'value' => params[:scm_name] }
    op << { 'key' => 'token', 'value' => params[:scmtoken] || '' }
    op << { 'key' => 'username', 'value' => params[:scmowner] || '' }
      op
	end
    end

    class Artifacts
      include Nilavu::MegamAttributes
      ATTRIBUTES = [
        :type,
        :content,
        :requirements]

      def attributes
        ATTRIBUTES
      end

      def initialize(params)
        set_attributes(params)
      end

      def tohash
        {   :artifact_type => "",
          :content => "",
          :requirements => []
        }
      end
    end
  end
end
