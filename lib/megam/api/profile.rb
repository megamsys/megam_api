module Megam
  class API

def get_profile

  @options = {:path => '/profile',:body => ''}.merge(@options)

  request(
        :expects => 200,
        :method => :get,
        :body => @options[:body]

  )
 end

def get_profile(name)

  @options = {:path => "/profile/#{name}",
    :body => ''}.merge(@options)

  request(
    :expects  => 200,
    :method   => :get,
    :body     => @options[:body]
  )
end


def post_profile(new_profile_details)

      @options = {:path => '/profile/content',
        :body =>  Megam::JSONCompat.to_json(new_profile_details)}.merge(@options)


              request(
                :expects  => 201,
                :method   => :post,
                :body     => @options[:body]
                )
            end
      end
end
