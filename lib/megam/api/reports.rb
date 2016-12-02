module Megam
  class API
    def post_reports(new_sps)
     puts "56156156156156156156156156156156151561561561565+++++++++++++++++++++++++"
      @options = {:path => '/reports/content',
        :body => Megam::JSONCompat.to_json(new_sps)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
