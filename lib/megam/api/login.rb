module Megam
  class API
     def post_auth
      @options = {:path => '/auth', :body => ""}.merge(@options)

      request(
        :expects  => 200,
	      :method   => :post,
        :body     => @options[:body]

        )
    end
  end
end
