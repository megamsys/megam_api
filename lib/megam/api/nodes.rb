module Megam
  class API

    # GET /nodes
    def get_nodes
      @options = {:path => '/nodes',
        :body => OkJson.encode({"email" => "#{email}"})}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :path     => @options[:path],
        :body     => @options[:body]
      )
    end

    # GET /nodes/:id
    def get_node(node_id)
      @options = {:path => '/nodes/#{node_id}',
        :body => OkJson.encode({"node_id" => "#{node_id}"})}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :path     => @options[:path],
        :body     => @options[:body]
      )
    end

    
    # POST /nodes/content
    def post_node(id, email, api_key, user_type)
      @options = {:path => '/nodes/content', :body => OkJson.encode({
        "id" => "#{id}",
        "email" => email,
        "api_key" => api_key,
        "authority" => "#{user_type}"
      })}.merge(@options)

      request(
        :expects  => 200,
        :method   => :post,
        :path     => @options[:path],
        :body     => @options[:body]
      )
    end
 
    
    
    # DELETE /nodes/:node_id
    def delete_node(node_id)
      @options = {:path => '/nodes/#{node_id}',
        :body => OkJson.encode({"node_id" => "#{node_id}"})}.merge(@options)

      request(
        :expects  => 200,
        :method   => :delete,
        :path     => @options[:path],
        :body     => @options[:body]
      )
    end

  end
end
