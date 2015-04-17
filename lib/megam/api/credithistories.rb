module Megam
  class API
    def get_credithistories
      @options = {:path => '/credithistories',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_credithistories(id)
      @options = {:path => "/credithistories/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_credithistories(new_credithistories)
      @options = {:path => '/credithistories/content',
        :body => Megam::JSONCompat.to_json(new_credithistories)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
