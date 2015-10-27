module Megam
  class Mixins
    class Components
      attr_reader :mixins, :repo, :related_components, :operations, :artifacts

      def initialize(params)
        @mixins = MixinDeployable.new(params)
        @artifacts = Outputs.new(params)
        add_repo(params)
        add_operations(params)
        add_related_components(params)
        add_artifacts(params)
      end

      def to_hash
        result = @mixins.to_hash
        result = result.merge(@repo.to_hash) if @repo
        result = result.merge(@operation.to_hash) if @operations
        result = result.merge(@outputs.to_hash) if @outputs
        result = result.merge(@artifacts.to_hash) if @artifacts
        result[:related_components] = related_components
        result
      end

      private
      def add_repo(params)
      end

      def add_related_components(params)
        related_components = [ "#{params[:assemblyname]}.#{params[:domain]}/#{params[:componentname]}"]
      end

      def add_operations(params)
        create_operation(Operations.CI, Operations.CI_DESCRIPTON, [:type, :token, :username])
        create_operation(Operations.BIND, Operations.BIND_DESCRIPTON, [:type, :token, :username])
      end

      def create_operation(type, desc,properties)
        Operations.new.add_operation(type, desc, properties)
      end

      def add_artifacts(params)
      end
    end

    class Repo
      include Megam::Mixins::MegamAttributes

      ATTRIBUTES = [
        :type,
        :source,
        :oneclick,
      :url]

      def initialize(params)
        set_attributes(params)
      end
    end

    class Operations
      include Megam::Mixins::MegamAttributes

      ATTRIBUTES = []

      CI = "ci".freeze
      CI_DESCRIPTON = "always up to date code. sweet."

      def initialize(params)
        set_attributes(params)
      end

      def add_operation(type, desc, properties)
        ATTRIBUTES.merge(properties)
        set_attributes(properties)
      end

      def to_hash
        #{   'type' => 'ci',
        #   'description' => 'Continous Integration',
        #   'properties' => self.to_hash
      end
    end

    class Artifacts
      include Megam::Mixins::MegamAttributes

      ATTRIBUTES = [
        :type,
        :content,
      :requirements]

      def initialize(params)
        set_attributes(params)
      end
    end
  end
end
