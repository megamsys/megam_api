module Megam
  class API

    # GET /nodes
    def get_nodes
      @options = {:path => '/nodes',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_node(node_id)
      @options = {:path => "/nodes/#{node_id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_node(new_node)
      @options = {:path => '/nodes/content',
        :body => Megam::JSONCompat.to_json(new_node)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

    #Yet to be tested
    # DELETE /nodes/:node_id
    def delete_node(node_id)
      @options = {:path => '/nodes/#{node_id}',
        :body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :delete,
        :body     => @options[:body]
      )
    end

  end
end
