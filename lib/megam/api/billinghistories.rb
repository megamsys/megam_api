module Megam
  class API
    def get_billinghistories
      @options = {:path => '/billinghistories',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_billinghistory(id)
      @options = {:path => "/billinghistories/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_billinghistories(new_billinghistory)
      @options = {:path => '/billinghistories/content',
        :body => Megam::JSONCompat.to_json(new_billinghistory)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
