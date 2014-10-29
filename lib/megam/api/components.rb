module Megam
  class API
    def get_components(comp_id)
      @options = {:path => "/components/#{comp_id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end
    
     def update_component(new_asm)
      @options = {:path => '/components/update',
        :body => Megam::JSONCompat.to_json(new_asm)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
