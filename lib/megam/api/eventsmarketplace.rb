module Megam
  class API
    # GET /nodes
    def list_eventsMarketplace(limit)
      @options = {:path => "/eventsmarketplace/#{limit}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end


    def get_eventsMarketplace(limit, new_events)
      @options = {:path => "/eventsmarketplace/show/#{limit}",
        :body => Megam::JSONCompat.to_json(new_events)}.merge(@options)
      request(
        :expects  => 200,
        :method   => :post,
        :body     => @options[:body]
      )
    end

    def index_eventsMarketplace
      @options = {:path => "/eventsmarketplace",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end
  end
end
