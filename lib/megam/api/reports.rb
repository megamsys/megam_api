module Megam
  class API

   def post_reports(new_sps)
     @options = {:path => '/admin/reports/content',
         :body => Megam::JSONCompat.to_json(new_sps)}.merge(@options)

     request(
       :expects  => 200,
       :method   => :post,
       :body     => @options[:body]
     )
   end
  end
end
