module Nilavu
  module MegamAttributes
    ATTRIBUTES = []
    attr_accessor *ATTRIBUTES

    def initialize(control_data={})
      set_attributes(control_data)
    end

    def set_attributes(control_data)
      control_data.symbolize_keys!
      ATTRIBUTES.each { |a| instance_variable_set("@#{a}", control_data[a]) unless attrs[a].nil? }
    end

    def to_hash
      h = ATTRIBUTES.reduce([]) do |res, key|
        val = instance_variable_get("@#{key}".to_sym)
        res << { KEY => key.to_s, VALUE => val } unless val.nil?
        res
      end
      h
    end
  end
end
