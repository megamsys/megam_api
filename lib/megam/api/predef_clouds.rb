module Megam
  class API
    def get_predefclouds
      @options = {:path => '/predefclouds',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_predefcloud(predefcloud_name)
      @options = {:path => "/predefclouds/#{predefcloud_name}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_predefcloud(new_predefcloud)
      @options = {:path => '/predefclouds/content',
        :body => Megam::JSONCompat.to_json(new_predefcloud)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
