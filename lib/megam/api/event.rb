module Megam
  class API
    def get_events(id)

    end

    def post_event(new_event)
      puts "Entered the post_event to create a new event too..weehaahoo!"
      @options = {:path => '',
        :body => Megam::JSONCompat.to_json(new_event)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
        )

    end

    def delete_event(event)
    end

  end
end