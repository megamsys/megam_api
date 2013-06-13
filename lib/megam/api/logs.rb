module Megam
  class API

    # PUT /logs/:node_id
#empty body posted to get the logs
#path having the node_id which is the key_name to fetch that particular log
    def get_logs(node_id)      
       @options = {:path => "/logs/#{node_id}",
       :body => OkJson.encode({:nothing =>"nothing in body"})}.merge(@options)

      request(
        :expects  => 200,
        :method   => :post,
        #:path     => @options[:path],
        :body     => @options[:body]
      )
    end

  end
end
