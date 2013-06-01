module Megam
  class API

    # GET /nodes
    def get_nodes
      request(
        :expects  => 200,
        :method   => :get,
        :path     => "/nodes"
      )
    end

    # GET /nodes/:id
    def get_node(node_id)
      request(
        :expects  => 200,
        :method   => :get,
        :path     => "/nodes/#{node_id}"
      )
    end

    
    # POST /nodes/content
    def post_node(params={})
      request(
        :expects  => 202,
        :method   => :post,
        :path     => '/nodes/content',
        :query    => nodes_params(params)
      )
    end
 
    
    
    # DELETE /nodes/:node_id
    def delete_node(node_id)
      request(
        :expects  => 200,
        :method   => :delete,
        :path     => "/nodes/#{node_id}"
      )
    end

  end
end
