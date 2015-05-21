module Megam
  class API
    def get_discounts
      puts "Entered get discount--weehaa!"
      @options = {:path => '/discounts',:body => ""}.merge(@options)
  puts @options
      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    
    def post_discounts(new_discount)
      @options = {:path => '/discounts/content',
        :body => Megam::JSONCompat.to_json(new_discount)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end
    
    
    def update_discounts(update_discount)
      @options = {:path => '/discounts/update',
      :body => Megam::JSONCompat.to_json(update_discount)}.merge(@options)

   request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )

    end

  end
end
