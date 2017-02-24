module Megam
  class API

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

    def get_marketplaceprovider(provider)
      @options = {:path => "/marketplaces/p/#{provider}" ,:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_marketplaceflavor(flavor)
      @options = {:path => "/marketplaces/f/#{flavor}",:body => ""}.merge(@options)
      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_marketplaceapp(catitem)
      @options = {:path => '/marketplaces/content',
        :body => Megam::JSONCompat.to_json(catitem)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

    #Yet to be tested
    # DELETE /marketplacess/:node_id
    def delete_marketplaceapp(catitem_id)
      @options = {:path => '/marketplaces/#{catitem_id}',
        :body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :delete,
        :body     => @options[:body]
      )
    end

  end
end
