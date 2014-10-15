module Megam
  class API
    def get_components(comp_id)
      @options = {:path => "/components/#{comp_id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

  end
end
