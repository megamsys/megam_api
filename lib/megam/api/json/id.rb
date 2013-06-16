require_relative "json/okjson"

module Megam
  class API
    # GET /id
    #Yet to be tested
    def get_id

      @options = {:path => '/id',
        :body => OkJson.encode({"nothing" => "nothing"})}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :path     => @options[:path],
        :body     => @options[:body]
      )
    end

  end
end