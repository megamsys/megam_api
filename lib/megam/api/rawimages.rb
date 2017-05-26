module Megam
  class API

    def get_one_rawimage(name)
      @options = { path: "/rawimages/#{name}", body: '' }.merge(@options)

      request(
        expects: 200,
        method: :get,
        body: @options[:body]
      )
    end

   def list_rawimages
     @options = {:path => "/rawimages",:body => ""}.merge(@options)

     request(
       :expects  => 200,
       :method   => :get,
       :body     => @options[:body]
     )
   end

   def post_rawimages(rawimage_item)
     @options = {:path => '/rawimages/content',
         :body => Megam::JSONCompat.to_json(rawimage_item)}.merge(@options)

     request(
       :expects  => 201,
       :method   => :post,
       :body     => @options[:body]
     )
   end

  end
end
