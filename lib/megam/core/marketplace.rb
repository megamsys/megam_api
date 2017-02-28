module Megam
    class MarketPlace < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @provided_by = nil
            @cattype = nil
            @catorder = nil
            @status = nil
            @flavor = nil
            @image = nil
            @url = nil
            @envs = []
            @options = []
            @inputs = []
            @outputs = []
            @acl_policies = []
            @plans = []
            @created_at = nil
            @updated_at = nil
            @some_msg = {}
            super(o)
        end

        def market_place
            self
        end

        def provided_by(arg = nil)
            if !arg.nil?
                @provided_by = arg
            else
                @provided_by
            end
        end

        def id(arg = nil)
            if !arg.nil?
                @id = arg
            else
                @id
            end
        end

        def plans(arg = [])
            if arg != []
                @plans = arg
            else
                @plans
            end
        end

        def cattype(arg = nil)
            if !arg.nil?
                @cattype = arg
            else
                @cattype
            end
        end

        def flavor(arg = nil)
            if !arg.nil?
                @flavor = arg
            else
                @flavor
            end
        end

        def catorder(arg = nil)
            if !arg.nil?
                @catorder = arg
            else
                @catorder
            end
        end

        def image(arg = nil)
            if !arg.nil?
                @image = arg
            else
                @image
            end
        end

        def url(arg = nil)
            if !arg.nil?
                @url = arg
            else
                @url
            end
        end

        def envs(arg = [])
            if arg != []
                @envs = arg
            else
                @envs
            end
        end

        def options(arg = [])
            if arg != []
                @options = arg
            else
                @options
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

        def status(arg = [])
            if arg != []
                @status = arg
            else
                @status
            end
        end

        def acl_policies(arg = [])
            if arg != []
                @acl_policies = arg
            else
                @acl_policies
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

        def some_msg(arg = nil)
            if !arg.nil?
                @some_msg = arg
            else
                @some_msg
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
            index_hash['provided_by'] = provided_by
            index_hash['cattype'] = cattype
            index_hash['flavor'] = flavor
            index_hash['image'] = image
            index_hash['catorder'] = catorder
            index_hash['url'] = url
            index_hash['envs'] = envs
            index_hash['options'] = options
            index_hash['plans'] = plans
            index_hash['created_at'] = created_at
            index_hash['updated_at'] = updated_at
            index_hash['status'] = status
            index_hash['inputs'] = inputs
            index_hash['outputs'] = outputs
            index_hash['acl_policies'] = acl_policies
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
                'id' => id,
                'provided_by' => provided_by,
                'cattype' => cattype,
                'flavor' => flavor,
                'image' => image,
                'catorder' => catorder,
                'url' => url,
                'envs' => envs,
                'options' => options,
                'plans' => plans,
                'created_at' => created_at,
                'updated_at' => updated_at,
                'status' => status,
                'inputs' => inputs,
                'outputs' => outputs,
                'acl_policies' => acl_policies
            }
            result
        end

        def self.json_create(o)
            app = new({})
            app.id(o['id']) if o.key?('id')
            app.provided_by(o['provided_by']) if o.key?('provided_by')
            app.cattype(o['cattype']) if o.key?('cattype')
            app.flavor(o['flavor']) if o.key?('flavor')
            app.image(o['image']) if o.key?('image')
            app.catorder(o['catorder']) if o.key?('catorder')
            app.url(o['url']) if o.key?('url')
            app.envs(o['envs']) if o.key?('envs')
            app.options(o['options']) if o.key?('options')
            app.plans(o['plans']) if o.key?('plans')
            app.created_at(o['created_at']) if o.key?('created_at')
            app.updated_at(o['updated_at']) if o.key?('updated_at')
            app.inputs(o['inputs']) if o.key?('inputs')
            app.outputs(o['outputs']) if o.key?('outputs')
            app.status(o['status']) if o.key?('status')
            app.acl_policies(o['acl_policies']) if o.key?('acl_policies')
            #success or error
            app.some_msg[:code] = o["code"] if o.has_key?("code")
            app.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            app.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            app.some_msg[:links] = o["links"] if o.has_key?("links")
            app
        end

        def self.from_hash(o)
            app = new(o)
            app.from_hash(o)
            app
        end

        def from_hash(o)
            @provided_by    = o['provided_by'] if o.key?('provided_by')
            @id             = o['id'] if o.key?('id')
            @cattype        = o['cattype'] if o.key?('cattype')
            @flavor         = o['flavor'] if o.key?('flavor')
            @image          = o['image'] if o.key?('image')
            @catorder       = o['catorder'] if o.key?('catorder')
            @url            = o['url'] if o.key?('url')
            @envs           = o['envs'] if o.key?('envs')
            @options        = o['options'] if o.key?('options')
            @plans          = o['plans'] if o.key?('plans')
            @created_at     = o['created_at'] if o.key?('created_at')
            @updated_at     = o['updated_at'] if o.key?('updated_at')
            @status         = o['status'] if o.key?('status')
            @inputs         = o['inputs'] if o.key?('inputs')
            @outputs        = o['outputs'] if o.key?('outputs')
            @acl_policies   = o['acl_policies'] if o.key?('acl_policies')
            self
        end

        def self.create(params)
            acct = from_hash(params)
            acct.create
        end

        # Create the marketplace app via the REST API
        def create
            megam_rest.post_marketplaceapp(to_hash)
        end

        # Load a account by email_p
        def self.show(params)
            app = new(params)
            app.megam_rest.get_marketplaceapp(params['id'])
        end

        def self.list(params)
            app = new(params)
            app.megam_rest.get_marketplaceapps
        end

        def self.list_provider(params)
            app = new(params)
            app.megam_rest.get_marketplaceprovider(params['provider'])
        end

        def self.list_flavor(params)
            app = new(params)
            app.megam_rest.get_marketplaceflavor(params['flavor'])
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
            # "---> Megam::Account:[error=#{error?}]\n"+
        end
    end
end
