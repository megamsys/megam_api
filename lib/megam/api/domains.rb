module Megam
  class API

def get_domains(name)

  @options = {:path => "/domains/#{name}",
    :body => ''}.merge(@options)

  request(
    :expects  => 200,
    :method   => :get,
    :body     => @options[:body]
  )
end


def post_domain(new_domain)

      @option = {:path => '/domains/content',
        :body =>  Megam::JSONCompat.to_json(new_domain)}.merge(@options)


              request(
                :expects  => 201,
                :method   => :post,
                :body     => @options[:body]
                )
            end
      end
end
