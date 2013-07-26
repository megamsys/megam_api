module Megam
  class API
    #Successfull testing
    # The :api_key, :email, :path are needed to get it encoded in the header (encoded_header)
    # The body content needs to be a json.
    # The OkJson takes a hash of strings so use your symbols and build the json that is needed to be sent.
    def post_auth()
      @options = {:path => '/auth', :body => Megam::JSONCompat.to_json({:nothing =>"nothing in body"})
                 }.merge(@options)

      request(
        :expects  => 200,
	      :method   => :post,
        :body     => @options[:body]

        )
    end
  end
end
