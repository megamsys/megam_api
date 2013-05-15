module Megam
  class API

    # GET /logs/:node_id
    def get_logs(node_id, options = {})      
      request(
        :expects  => 200,
        :method   => :get,
        :path     => "/logs/#{node_id}",
        :query    => options
      )
    end

  end
end
