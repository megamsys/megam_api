require File.expand_path("#{File.dirname(__FILE__)}/assembly")

module Megam
  class Mixins
    class Assemblies
      attr_reader :assembly
      def initialize(params)
        @assembly = Assembly.new(params)
      end

      def to_hash
        assembly.to_hash
      end
    end
  end
end
