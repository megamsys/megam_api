module Megam
  class  Mixins
    class Assemblys
      attr_reader :components, :policies, :outputs, :mixins

      def initialize(params)
        @mixins = MixinDeployable.new(params)
        @outputs = Outputs.new(params)
        add_components(params)
      end

      private
      # If @components_enabled for type
      def components_enabled?
        true # enable if its not a TORPEDO
      end

      def add_components(params)
        unless components_enabled?
          @components = Components.new(params)
        end
      end

      def to_hash
        result = @mixins.to_hash
        result = result.merge(@components.to_hash) if @components
        result = result.merge(@outputs.to_hash)  if @outputs
        result = result.merge(@policies.to_hash) if @policies
        result
      end
    end
  end
end
