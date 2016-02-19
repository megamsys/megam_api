module Nilavu
  module MegamAttributes
    ATTRIBUTES = []
    KEY = 'key'.freeze
    VALUE = 'value'.freeze
    attr_accessor *ATTRIBUTES
    def attributes
      NotImplementedError
    end

    def initialize(control_data = {})
      set_attributes(control_data)
    end

    def set_attributes(control_data)
      attributes.each { |a| instance_variable_set("@#{a}", control_data[a]) unless control_data[a].nil? }
    end

    def to_hash
      h = attributes.reduce([]) do |res, key|
        val = instance_variable_get("@#{key}".to_sym)
        res << { KEY => key.to_s, VALUE => val } unless val.nil?
        res
      end
      h
    end
  end
end
