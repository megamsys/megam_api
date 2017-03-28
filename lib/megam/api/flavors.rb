module Megam
    class API

        def get_flavors()
            @options = {:path => "/flavors",:body => ""}.merge(@options)
            request(
                :expects  => 200,
                :method   => :get,
                :body     => @options[:body]
            )
        end

        def get_one_flavor(name)
          @options = { path: "/flavors/#{name}", body: '' }.merge(@options)

          request(
            expects: 200,
            method: :get,
            body: @options[:body]
          )
        end

        def post_flavors(new_flavors)
            @options = {:path => "/flavors/content",
            :body => Megam::JSONCompat.to_json(new_flavors)}.merge(@options)
            request(
                :expects  => 201,
                :method   => :post,
                :body     => @options[:body]
            )
        end

        def update_flavors(update_flavors)
            @options = {:path => '/flavors/update',
            :body => Megam::JSONCompat.to_json(update_flavors)}.merge(@options)

            request(
                :expects  => 201,
                :method   => :post,
                :body     => @options[:body]
            )
        end

        def delete_flavors(delete_flavors)
          @options = {path: "/flavors/#{delete_flavors["name"]}",
                      :body => ''}.merge(@options)

           request(
           :expects  => 200,
           :method   => :delete,
           :body     => @options[:body]
           )
        end

    end
end
