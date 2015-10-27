module Megam
  class API
    def get_sensors
      @options = {:path => '/sensors',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_sensor(id)
      @options = {:path => "/sensors/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_sensors(new_sensors)
      @options = {:path => '/sensors/content',
        :body => Megam::JSONCompat.to_json(new_sensors)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
