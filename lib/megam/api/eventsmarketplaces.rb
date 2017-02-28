module Megam
  class API
    # GET /nodes
    def list_eventsMarketplaces(limit)
      @options = {:path => "/eventsmarketplaces/#{limit}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end


    def get_eventsMarketplaces(limit, new_events)
      @options = {:path => "/eventsmarketplaces/show/#{limit}",
        :body => Megam::JSONCompat.to_json(new_events)}.merge(@options)
      request(
        :expects  => 200,
        :method   => :post,
        :body     => @options[:body]
      )
    end

    def index_eventsMarketplaces
      @options = {:path => "/eventsmarketplaces",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end
  end
end
