module Megam
  class Mixins
    class CommonDeployable
      include Megam::Mixins::MegamAttributes
      attr_reader :name, :status, :inputs

      ATTRIBUTES = [
        :name,
        :tosca_type,
        :status]

      def initialize(params)
        @name = ""
        @tosca_type = ""
        @status = "launching"
        @inputs = InputGroupData.new(params)
        set_attributes(params)
      end


      def to_hash

        h = {
          :name => name,
          :status => status,
          :controls => inputs.sort!.to_hash  }
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
