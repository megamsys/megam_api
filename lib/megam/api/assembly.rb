module Megam
  class API
    def get_one_assembly(asm_id)

      @options = {:path => "/assembly/#{asm_id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

  end
end
