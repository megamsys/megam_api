module Megam
  class KoniPai

    def initialize()
      @koni = nil
    end

    def konipai
      self
    end

    def koni(arg=nil)
      if arg != nil
        @koni = arg
      else
      @koni
      end
    end


    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["json_claz"] = self.class.name
      index_hash["koni"] = koni
      index_hash
    end


    def self.json_create(o)
      kp  = new
      kp.koni(o) if o != null
      kp
    end


    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
