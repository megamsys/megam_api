require File.expand_path("#{File.dirname(__FILE__)}/common_deployable")
require File.expand_path("#{File.dirname(__FILE__)}/outputs")

module Megam
  class  Mixins
    class Assemblys
      attr_reader :components, :policies, :outputs, :mixins

      def initialize(params)
	params = Hash[params.map{ |k, v| [k.to_sym, v] }]
        @mixins = CommonDeployable.new(params)
	puts "============================ASSEMBLYS -> Initialize ==> @mixins========================"
	puts @mixins.inspect
        @outputs = Outputs.new(params)
        add_components(params)
      end

      def to_hash
        result = @mixins.to_hash
	puts "==================To hash================="
	puts @mixins.class
        result[:components]  = @components.to_array if @components
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
