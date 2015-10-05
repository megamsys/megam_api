module Megam
  class API
    def get_billedhistories
      @options = {:path => '/billedhistories',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_billedhistory(id)
      @options = {:path => "/billedhistories/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_billedhistories(new_billedhistory)
      @options = {:path => '/billedhistories/content',
        :body => Megam::JSONCompat.to_json(new_billedhistory)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
