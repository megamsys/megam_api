module Megam
  class API
    def get_clouddeployers
      @options = {:path => '/clouddeployers',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_clouddeployer(clouddep_name)
      @options = {:path => "/clouddeployers/#{clouddep_name}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_clouddeployer(new_clouddep)
      @options = {:path => '/clouddeployers/content',
        :body => Megam::JSONCompat.to_json(new_clouddep)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end