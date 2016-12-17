module Megam
    class Quotas < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @account_id = nil
            @name = nil
            @cost = nil
            @allowed = nil
            @allocated_to = nil
            @inputs = []
            @created_at = nil
            @updated_at = nil
            super(o)
        end

        def quotas
            self
        end

        def id(arg = nil)
            if !arg.nil?
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

        def name(arg = nil)
            if !arg.nil?
                @name = arg
            else
                @name
            end
        end

        def cost(arg = nil)
            if !arg.nil?
                @cost = arg
            else
                @cost
            end
        end

        def allowed(arg = nil)
            if !arg.nil?
                @allowed = arg
            else
                @allowed
            end
        end

        def allocated_to(arg = nil)
            if !arg.nil?
                @allocated_to = arg
            else
                @allocated_to
            end
        end

        def inputs(arg = [])
            if arg != []
                @inputs = arg
            else
                @inputs
            end
        end

        def created_at(arg = nil)
         if !arg.nil?
          @created_at = arg
         else
          @created_at
         end
        end

        def updated_at(arg = nil)
         if !arg.nil?
          @updated_at = arg
         else
          @updated_at
         end
        end

        def error?
            crocked = true if some_msg.key?(:msg_type) && some_msg[:msg_type] == 'error'
        end

        # Transform the ruby obj ->  to a Hash
        def to_hash
            index_hash = {}
            index_hash['json_claz'] = self.class.name
            index_hash['id'] = id
            index_hash["account_id"] = account_id
            index_hash['name'] = name
            index_hash['cost'] = cost
            index_hash['allowed'] = allowed
            index_hash['allocated_to'] = allocated_to
            index_hash['inputs'] = inputs
            index_hash['created_at'] = created_at
            index_hash['updated_at'] = updated_at
            index_hash
        end

        # Serialize this object as a hash: called from JsonCompat.
        # Verify if this called from JsonCompat during testing.
        def to_json(*a)
            for_json.to_json(*a)
        end

        def for_json
            result = {
                'id' => id,
                'account_id' => account_id,
                'name' => name,
                'cost' => cost,
                'allowed' => allowed,
                'allocated_to' => allocated_to,
                'inputs' => inputs,
                'created_at' => created_at,
                'updated_at' => updated_at
            }

            result
        end

        def self.json_create(o)
            quo = new({})
            quo.id(o['id']) if o.key?('id')
            quo.account_id(o["account_id"]) if o.has_key?("account_id")
            quo.name(o['name']) if o.key?('name')
            quo.cost(o['cost']) if o.key?('cost')
            quo.allowed(o['allowed']) if o.key?('allowed')
            quo.allocated_to(o['allocated_to']) if o.key?('allocated_to') # this will be an array? can hash store array?
            quo.inputs(o['inputs']) if o.key?('inputs')
            quo.created_at(o['created_at']) if o.key?('created_at')
            quo.updated_at(o['updated_at']) if o.key?('updated_at')
            quo
        end

        def self.from_hash(o)
            quo = new(o)
            quo.from_hash(o)
            quo
        end

        def from_hash(o)
            @id                = o['id'] if o.key?('id')
            @account_id        = o["account_id"] if o.has_key?("account_id")
            @name              = o['name'] if o.key?('name')
            @cost              = o['cost'] if o.key?('cost')
            @allowed           = o['allowed'] if o.key?('allowed')
            @allocated_to      = o['allocated_to'] if o.key?('allocated_to')
            @inputs            = o['inputs'] if o.key?('inputs')
            @created_at        = o['created_at'] if o.key?('created_at')
            @updated_at        = o['updated_at'] if o.key?('updated_at')
            self
        end


        def self.show(params)
            quo = new(params)
            quo.megam_rest.get_one_quota(params['id'])
        end

        def self.update(params)
            quo = from_hash(params)
            quo.update
        end

        def self.list(params)
            quo = self.new(params)
            quo.megam_rest.list_quotas
        end

        def self.create(params)
            quo = from_hash(params)
            quo.create
        end

        def create
            megam_rest.post_quotas(to_hash)
        end

        # Create the node via the REST API
        def update
            megam_rest.update_quotas(to_hash)
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end
    end
end
