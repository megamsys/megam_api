module Megam
    class Addons < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @provider_id = nil
            @account_id = nil
            @provider_name = nil
            @options = []
            @created_at = nil
            @some_msg = {}
            super(o)
        end

        def addons
            self
        end

        def id(arg=nil)
            if arg != nil
                @id = arg
            else
                @id
            end
        end

        def provider_id(arg=nil)
            if arg != nil
                @provider_id= arg
            else
                @provider_id
            end
        end

        def account_id(arg=nil)
            if arg != nil
                @account_id= arg
            else
                @account_id
            end
        end

        def provider_name(arg=nil)
            if arg != nil
                @provider_name = arg
            else
                @provider_name
            end
        end

        def options(arg=[])
            if arg != []
                @options = arg
            else
                @options
            end
        end

        def created_at(arg=nil)
            if arg != nil
                @created_at = arg
            else
                @created_at
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
            index_hash["id"] = id
            index_hash["provider_id"] = provider_id
            index_hash["account_id"] = account_id
            index_hash["provider_name"] = provider_name
            index_hash["options"] = options
            index_hash["created_at"] = created_at
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
                "provider_id" => provider_id,
                "account_id" => account_id,
                "provider_name" => provider_name ,
                "options" => options,
                "created_at" => created_at
            }
            result
        end

        #
        def self.json_create(o)
            adn = new({})
            adn.id(o["id"]) if o.has_key?("id")
            adn.provider_id(o["provider_id"]) if o.has_key?("provider_id")
            adn.account_id(o["account_id"]) if o.has_key?("account_id")
            adn.provider_name(o["provider_name"]) if o.has_key?("provider_name")
            adn.options(o["options"]) if o.has_key?("options")
            adn.created_at(o["created_at"]) if o.has_key?("created_at")
            #success or error
            adn.some_msg[:code] = o["code"] if o.has_key?("code")
            adn.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            adn.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            adn.some_msg[:links] = o["links"] if o.has_key?("links")
            adn
        end

        def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
            adn = self.new(tmp_email, tmp_api_key, tmp_host)
            adn.from_hash(o)
            adn
        end

        def from_hash(o)
            @id        = o[:id] if o.has_key?(:id)
            @provider_id = o[:provider_id] if o.has_key?(:provider_id)
            @account_id = o[:account_id] if o.has_key?(:account_id)
            @provider_name   = o[:provider_name] if o.has_key?(:provider_name)
            @options     = o[:options] if o.has_key?(:options)
            @created_at   = o[:created_at] if o.has_key?(:created_at)
            self
        end

        def self.create(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
            acct = from_hash(o,tmp_email, tmp_api_key, tmp_host)
            acct.create
        end

        # Create the addons via the REST API
        def create
            megam_rest.post_addons(to_hash)
        end

        # Load all addons -
        # returns a AddonsCollection
        # don't return self. check if the Megam::AddonsCollection is returned.

        # Show a particular addon by  provider_name,
        # Megam::Addon
        def self.show(p_name,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
            pre = self.new(tmp_email,tmp_api_key, tmp_host)
            pre.megam_rest.get_addon(p_name)
        end


        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
