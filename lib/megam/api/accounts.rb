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

  end
end
