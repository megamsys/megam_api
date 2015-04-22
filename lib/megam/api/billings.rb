module Megam
  class API
    def get_billings
      @options = {:path => '/billings',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_billing(id)
      @options = {:path => "/billings/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_billings(new_billing)
      @options = {:path => '/billings/content',
        :body => Megam::JSONCompat.to_json(new_billing)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
