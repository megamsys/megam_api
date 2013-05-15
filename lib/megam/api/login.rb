module Megam
  class API

    def post_auth(email, password)
      request(
        :expects  => 200,
        :method   => :post,
        :path     => '/auth',
        :query    => { 'email' => username, 'password' => password }
      )
    end

  end
end
