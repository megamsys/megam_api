module Megam
    class Domains < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @org_id = nil
            @name = nil
            @created_at = nil
            super(o)
        end

        def domain
            self
        end

        def id(arg=nil)
            if arg != nil
                @id = arg
            else
                @id
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

        def to_hash
            index_hash = Hash.new
            index_hash["json_claz"] = self.class.name
            index_hash["id"] = id
            index_hash["org_id"] = org_id
            index_hash["name"] = name
            index_hash["created_at"] = created_at
            index_hash
        end

        def to_json(*a)
            for_json.to_json(*a)
        end

        def for_json
            result = {
                "id" => id,
                "org_id" => org_id,
                "name" => name,
                "created_at" => created_at
            }
            result
        end

        # Create a Megam::Domains from JSON (used by the backgroud job workers)
        def self.json_create(o)
            dmn = new({})
            dmn.id(o["id"]) if o.has_key?("id")
            dmn.org_id(o["org_id"]) if o.has_key?("org_id")
            dmn.name(o["name"]) if o.has_key?("name")
            dmn.created_at(o["created_at"]) if o.has_key?("created_at")
            dmn
        end

        def self.from_hash(o)
            org = self.new(o)
            org.from_hash(o)
            org
        end


        def from_hash(o)
            @id        = o[:id] if o.has_key?(:id)
            @org_id        = o[:org_id] if o.has_key?(:org_id)
            @name     = o[:name] if o.has_key?(:name)
            @created_at = o[:created_at] if o.has_key?(:created_at)
            self
        end

        def self.create(o)
            dom = from_hash(o)
            dom.create
        end

        def self.list(o)
            dom = from_hash(o)
            dom.megam_rest.get_domains
        end

        def create
            megam_rest.post_domains(to_hash)
        end

        def show
            megam_rest.get_domains(to_hash)
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end
    end
end
