require File.expand_path("#{File.dirname(__FILE__)}/common_deployable")

module Megam
  class Mixins
    class Assemblies
      attr_reader :assemblys

      def initialize(params)
        @assemblys = CommonDeployable.new(params)
      end

      def to_hash
        {:assemblys => assemblys.to_hash}
      end
    end
  end
end
