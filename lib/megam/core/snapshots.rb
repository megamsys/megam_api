module Megam
    class Snapshots < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @account_id = nil
            @asm_id = nil
            @org_id = nil
            @tosca_type = nil
            @inputs = []
            @outputs = []
            @name= nil
            @status=nil
            @disk_id=nil
            @snap_id=nil
            @created_at = nil
            @updated_at = nil
            @some_msg = {}
            super(o)
        end

        def snapshots
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

        def tosca_type(arg = nil)
            if !arg.nil?
                @tosca_type = arg
            else
                @tosca_type
            end
        end

        def inputs(arg = [])
            if arg != []
                @inputs = arg
            else
                @inputs
            end
        end

        def outputs(arg = [])
            if arg != []
                @outputs = arg
            else
                @outputs
            end
        end

        def name(arg=nil)
            if arg != nil
                @name = arg
            else
                @name
            end
        end

        def status(arg=nil)
            if arg != nil
                @status = arg
            else
                @status
            end
        end

        def disk_id(arg=nil)
            if arg != nil
                @disk_id = arg
            else
                @disk_id
            end
        end

        def snap_id(arg=nil)
            if arg != nil
                @snap_id = arg
            else
                @snap_id
            end
        end

        def created_at(arg=nil)
            if arg != nil
                @created_at = arg
            else
                @created_at
            end
        end

         def updated_at(arg=nil)
            if arg != nil
                @updated_at = arg
            else
                @updated_at
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
            index_hash["tosca_type"] = tosca_type
            index_hash["inputs"] = inputs
            index_hash["outputs"] = outputs
            index_hash["name"] = name
            index_hash["status"] = status
            index_hash["disk_id"] = disk_id
            index_hash["snap_id"] = snap_id
            index_hash["created_at"] = created_at
            index_hash["updated_at"] = updated_at
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
                "tosca_type" => tosca_type,
                "inputs" => inputs,
                "outputs" => outputs,
                "name" => name,
                "status" => status,
                "disk_id" => disk_id,
                "snap_id" => snap_id,
                "created_at" => created_at,
                "updated_at" => updated_at
            }
            result
        end

        def self.json_create(o)
            sps = new({})
            sps.id(o["id"]) if o.has_key?("id")
            sps.account_id(o["account_id"]) if o.has_key?("account_id")
            sps.asm_id(o["asm_id"]) if o.has_key?("asm_id")
            sps.org_id(o["org_id"]) if o.has_key?("org_id") #this will be an array? can hash store array?
            sps.tosca_type(o['tosca_type']) if o.key?('tosca_type')
            sps.inputs(o['inputs']) if o.key?('inputs')
            sps.outputs(o['outputs']) if o.key?('outputs')
            sps.name(o["name"]) if o.has_key?("name")
            sps.status(o["status"]) if o.has_key?("status")
            sps.disk_id(o["disk_id"]) if o.has_key?("disk_id")
            sps.snap_id(o["snap_id"]) if o.has_key?("snap_id")
            sps.created_at(o["created_at"]) if o.has_key?("created_at")
            sps.created_at(o["updated_at"]) if o.has_key?("updated_at")
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
            @id       = o[:id] if o.has_key?(:id)
            @account_id       = o[:account_id] if o.has_key?(:account_id)
            @asm_id        = o[:asm_id] if o.has_key?(:asm_id)
            @org_id        = o[:org_id] if o.has_key?(:org_id)
            @tosca_type        = o[:tosca_type] if o.key?(:tosca_type)
            @inputs            = o[:inputs] if o.key?(:inputs)
            @outputs           = o[:outputs] if o.key?(:outputs)
            @name            = o[:name] if o.has_key?(:name)
            @status            = o[:status] if o.has_key?(:status)
            @disk_id          = o[:disk_id] if o.has_key?(:disk_id)
            @snap_id          = o[:snap_id] if o.has_key?(:snap_id)
            @created_at        = o[:created_at] if o.has_key?(:created_at)
            @updated_at        = o[:updated_at] if o.has_key?(:updated_at)
            self
        end

        def self.create(params)
            sps = from_hash(params)
            sps.create
        end

        def self.update(params)
            sps = from_hash(params)
            sps.update
        end

        # Create the node via the REST API
        def create
            megam_rest.post_snapshots(to_hash)
        end

        # Load a account by email_p
        def self.show(o)
            sps = self.new(o)
            sps.megam_rest.get_snapshots(o[:id])
        end

        def self.list(params)
            sps = self.new(params)
            sps.megam_rest.list_snapshots
        end

        def update
            megam_rest.update_snapshots(to_hash)
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
