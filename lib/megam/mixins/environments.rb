require File.expand_path("#{File.dirname(__FILE__)}/megam_attributes")

module Megam
  class Environments

    attr_reader :envs

    def initialize(params)
        @envs = params[:envs]
    end

    def to_array
      array = [@envs.to_h]
    end
  end
end
