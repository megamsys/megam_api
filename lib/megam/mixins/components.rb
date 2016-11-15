require File.expand_path("#{File.dirname(__FILE__)}/megam_attributes")
require File.expand_path("#{File.dirname(__FILE__)}/common_deployable")
require File.expand_path("#{File.dirname(__FILE__)}/outputs")

module Megam
    class Mixins
        class Components
            attr_reader :mixins, :name, :repo, :related_components, :operations, :artifacts, :envs, :outputs, :id
            def initialize(params)
                @mixins = CommonDeployable.new(params)
                @id = params[:id] if params[:id]
                @name = params[:componentname] || params[:name] || ''
                @outputs = Outputs.new(params)
                @operations = add_operations(params)
                @related_components = add_related_components(params)
                @artifacts = add_artifacts(params)
                @repo = add_repo(params)
                @envs = params[:envs]
            end

            def to_hash
                result = @mixins.to_hash
                result[:id] = @id if @id
                result[:name] = @name if @name
                result[:artifacts] = @artifacts if @artifacts
                result[:repo] = @repo if @repo
                result[:operations] = @operations if @operations
                result[:outputs] = @outputs.to_array if @outputs
                result[:related_components] = @related_components if @related_components
                result[:envs] = @envs if @envs
                result.to_hash
            end

            def to_a
                [to_hash]
            end

            private

            def add_repo(params)
                Repo.new(params).tohash
            end

            def add_related_components(params)
                @related_components = []
                @related_components << "#{params[:bind_type]}" if params.key?(:bind_type)
            end

            def add_operations(params)
                operations = []
                operations.push(create_operation(Operations::CI, Operations::CI_DESCRIPTON, params)) if params.key?(:scm_name) && params.key?(:scmtoken)
                operations.push(create_operation(Operations::BIND, Operations::BIND_DESCRIPTON, params)) if params.key?(:bind_type)
                operations
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
            attr_reader :type, :source, :url, :oneclick, :branch
            ATTRIBUTES = [
                :type,
                :source,
                :oneclick,
                :url,
                :branch]

            def attributes
                ATTRIBUTES
            end

            def initialize(params)
                set_attributes(params)
                @type = params[:type] || ""
                @source = params[:scm_name] || ""
                @url = params[:source] || ""
                @oneclick = params[:oneclick] || ""
                @branch = params[:scmbranch] || ""
            end

            def tohash
                {  rtype: @type,
                    source: @source,
                    oneclick: @oneclick,
                    url: @url,
                    branch: @branch
                }
            end
        end

        class Operations
            include Nilavu::MegamAttributes
            attr_reader :type, :desc, :prop, :status

            ATTRIBUTES = [
                :type,
                :desc,
                :prop,
            :status]

            def attributes
                ATTRIBUTES
            end

            CI = 'CI'.freeze
            CI_DESCRIPTON = 'always up to date code. sweet.'
            NOTBOUND = "notbound".freeze
            BIND = 'bind'.freeze
            BIND_DESCRIPTON = 'bind. sweet.'

            def initialize(params, type, desc)
                @type = type
                @desc = desc
                @prop = prop(params)
            end

            def attributes
                ATTRIBUTES
            end

            def tohash
                {   operation_type: @type,
                    description: @desc,
                    properties: @prop,
                    status: NOTBOUND
                }
            end

            # Key_name mismatch. Key_name is to be changed.
            def prop(params)
                op = []
                op << { 'key' => 'type', 'value' => params[:scm_name] } if params.key?(:scm_name)
                op << { 'key' => 'token', 'value' => params[:scmtoken] } if params.key?(:scmtoken)
                op << { 'key' => 'username', 'value' => params[:scmowner] } if params.key?(:scmowner)
                op << { 'key' => 'related_component', 'value' => params[:bind_type] } if params.key?(:bind_type)
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
                {   artifact_type: '',
                    content: '',
                    requirements: []
                }
            end
        end
    end
end
