module Megam
  class API
    # GET /nodes
    def list_eventscontainer(limit)
      @options = {:path => "/eventscontainer/#{limit}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end


    def get_eventscontainer(limit, new_events)
      @options = {:path => "/eventscontainer/show/#{limit}",
        :body => Megam::JSONCompat.to_json(new_events)}.merge(@options)
      request(
        :expects  => 200,
        :method   => :post,
        :body     => @options[:body]
      )
    end

    def index_eventscontainer
      @options = {:path => "/eventscontainer",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end
  end
end
