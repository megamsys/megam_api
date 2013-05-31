require 'json'
#require 'httparty'

module Megam
  class API

    # GET /accounts
    def get_accounts
      request(
        :expects  => 200,
        :method   => :get,
        :path     => "/accounts"
      )
    end
    
    def post_accounts(id, email, api_key, user_type)

	tempHash = {
	    "id" => "#{id}",
	    "email" => "#{email}",
	    "sharedprivatekey" => "#{api_key}",
	    "authority" => "#{user_type}"
	}
	account_json = JSON.pretty_generate(tempHash)

puts 'JSON	'+account_json
	#options = {:path => '/accounts', :body => "#{account_json}"}
	options = {:path => '/accounts', :body => Megam.OkJson.encode("#{tempHash}")}
puts "OPTIONS	"
puts options
      request(
        :expects  => 200,
        :method   => :post,
        :path     => options[:path],
        :body     => options[:body]
        )
    end
  end
end
