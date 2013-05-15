module Megam
  class API

    def get_predefs
      request(
        :expects  => 200,
        :method   => :get,
        :path     => "/predefs"
      )
    end
    
    def get_predef(name)
      request(
        :expects  => 200,
        :method   => :get,
        :path     => "/predefs/#{name}"
      )
    end

    
  end
end
