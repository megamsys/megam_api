module Megam
    class Rawimages < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @account_id = nil
            @name = nil
            @repos = nil
            @status = nil
            @inputs = []
            @created_at = nil
            @org_id = nil
            super(o)
        end

        def rawimages
            self
        end

        def id(arg = nil)
            if !arg.nil?
                @id = arg
            else
                @id
            end
        end

        def name(arg = nil)
            if !arg.nil?
                @name = arg
            else
                @name
            end
        end

        def account_id(arg=nil)
            if arg != nil
                @account_id = arg
            else
                @account_id
            end
        end

        def repos(arg = nil)
            if !arg.nil?
                @repos = arg
            else
                @repos
            end
        end

        def inputs(arg = [])
            if arg != []
                @inputs = arg
            else
                @inputs
            end
        end

        def status(arg = nil)
            if !arg.nil?
                @status = arg
            else
                @status
            end
        end

        def created_at(arg = nil)
         if !arg.nil?
          @created_at = arg
         else
          @created_at
         end
        end

        def org_id(arg = nil)
         if !arg.nil?
          @org_id = arg
         else
          @org_id
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
            index_hash['org_id'] = org_id
            index_hash["account_id"] = account_id
            index_hash['name'] = name
            index_hash['repos'] = repos
            index_hash['status'] = status
            index_hash['inputs'] = inputs
            index_hash['created_at'] = created_at
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
                'org_id' => org_id,
                'repos' => repos,
                'inputs' => inputs,
                'status' => status,
                'created_at' => created_at
            }

            result
        end

        def self.json_create(o)
            quo = new({})
            quo.id(o['id']) if o.key?('id')
            quo.org_id(o['org_id']) if o.key?('org_id')
            quo.account_id(o["account_id"]) if o.has_key?("account_id")
            quo.name(o['name']) if o.key?('name')
            quo.repos(o['repos']) if o.key?('repos')
            quo.inputs(o['inputs']) if o.key?('inputs')
            quo.status(o['status']) if o.key?('status')
            quo.created_at(o['created_at']) if o.key?('created_at')
            quo
        end

        def self.from_hash(o)
            quo = new(o)
            quo.from_hash(o)
            quo
        end

        def from_hash(o)
            @id                = o['id'] if o.key?('id')
            @org_id            = o['org_id'] if o.key?('org_id')
            @account_id        = o["account_id"] if o.has_key?("account_id")
            @name              = o['name'] if o.key?('name')
            @region            = o['region'] if o.key?('region')
            @repos             = o['repos'] if o.key?('repos')
            @inputs            = o['inputs'] if o.key?('inputs')
            @status            = o['status'] if o.key?('status')
            @created_at        = o['created_at'] if o.key?('created_at')
            self
        end


        def self.show(params)
            quo = new(params)
            quo.megam_rest.get_one_rawimage(params['id'])
        end

        def self.list(params)
            quo = self.new(params)
            quo.megam_rest.list_rawimages
        end

        def self.create(params)
            quo = from_hash(params)
            quo.create
        end

        def create
            megam_rest.post_rawimages(to_hash)
        end

        # Create the node via the REST API

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end
    end
end
