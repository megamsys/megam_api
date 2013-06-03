module Megam
  class API

    # GET /logs/:node_id
    def get_logs(node_id)      
       @options = {:path => '/logs/#{node_id}',
       :body => OkJson.encode({"node_id" => "#{node_id}"})}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :path     => @options[:path],
        :body     => @options[:body]
      )
    end

  end
end
