module Megam
  class API
  
   def post_auth(username, password)
   request(
        :expects  => 200,
        :method   => :post, 
        :path     => '/auth',
        :query    => { 'email' => username, 'password' => password }
        )
    end
    end
end
