module Megam
    class EventsVm < Megam::RestAdapter
        def initialize(o)
            @account_id = nil
            @assembly_id = nil
            @event_type = nil
            @data = []
            @created_at = nil
            @limit = nil
            @id =nil
            @some_msg = {}
            super(o)
        end

        def eventsvm
            self
        end

        def account_id(arg=nil)
            if arg != nil
                @account_id = arg
            else
                @account_id
            end
        end

        def id(arg=nil)
            if arg != nil
                @id = arg
            else
                @id
            end
        end

        def assembly_id(arg=nil)
            if arg != nil
                @assembly_id = arg
            else
                @assembly_id
            end
        end

        def event_type(arg=nil)
            if arg != nil
                @event_type = arg
            else
                @event_type
            end
        end


        def data(arg=[])
            if arg != []
                @data = arg
            else
                @data
            end
        end

        def limit(arg=[])
            if arg != []
                @limit = arg
            else
                @limit
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
            index_hash["account_id"] = account_id
            index_hash["assembly_id"] = assembly_id
            index_hash["event_type"] = event_type
            index_hash["data"] = data
            index_hash["limit"] = limit
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
                "account_id" => account_id,
                "assembly_id" => assembly_id,
                "event_type" => event_type,
                "data" => data,
                "limit"  => limit,
                "created_at" => created_at,
                "id" => id
            }
            result
        end

        def self.json_create(o)
            evt = new({})
            evt.account_id(o["account_id"]) if o.has_key?("account_id")
            evt.assembly_id(o["assembly_id"]) if o.has_key?("assembly_id")
            evt.event_type(o["event_type"]) if o.has_key?("event_type") #this will be an array? can hash store array?
            evt.data(o["data"]) if o.has_key?("data")
            evt.limit(o["limit"]) if o.has_key?("limit")
            evt.created_at(o["created_at"]) if o.has_key?("created_at")
            evt.some_msg[:code] = o["code"] if o.has_key?("code")
            evt.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            evt.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            evt.some_msg[:links] = o["links"] if o.has_key?("links")
            evt
        end

        def self.from_hash(o)
            evt = self.new(o)
            evt.from_hash(o)
            evt
        end

        def from_hash(o)
            @account_id        = o[:account_id] if o.has_key?(:account_id)
            @assembly_id       = o[:assembly_id] if o.has_key?(:assembly_id)
            @event_type        = o[:event_type] if o.has_key?(:event_type)
            @data              = o[:data] if o.has_key?(:data)
            @limit             = o[:limit] if o.has_key?(:limit)
            @created_at        = o[:created_at] if o.has_key?(:created_at)
            @id                = o[:id] if o.has_key?(:id)
            self
        end

        def self.create(params)
            evt = from_hash(params)
            evt.create
        end

        # Create the node via the REST API
        def create
            megam_rest.post_events(to_hash)
        end

        # Load a account by email_p
        def self.show(o)
 	        evt = from_hash(o)
            evt.megam_rest.get_eventsvm(o[:limit], evt.from_hash(o).for_json)
        end

        def self.list(params)
            asm = self.new(params)
            asm.megam_rest.list_eventsvm(params[:limit])
        end

        def self.index(params)
            asm = self.new(params)
            asm.megam_rest.index_eventsvm
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
