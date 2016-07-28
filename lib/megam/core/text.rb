require "megam/core/text_formatter"
module Megam
    class Text

        attr_reader :stdout
        attr_reader :stderr
        attr_reader :stdin
        attr_reader :config

        def initialize(stdout, stderr, stdin, config)
            @stdout, @stderr, @stdin, @config = stdout, stderr, stdin, config
        end

        def highline
            @highline ||= begin
                require 'highline'
                HighLine.new
            end
        end

        # Summarize the data. Defaults to text format output,
        # which may not be very summary-like
        def summarize(data)
            text_format(data)
        end

        # Converts the +data+ to a String in the text format. Uses
        # Chef::Knife::Core::TextFormatter
        def text_format(data)
            Megam::TextFormatter.new(data, self).formatted_data
        end

        def msg(message)
            stdout.puts message
        end

        # Prints a message to stdout. Aliased as +info+ for compatibility with
        # the logger API.

        def info(message)
            stdout.puts("#{color('INFO:', :green, :bold)} #{message}")
        end

        # Prints a msg to stderr. Used for warn, error, and fatal.
        def err(message)
            stderr.puts message
        end

        # Print a warning message
        def warn(message)
            err("#{color('WARNING:', :yellow, :bold)} #{message}")
        end

        # Print an error message
        def error(message)
            err("#{color('ERROR:', :red, :bold)} #{message}")
        end

        # Print a message describing a fatal error.
        def fatal(message)
            err("#{color('FATAL:', :red, :bold)} #{message}")
        end

        def color(string, *colors)
            if color?
                highline.color(string, *colors)
            else
                string
            end
        end

        # Should colored output be used ?. When output is not to a
        # terminal, colored output is never used
        def color?
            stdout.tty?
        end

        def list(*args)
            highline.list(*args)
        end

        def pretty_print(data)
            stdout.puts data
        end

    end
end
