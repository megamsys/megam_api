module Megam
  class API
    def list_credit
      @options = {:path => '/credit',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_credit(account_id)
      @options = {:path => "/credit/#{account_id}",:body => Megam::JSONCompat.to_json(account_id)}.merge(@options)
      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_credit(new_credit)
      @options = {:path => '/credit/content',
        :body => Megam::JSONCompat.to_json(new_credit)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
