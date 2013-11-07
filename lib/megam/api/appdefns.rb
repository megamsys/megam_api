module Megam
  class API

    def get_appdefn(node_name)
      @options = {:path => "/appdefns/#{node_name}",:body => ""}.merge(@options)

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
