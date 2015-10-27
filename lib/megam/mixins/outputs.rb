module Megam
    class Outputs
      include Megam::Mixins::MegamAttributes

      ATTRIBUTES = [
        :nodeip,
        :publicip,
        :privateip,
        :lastsuccessfulupdate,
      :laststatus]

      def initialize(params)
        set_attributes(params)
      end
    end
  end
end
