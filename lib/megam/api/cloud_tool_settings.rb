module Megam
  class API
    def get_cloudtoolsettings
      @options = {:path => '/cloudtoolsettings',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_cloudtoolsetting(id)
      @options = {:path => "/cloudtoolsettings/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_cloudtoolsetting(new_cloudtoolsetting)
      @options = {:path => '/cloudtoolsettings/content',
        :body => Megam::JSONCompat.to_json(new_cloudtoolsetting)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
