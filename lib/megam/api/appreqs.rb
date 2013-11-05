module Megam
  class API

=begin
    def get_appreq(node_name)
      @options = {:path => "/appdefns/#{node_name}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end
=end
    def post_appreq(new_appreq)
      @options = {:path => '/appreqs/content',
        :body => Megam::JSONCompat.to_json(new_appreq)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
