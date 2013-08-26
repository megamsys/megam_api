module Megam
  class API

    # GET /requests
    def get_requests
      @options = {:path => '/requests',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_request(node_name)
      @options = {:path => "/requests/#{node_name}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

  end
end