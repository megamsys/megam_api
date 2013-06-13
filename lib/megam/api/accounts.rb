require_relative "json/okjson"

module Megam
  class API
    # GET /accounts
#Yet to be tested
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

#TESTED with Raj Thilak's system.
    # The body content needs to be a json.
    # The OkJson takes a hash of strings so use your symbols and build the json that is needed to be sent.


    def post_accounts(id, email, api_key, user_type)
      @options = {:path => '/accounts/content', :body => OkJson.encode({
        "id" => "#{id}",
        "email" => email,
        "api_key" => api_key,
        "authority" => "#{user_type}"
      })}.merge(@options)

      request(
        :expects  => 200,
        :method   => :post,
        #:path     => @options[:path],
        :body     => @options[:body]
        )
    end
  end
end
