module Megam
  class API
    # GET /nodes
    def list_disks
      @options = {:path => "/disks",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_disks(asm_id)
      @options = {:path => "/disks/#{asm_id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end
    def post_disks(new_dsk)
      @options = {:path => '/disks/content',
        :body => Megam::JSONCompat.to_json(new_dsk)}.merge(@options)
      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
