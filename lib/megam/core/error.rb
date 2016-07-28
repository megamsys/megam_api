module Megam
    class Error

        def initialize
            @some_msg = {}
        end


        def some_msg(arg=nil)
            if arg != nil
                @some_msg = arg
            else
                @some_msg
            end
        end

        def error?
            crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
        end

        # Transform the ruby obj ->  to a Hash
        def to_hash
            index_hash = Hash.new
            index_hash["json_claz"] = self.class.name
            index_hash["some_msg"] = some_msg
            index_hash
        end

        # Serialize this object as a hash: called from JsonCompat.
        # Verify if this called from JsonCompat during testing.
        def to_json(*a)
            for_json.to_json(*a)
        end

        def for_json
            result = { }
            result
        end

        # Create a Megam::Account from JSON (used by the backgroud job workers)
        def self.json_create(o)
            acct = new
            acct.some_msg[:code] = o["code"] if o.has_key?("code")
            acct.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            acct.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            acct.some_msg[:links] = o["links"] if o.has_key?("links")
            acct
        end

        def self.from_hash(o)
            acct = self.new()
            acct.from_hash(o)
            acct
        end

        def from_hash(o)
            @some_msg[:code] = o["code"] if o.has_key?("code")
            @some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            @some_msg[:msg]= o["msg"] if o.has_key?("msg")
            @some_msg[:links] = o["links"] if o.has_key?("links")
            self
        end


        def to_s
            Megam::Stuff.styled_hash(to_hash)
            #"---> Megam::Account:[error=#{error?}]\n"+
        end
    end
end
