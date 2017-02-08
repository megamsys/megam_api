module Megam
  class API

    def get_one_quota(name)
      @options = { path: "/quotas/#{name}", body: '' }.merge(@options)

      request(
        expects: 200,
        method: :get,
        body: @options[:body]
      )
    end

    def update_quotas(new_asm)
      @options = { path: '/quotas/update',
                   body: Megam::JSONCompat.to_json(new_asm) }.merge(@options)

      request(
        expects: [200, 201],
        method: :post,
        body: @options[:body]
      )
   end

   def list_quotas
     @options = {:path => "/quotas",:body => ""}.merge(@options)

     request(
       :expects  => 200,
       :method   => :get,
       :body     => @options[:body]
     )
   end

   def post_quotas(new_sps)
     @options = {:path => '/quotas/content',
         :body => Megam::JSONCompat.to_json(new_sps)}.merge(@options)

     request(
       :expects  => [200,201],
       :method   => :post,
       :body     => @options[:body]
     )
   end

  end
end
