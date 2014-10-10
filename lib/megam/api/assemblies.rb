module Megam
  class API

    # GET /nodes
    def get_assemblies
      @options = {:path => '/assemblies',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_assemblies(asm_id)
      @options = {:path => "/assemblies/#{asm_id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_assemblies(new_asm)
      @options = {:path => '/assemblies/content',
        :body => Megam::JSONCompat.to_json(new_asm)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

    #Yet to be tested
    # DELETE /nodes/:node_id
    def delete_assemblies(asm_id)
      @options = {:path => '/nodes/#{asm_id}',
        :body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :delete,
        :body     => @options[:body]
      )
    end

  end
end
