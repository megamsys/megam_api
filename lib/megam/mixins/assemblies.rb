module Megam
  class Mixins
    class Assemblies
      attr_reader :assemblys

      def initialize(params)
        @assemblys = AssemblysDeployable.new(params)
      end

      def to_hash
        {:assemblys => assemblys.to_hash}
      end
    end
  end
end
