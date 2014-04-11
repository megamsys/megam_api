module Megam
  class API

    # GET /nodes
    def get_marketplaceapps
      @options = {:path => '/marketplaces',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_marketplaceapp(id)
      @options = {:path => "/marketplaces/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )     
    end

    def post_marketplaceapp(new_node)
      @options = {:path => '/marketplaces/content',
        :body => Megam::JSONCompat.to_json(new_node)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

    #Yet to be tested
    # DELETE /marketplacess/:node_id
    def delete_marketplaceapp(node_id)
      @options = {:path => '/marketplaces/#{node_id}',
        :body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :delete,
        :body     => @options[:body]
      )
    end

  end
end
