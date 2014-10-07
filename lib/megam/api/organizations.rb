module Megam
  class API

def get_organizations(name)

  @options = {:path => "/organizations/#{name}",
    :body => ''}.merge(@options)

  request(
    :expects  => 200,
    :method   => :get,
    :body     => @options[:body]
  )
end


def post_organizations(new_organization)

      @options = {:path => '/organizations/content',
        :body =>  Megam::JSONCompat.to_json(new_organization)}.merge(@options)


              request(
                :expects  => 201,
                :method   => :post,
                :body     => @options[:body]
                )
            end
      end
end
