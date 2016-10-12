module Megam
    class License < Megam::RestAdapter
        def initialize(o)
            @data = nil
            @some_msg = {}
            super(o)
        end

        def license
            self
        end


        def data(arg=nil)
            if arg != nil
                @data = arg
            else
                @data
            end
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
            index_hash["data"] = data
            index_hash
        end

        # Serialize this object as a hash: called from JsonCompat.
        # Verify if this called from JsonCompat during testing.
        def to_json(*a)
            for_json.to_json(*a)
        end

        def for_json
            result = {
                "data" => data
            }
            result
        end

        #
        def self.json_create(o)
            license = new({})
             license.data(o["results"]["data"]) if o["results"]
            #success or error
            license.some_msg[:code] = o["code"] if o.has_key?("code")
            license.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            license.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            license.some_msg[:links] = o["links"] if o.has_key?("links")
            license
        end

        def self.from_hash(o)
            license = self.new(o)
            license.from_hash(o)
            license
        end

        def from_hash(o)
            @data   = o[:data] if o.has_key?(:data)
            self
        end

        def self.create(params)
            acct = from_hash(params)
            acct.create
        end

        # Create the predef via the REST API
        def create
            megam_rest.post_license(to_hash)
        end

        # Show a particular License by id,
        # Megam::License
        def self.show(params)
            pre = self.new(params)
            pre.megam_rest.get_license(params["id"])
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
            #"---> Megam::Account:[error=#{error?}]\n"+
        end

    end
end
