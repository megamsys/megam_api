module Megam
  class API
    # GET /nodes
    def list_s
     puts "jhhdsudsaguysgduyasgduyasguydgasgduysgauysgdas"
      @options = {:path => "/snapshots",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_snapshots(asm_id)
      @options = {:path => "/snapshots/#{asm_id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end
    def post_snapshots(new_sps)
      @options = {:path => '/snapshots/content',
        :body => Megam::JSONCompat.to_json(new_sps)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

  end
end
