module Megam
  class API

#=begin
    def get_addons(node_name)
      @options = {:path => "/marketplaceaddons/#{node_name}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end
#=end
    def post_addon(new_addon)
      @options = {:path => '/marketplaceaddons/content',
        :body => Megam::JSONCompat.to_json(new_addon)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
