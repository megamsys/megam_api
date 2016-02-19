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
