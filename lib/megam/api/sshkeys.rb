module Megam
  class API
    def get_sshkeys
      @options = {:path => '/sshkeys',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_sshkey(sshkey_name)
      @options = {:path => "/sshkeys/#{sshkey_name}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_sshkey(new_sshkey)
      @options = {:path => '/sshkeys/content',
        :body => Megam::JSONCompat.to_json(new_sshkey)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
