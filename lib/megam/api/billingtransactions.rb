module Megam
  class API
    def get_billingtransactions
      @options = {:path => '/billingtransactions',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_billingtransactions(new_billtransaction)
      @options = {:path => '/billingtransactions/content',
        :body => Megam::JSONCompat.to_json(new_billtransaction)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
