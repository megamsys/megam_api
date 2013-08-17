module Megam
  class API
    def get_cloudtools
      @options = {:path => '/cloudtools',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_cloudtool(cloudtool_name)
      @options = {:path => "/cloudtools/#{cloudtool_name}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_cloudtool(new_cloudtool)
      @options = {:path => '/cloudtools/content',
        :body => Megam::JSONCompat.to_json(new_cloudtool)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end