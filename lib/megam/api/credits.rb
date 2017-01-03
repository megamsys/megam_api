module Megam
  class API
    def list_credits
      @options = {:path => '/credits',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_credits(account_id)
      @options = {:path => "/credits/#{account_id}",:body => Megam::JSONCompat.to_json(account_id)}.merge(@options)
      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_credits(new_credits)
      @options = {:path => '/credits/content',
        :body => Megam::JSONCompat.to_json(new_credits)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
