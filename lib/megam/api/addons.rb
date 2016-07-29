
module Megam
  class API

    def get_addon(name)
      @options = {:path => "/addons/#{name}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_addons(new_addon)
      @options = {:path => '/addons/content',
        :body => Megam::JSONCompat.to_json(new_addon)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
