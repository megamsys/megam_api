module Megam
  class API
  

    def get_promos(id)
      @options = {:path => "/promos/#{id}", :body => ""}.merge(@options)
      
      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

   

  end
end
