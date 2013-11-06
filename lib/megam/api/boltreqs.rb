module Megam
  class API


    def get_boltreq(node_name)
      @options = {:path => "/boltreqs/#{node_name}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_boltreq(new_boltreq)
      @options = {:path => '/boltreqs/content',
        :body => Megam::JSONCompat.to_json(new_boltreq)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
