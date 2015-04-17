module Megam
  class API
    def get_availableunits
      @options = {:path => '/availableunits',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_availableunit(id)
      @options = {:path => "/availableunits/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_availableunits(new_availableunit)
      @options = {:path => '/availableunits/content',
        :body => Megam::JSONCompat.to_json(new_availableunit)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
