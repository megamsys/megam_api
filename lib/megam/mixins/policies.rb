module Megam
  class Mixins
    class Policies
      attr_reader :bind_type, :policymembers

      def initialize(params)
        @bind_type = params[:bind_type] if params.key?(:bind_type)
        @policymembers = params[:policymembers] if params.key?(:policymembers)
      end

      def to_array
        com = []
        if @bind_type && @bind_type != 'Unbound service'
          value = {
            name: 'bind policy',
            ptype: 'colocated',
            members: [
              @policymembers
            ]
          }
          com << value
        end
        com
      end
    end
  end
end
