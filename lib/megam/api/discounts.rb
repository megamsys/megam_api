module Megam
  class API
    def get_discounts
      @options = {:path => '/discounts',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_discounts(id)
      @options = {:path => "/discounts/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_discounts(new_discount)
      @options = {:path => '/discounts/content',
        :body => Megam::JSONCompat.to_json(new_discount)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
