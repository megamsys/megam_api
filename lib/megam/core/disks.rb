module Megam
    class Disks < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @account_id = nil
            @asm_id = nil
            @org_id = nil
            @disk_id= nil
            @size= nil
            @status= nil
            @created_at = nil
            @some_msg = {}
            super(o)
        end

        def disks
            self
        end
        def id(arg=nil)
            if arg != nil
                @id = arg
            else
                @id
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

        def disk_id(arg=nil)
            if arg != nil
                @disk_id = arg
            else
                @disk_id
            end
        end

        def status(arg=nil)
            if arg != nil
                @status = arg
            else
                @status
            end
        end

        def size(arg=nil)
            if arg != nil
                @size = arg
            else
                @size
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
            index_hash["id"] = id
            index_hash["account_id"] = account_id
            index_hash["asm_id"] = asm_id
            index_hash["org_id"] = org_id
            index_hash["disk_id"] = disk_id
            index_hash["size"] = size
            index_hash["status"] = status
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
              "id" => id,
                "account_id" => account_id,
                "asm_id" => asm_id,
                "org_id" => org_id,
                "disk_id" => disk_id,
                "size" => size,
                "status" => status,
                "created_at" => created_at
            }
            result
        end

        def self.json_create(o)
            sps = new({})
            sps.id(o["id"]) if o.has_key?("id")
            sps.account_id(o["account_id"]) if o.has_key?("account_id")
            sps.asm_id(o["asm_id"]) if o.has_key?("asm_id")
            sps.org_id(o["org_id"]) if o.has_key?("org_id") #this will be an array? can hash store array?
            sps.disk_id(o["disk_id"]) if o.has_key?("disk_id")
            sps.size(o["size"]) if o.has_key?("size")
            sps.status(o["status"]) if o.has_key?("status")
            sps.created_at(o["created_at"]) if o.has_key?("created_at")
            sps.some_msg[:code] = o["code"] if o.has_key?("code")
            sps.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            sps.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            sps.some_msg[:links] = o["links"] if o.has_key?("links")
            sps
        end

        def self.from_hash(o)
            dks = self.new(o)
            dks.from_hash(o)
            dks
        end

        def from_hash(o)
            @id       = o[:id] if o.has_key?(:id)
            @account_id       = o[:account_id] if o.has_key?(:account_id)
            @asm_id        = o[:asm_id] if o.has_key?(:asm_id)
            @org_id        = o[:org_id] if o.has_key?(:org_id)
            @disk_id       = o[:disk_id] if o.has_key?(:disk_id)
            @size            = o[:size] if o.has_key?(:size)
            @status          = o[:status] if o.has_key?(:status)
            @created_at      = o[:created_at] if o.has_key?(:created_at)
            self
        end

        def self.create(params)
            dks = from_hash(params)
            dks.create
        end

        # Create the node via the REST API
        def create
            megam_rest.post_disks(to_hash)
        end

        # Load a account by email_p
        def self.show(o)
            dks = self.new(o)
            dks.megam_rest.get_disks(o[:id])
        end

        def self.list(params)
            dks = self.new(params)
            dks.megam_rest.list_disks
        end

        def self.remove(o)
            dks = self.new(o)
            dks.megam_rest.remove_disks(o[:id], o[:disk_id])
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
