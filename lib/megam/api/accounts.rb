require_relative "json/okjson"

module Megam
  class API
    # GET /accounts
    def get_accounts(email)
     
      @options = {:path => '/accounts', 
        :body => OkJson.encode({"email" => "#{email}"})}.merge(@options)
    
      request(
        :expects  => 200,
        :method   => :get,
        :path     => @options[:path],
        :body     => @options[:body]
      )
    end

    def post_accounts(id, email, api_key, user_type)

      @options = {:path => '/accounts', :body => OkJson.encode({
        "id" => "#{id}",
        "email" => "#{email}",
        "sharedprivatekey" => "#{api_key}",
        "authority" => "#{user_type}"
      })}.merge(@options)
      
      request(
        :expects  => 200,
        :method   => :post,
        :path     => @options[:path],
        :body     => @options[:body]
        )
    end
  end
end
