module Megam
  class API
    def get_subscriptions
      @options = {:path => '/subscriptions',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_subscriptions(id)
      @options = {:path => "/subscriptions/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_subscriptions(new_subscription)
      @options = {:path => '/subscriptions/content',
        :body => Megam::JSONCompat.to_json(new_subscription)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
