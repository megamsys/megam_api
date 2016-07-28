require 'logger'
require 'mixlib/log'
require 'megam/core/monologger'

module Megam
  class Log
    extend Mixlib::Log

    # Force initialization of the primary log device (@logger)
    init(Megam::MonoLogger.new(STDOUT))

    class Formatter
      def self.show_time=(*args)
        Mixlib::Log::Formatter.show_time = *args
      end
    end

  end
end
