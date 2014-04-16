module Megam
  class API


    def get_boltdefn(boltdefns_id)
      @options = {:path => "/boltdefns/#{boltdefns_id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_boltdefn(new_boltdefn)
      @options = {:path => '/boltdefns/content',
        :body => Megam::JSONCompat.to_json(new_boltdefn)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  def update_boltdefn(new_boltdefn)
      @options = {:path => '/boltdefns/update',
        :body => Megam::JSONCompat.to_json(new_boltdefn)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end


  end
end
