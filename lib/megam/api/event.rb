module Megam
  class API
    def get_events

    end

    def post_event(new_event)
      @options = {:path => '/events/content',
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