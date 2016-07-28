module Megam
    class Snapshots < Megam::RestAdapter
        def initialize(o)
            @snap_id = nil
            @account_id = nil
            @asm_id = nil
            @org_id = nil
            @name= nil
            @created_at = nil
            @some_msg = {}
            super(o)
        end

        def snapshots
            self
        end
        def snap_id(arg=nil)
            if arg != nil
                @snap_id = arg
            else
                @snap_id
            end
        end

        def account_id(arg=nil)
            if arg != nil
                @account_id = arg
            else
                @account_id
            end
        end

        def asm_id(arg=nil)
            if arg != nil
                @asm_id = arg
            else
                @asm_id
            end
        end

        def org_id(arg=nil)
            if arg != nil
                @org_id = arg
            else
                @org_id
            end
        end

        def name(arg=nil)
            if arg != nil
                @name = arg
            else
                @name
            end
        end

        def created_at(arg=nil)
            if arg != nil
                @created_at = arg
            else
                @created_at
            end
        end

        def error?
            crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
        end


        def some_msg(arg=nil)
            if arg != nil
                @some_msg = arg
            else
                @some_msg
            end
        end


        # Transform the ruby obj ->  to a Hash
        def to_hash
            index_hash = Hash.new
            index_hash["json_claz"] = self.class.name
            index_hash["snap_id"] = snap_id
            index_hash["account_id"] = account_id
            index_hash["asm_id"] = asm_id
            index_hash["org_id"] = org_id
            index_hash["name"] = name
            index_hash["created_at"] = created_at
            index_hash["some_msg"] = some_msg
            index_hash
        end

        # Serialize this object as a hash: called from JsonCompat.
        # Verify if this called from JsonCompat during testing.
        def to_json(*a)
            for_json.to_json(*a)
        end

        def for_json
            result = {
              "snap_id" => snap_id,
                "account_id" => account_id,
                "asm_id" => asm_id,
                "org_id" => org_id,
                "name" => name,
                "created_at" => created_at
            }
            result
        end

        def self.json_create(o)
            sps = new({})
            sps.snap_id(o["snap_id"]) if o.has_key?("snap_id")
            sps.account_id(o["account_id"]) if o.has_key?("account_id")
            sps.asm_id(o["asm_id"]) if o.has_key?("asm_id")
            sps.org_id(o["org_id"]) if o.has_key?("org_id") #this will be an array? can hash store array?
            sps.name(o["name"]) if o.has_key?("name")
            sps.created_at(o["created_at"]) if o.has_key?("created_at")
            sps.some_msg[:code] = o["code"] if o.has_key?("code")
            sps.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            sps.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            sps.some_msg[:links] = o["links"] if o.has_key?("links")
            sps
        end

        def self.from_hash(o)
            sps = self.new(o)
            sps.from_hash(o)
            sps
        end

        def from_hash(o)
            @snap_id       = o[:snap_id] if o.has_key?(:snap_id)
            @account_id       = o[:account_id] if o.has_key?(:account_id)
            @asm_id        = o[:asm_id] if o.has_key?(:asm_id)
            @org_id        = o[:org_id] if o.has_key?(:org_id)
            @name            = o[:name] if o.has_key?(:name)
            @created_at        = o[:created_at] if o.has_key?(:created_at)
            self
        end

        def self.create(params)
            sps = from_hash(params)
            sps.create
        end

        # Create the node via the REST API
        def create
            megam_rest.post_snapshots(to_hash)
        end

        # Load a account by email_p
        def self.show(o)
            sps = self.new(o)
            sps.megam_rest.get_snapshots(o[:asm_id])
        end

        def self.list(params)
            sps = self.new(params)
            sps.megam_rest.list_snapshots
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
