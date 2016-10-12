module Megam
  class API

    def get_license(license_id)
      @options = {:path => "/licenses/#{license_id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_license(new_license)
      @options = {:path => '/licenses/content',
        :body => Megam::JSONCompat.to_json(new_license)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
