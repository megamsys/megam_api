module Megam
  class API
    # GET /nodes
    def list_eventsstorage(limit)
      @options = {:path => "/eventsstorage/#{limit}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def index_eventsstorage
      @options = {:path => "/eventsstorage",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end
  end
end
