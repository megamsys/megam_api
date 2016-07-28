module Megam
  class API
    def get_balances
      @options = {:path => '/balances',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_balance(id)
      @options = {:path => "/balances/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_balances(new_balance)
      @options = {:path => '/balances/content',
        :body => Megam::JSONCompat.to_json(new_balance)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

     def update_balance(new_balance)
      @options = {:path => '/balances/update',
        :body => Megam::JSONCompat.to_json(new_balance)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
