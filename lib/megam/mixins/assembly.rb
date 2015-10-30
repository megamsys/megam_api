require File.expand_path("#{File.dirname(__FILE__)}/common_deployable")
require File.expand_path("#{File.dirname(__FILE__)}/components")
require File.expand_path("#{File.dirname(__FILE__)}/outputs")

module Megam
  class  Mixins
    class Assembly
      attr_reader :components, :policies, :outputs, :mixins

      def initialize(params)
	params = Hash[params.map{ |k, v| [k.to_sym, v] }]
        @mixins = CommonDeployable.new(params)
        @outputs = Outputs.new(params)
        @components = add_components(params)
        @policies = []
      end

      def to_hash
        result = @mixins.to_hash
        result[:components]  = @components if @components
        result[:outputs] = @outputs.to_array  if @outputs
        result[:policies] = @policies if @policies
        result
      end

      private
      # If @components_enabled for type
      def components_enabled?
        true # enable if its not a TORPEDO
      end

      def add_components(params)
        unless components_enabled?
          @components = Components.new(params)
	else
	  @components = []
        end
      end

    end
  end
end
