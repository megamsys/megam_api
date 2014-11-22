module Megam
  class API

    # GET /csars
    def get_csars
      @options = {:path => '/csars',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_csar(id)
      @options = {:path => "/csars/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_csar(new_csar)
      @options = {:path => '/csars/content',
        :body => new_csar}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end
    
    def push_csar(id)
      @options = {:path => "/csars/push/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 201,
        :method   => :get,
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
