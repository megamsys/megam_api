module Megam
    class Flavors < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @org_id = nil
            @account_id = nil
            @name = nil
            @cpu = nil
            @ram = nil
            @disk = nil
            @regions = []
            @price = []
            @properties = []
            @category = []
            @status = nil
            @created_at = nil
            @updated_at = nil
            @some_msg = {}
            super(o)
        end

        def flavors
            self
        end

        def id(arg = nil)
            if arg != nil
                @id = arg
            else
                @id
            end
        end

        def org_id(arg = nil)
            if arg != nil
                @org_id = arg
            else
                @org_id
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
            if arg != nil
                @name = arg
            else
                @name
            end
        end


        def cpu(arg = nil)
            if arg != nil
                @cpu = arg
            else
                @cpu
            end
        end

        def ram(arg = nil)
            if arg != nil
                @ram = arg
            else
                @ram
            end
        end

        def disk(arg = nil)
            if arg != nil
                @disk = arg
            else
                @disk
            end
        end

        def regions(arg = [])
            if arg != []
                @regions = arg
            else
                @regions
            end
        end

        def price(arg = [])
            if arg != []
                @price = arg
            else
                @price
            end
        end

        def properties(arg = [])
            if arg != []
                @properties = arg
            else
                @properties
            end
        end

        def category(arg = [])
            if arg != []
                @category = arg
            else
                @category
            end
        end

        def status(arg=nil)
            if arg != nil
                @status = arg
            else
                @status
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
            crocked = true if some_msg.key?(:msg_type) && some_msg[:msg_type] == 'error'
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
            index_hash['json_claz'] = self.class.name
            index_hash['id'] = id
            index_hash['org_id'] = org_id
            index_hash["account_id"] = account_id
            index_hash['name'] = name
            index_hash['cpu'] = cpu
            index_hash['ram'] = ram
            index_hash['disk'] = disk
            index_hash['regions'] = regions
            index_hash['price'] = price
            index_hash['properties'] = properties
            index_hash['category'] = category
            index_hash['status'] = status
            index_hash['created_at'] = created_at
            index_hash['updated_at'] = updated_at
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
                'account_id' => account_id,
                'name' => name,
                'org_id' => org_id,
                'cpu' => cpu,
                'ram' => ram,
                'disk' => disk,
                'regions' => regions,
                'price' => price,
                'properties' => properties,
                'category' => category,
                'status' => status,
                'created_at' => created_at,
                'updated_at' => updated_at
            }

            result
        end

        def self.json_create(o)
            fav = new({})
            fav.id(o['id']) if o.key?('id')
            fav.org_id(o['org_id']) if o.key?('org_id')
            fav.account_id(o["account_id"]) if o.has_key?("account_id")
            fav.name(o['name']) if o.key?('name')
            fav.cpu(o['cpu']) if o.key?('cpu')
            fav.ram(o['ram']) if o.key?('ram')
            fav.disk(o['disk']) if o.key?('disk')
            fav.regions(o['regions']) if o.key?('regions')
            fav.price(o['price']) if o.key?('price')
            fav.properties(o['properties']) if o.key?('properties')
            fav.category(o['category']) if o.key?('category')
            fav.status(o['status']) if o.key?('status')
            fav.created_at(o['created_at']) if o.key?('created_at')
            fav.updated_at(o['updated_at']) if o.key?('updated_at')
            fav.some_msg[:code] = o["code"] if o.has_key?("code")
            fav.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            fav.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            fav.some_msg[:links] = o["links"] if o.has_key?("links")
            fav
        end

        def self.from_hash(o)
            sps = self.new(o)
            sps.from_hash(o)
            sps
        end

        def from_hash(o)
            @id       = o[:id] if o.has_key?(:id)
            @org_id        = o[:org_id] if o.has_key?(:org_id)
            @account_id       = o[:account_id] if o.has_key?(:account_id)
            @name            = o[:name] if o.has_key?(:name)
            @cpu            = o[:cpu] if o.has_key?(:cpu)
            @ram            = o[:ram] if o.has_key?(:ram)
            @disk            = o[:disk] if o.has_key?(:disk)
            @regions            = o[:regions] if o.has_key?(:regions)
            @price            = o[:price] if o.has_key?(:price)
            @properties            = o[:properties] if o.has_key?(:properties)
            @category            = o[:category] if o.has_key?(:category)
            @status            = o[:status] if o.has_key?(:status)
            @created_at            = o[:created_at] if o.has_key?(:created_at)
            @updated_at            = o[:updated_at] if o.has_key?(:updated_at)
            self
        end

        # Create the node via the REST API
        def self.create(params)
            fav = from_hash(params)
            fav.create
        end

        def create
            megam_rest.post_flavors(to_hash)
        end



        def self.list(params)
            fav = self.new(params)
            fav.megam_rest.get_flavors
        end

        def self.show(params)
            fav = self.new(params)
            fav.megam_rest.get_one_flavor(params[:id])
        end

        def self.update(params)
            fav = from_hash(params)
            fav.update
        end

        def update
         megam_rest.update_flavors(to_hash)
        end

        def self.remove(o)
            fav = from_hash(o)
            fav.remove
        end

        def remove
            megam_rest.delete_flavors(to_hash)
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
