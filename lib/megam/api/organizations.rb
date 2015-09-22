module Megam
  class API

def get_organizations

  @options = {:path => '/organizations',:body => ''}.merge(@options)

  request(
        :expects => 200,
        :method => :get,
        :body => @options[:body]

  )
 end

def get_organization(id)

  @options = {:path => "/organizations/#{id}",
    :body => ''}.merge(@options)

  request(
    :expects  => 200,
    :method   => :get,
    :body     => @options[:body]
  )
end


def post_organization(new_organization)

      @options = {:path => '/organizations/content',
        :body =>  Megam::JSONCompat.to_json(new_organization)}.merge(@options)


              request(
                :expects  => 201,
                :method   => :post,
                :body     => @options[:body]
                )
            end



    def update_organization(new_organization)

        @options = {:path => '/organizations/update',
            :body =>  Megam::JSONCompat.to_json(new_organization)}.merge(@options)


          request(
              :expects  => 201,
              :method   => :post,
              :body     => @options[:body]
            )
        end
      end
end
