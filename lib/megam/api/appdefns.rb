module Megam
  class API

    # GET /appdefns
    def get_appdefns
      @options = {:path => '/appdefns',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_appdefn(appdefns_id)
      @options = {:path => "/appdefns/#{appdefns_id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_appdefn(new_appdefn)
      @options = {:path => '/appdefns/content',
        :body => Megam::JSONCompat.to_json(new_appdefn)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
