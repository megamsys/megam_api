module Megam
  class Mixins
    class CommonDeployable
      include Megam::Mixins::MegamAttributes
      attr_reader :name, :status, :inputs

      ATTRIBUTES = [
        :name,
        :tosca_type,
        :status,
      :inputs]

      def initialize(params)
        @name = ""
        @tosca_type = ""
        @status = "launching"
        @inputs = []
        set_attributes(params)
      end

      def add_input(input)
        inputs << input
      end

      def to_hash
        controls.sort! {|x,y| x.line_number <=> y.line_number}
        h = {
          :name => name,
          :status => status,
          :controls => controls.collect { |c| c.to_hash }
        }
      end
    end

    class InputGroupData
      include Megam::Mixins::MegamAttributes

      ATTRIBUTES = [
        :domain,
        :sshkey,
        :provider,
        :cpu,
        :ram,
        :hdd,
        :version,
        :display_name,
      :password]

      def initialize(params)
        set_attributes(params)
      end
    end
  end
end
