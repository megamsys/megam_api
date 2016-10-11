module Megam
    class License < Megam::RestAdapter
        def initialize(o)
            @org_id = nil
            @data = nil
            @some_msg = {}
            super(o)
        end

        def license
            self
        end

        def org_id(arg=nil)
            if arg != nil
                @org_id= arg
            else
                @org_id
            end
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
            index_hash["org_id"] = org_id
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
                "org_id" => org_id,
                "data" => data
            }
            result
        end

        #
        def self.json_create(o)
            license = new({})
            license.created_at(o["data"]) if o.has_key?("data")
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
            @org_id = o[:org_id] if o.has_key?(:org_id)
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

        # Load all license -
        # returns a LicensesCollection
        # don't return self. check if the Megam::LicenseCollection is returned.
        def self.list(params)
            license = self.new(params)
            license.megam_rest.get_license
        end

        # Show a particular License by name,
        # Megam::License
        def self.show(params)
            pre = self.new(params)
            pre.megam_rest.get_license(params["name"])
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
            #"---> Megam::Account:[error=#{error?}]\n"+
        end

    end
end
