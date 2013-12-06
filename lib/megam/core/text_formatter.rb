module Megam
  class TextFormatter

    attr_reader :data
    attr_reader :ui
    def initialize(data, ui)
      @ui = ui
      @data = if data.respond_to?(:display_hash)
            data.display_hash
          elsif data.kind_of?(Array)
            data
          elsif data.respond_to?(:to_hash)
            data.to_hash
          else
            data
          end
    end

    def formatted_data
      @formatted_data ||= text_format(data)
    end

    def text_format(data)
      buffer = ''

      if data.respond_to?(:keys)
        justify_width = data.keys.map {|k| k.to_s.size }.max.to_i + 1
        data.sort.each do |key, value|
        # key: ['value'] should be printed as key: value
          if value.kind_of?(Array) && value.size == 1 && is_singleton(value[0])
          value = value[0]
          end
          if is_singleton(value)
            # Strings are printed as key: value.
            justified_key = ui.color("#{key}:".ljust(justify_width), :cyan)
            buffer << "#{justified_key} #{value}\n"
          else
          # Arrays and hashes get indented on their own lines.
            buffer << ui.color("#{key}:\n", :cyan)
            lines = text_format(value).split("\n")
            lines.each { |line| buffer << "  #{line}\n" }
          end
        end
      elsif data.kind_of?(Array)
        data.each_index do |index|
          item = data[index]
          buffer << text_format(data[index])
          # Separate items with newlines if it's an array of hashes or an
          # array of arrays
          buffer << "\n" if !is_singleton(data[index]) && index != data.size-1
        end
      else
        buffer << "#{data}\n"
      end
      buffer
    end

    def is_singleton(value)
      !(value.kind_of?(Array) || value.respond_to?(:keys))
    end
    
  end
end
