require File.expand_path("#{File.dirname(__FILE__)}/megam_attributes")

module Megam
    class Outputs
        include Nilavu::MegamAttributes

        attr_reader :nodeip, :publicip, :privateip, :lastsuccessfulupdate, :laststatus

        ATTRIBUTES = []
        
        def attributes
            ATTRIBUTES
        end

        def initialize(params)
            set_attributes(params)
        end

        def to_array
            array = []
        end
    end
end
