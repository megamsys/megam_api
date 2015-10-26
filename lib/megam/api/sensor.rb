module Megam
  class API
    def get_sensors
      @options = {:path => '/sensor',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_sensor(id)
      @options = {:path => "/sensor/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_sensor(new_sensor)
      @options = {:path => '/sensor/content',
        :body => Megam::JSONCompat.to_json(new_sensor)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
