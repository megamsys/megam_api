module Megam
  class API

   def post_catrequest(new_req)
      @options = {:path => '/catrequests/content',
        :body => Megam::JSONCompat.to_json(new_req)}.merge(@options)
      
      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
