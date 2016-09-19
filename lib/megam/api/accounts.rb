module Megam
  class API
    # GET /accounts
    #Yet to be tested
    def get_accounts(email)
      @options = {:path => "/accounts/#{email}",
        :body => ''}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    # The body content needs to be a json.
    def login(new_account)
      @options = {:path => '/accounts/login',
      :body => Megam::JSONCompat.to_json(new_account)}.merge(@options)

      request(
        :expects  => 302,
        :method   => :post,
        :body     => @options[:body]
        )
    end
    
    # The body content needs to be a json.
    def post_accounts(new_account)
      @options = {path: '/accounts/content',
                  body:  Megam::JSONCompat.to_json(new_account)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
        )
    end

    def update_accounts(update_account)
      @options = {path: '/accounts/update', passthru: true,
                  body: Megam::JSONCompat.to_json(update_account)}.merge(@options)

      request(
      :expects => 201,
      :method => :post,
      :body => @options[:body]
      )
    end

    def forgot(account)
      @options = { path:  "/accounts/forgot/#{account["email"]}", passthru: true,
                   body: ''}.merge(@options)

      request(
      :expects => 201,
      :method => :get,
      :body => @options[:body]
      )
    end

    def password_reset(account)
      @options = {:path => "/accounts/password_reset", passthru: true,
                  body: Megam::JSONCompat.to_json(account)}.merge(@options)

      request(
      :expects => 201,
      :method => :post,
      :body => @options[:body]
      )
    end

  end
end