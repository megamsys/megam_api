module Megam
    class Credits < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @account_id = nil
            @credit = nil
            @created_at = nil
            @some_msg = {}
            super(o)
        end

        def credit
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
                @account_id= arg
            else
                @account_id
            end
        end


        def credit(arg=nil)
            if arg != nil
                @credit = arg
            else
                @credit
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
            index_hash["account_id"] = account_id
            index_hash["credit"] = credit
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
                "account_id" => account_id,
                "credit" => credit,
                "created_at" => created_at,
            }
            result
        end

        def self.json_create(o)
            cr = new({})
            cr.id(o["id"]) if o.has_key?("id")
            cr.account_id(o["account_id"]) if o.has_key?("account_id")
            cr.credit(o["credit"]) if o.has_key?("credit")
            cr.created_at(o["created_at"]) if o.has_key?("created_at")
            #success or error
            cr.some_msg[:code] = o["code"] if o.has_key?("code")
            cr.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            cr.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            cr.some_msg[:links] = o["links"] if o.has_key?("links")
            cr
        end

        def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
            cr = self.new(tmp_email, tmp_api_key, tmp_host)
            cr.from_hash(o)
            cr
        end

        def from_hash(o)
            @id        = o[:id] if o.has_key?(:id)
            @account_id = o[:account_id] if o.has_key?(:account_id)
            @credit   = o[:credit] if o.has_key?(:credit)
            @created_at   = o[:created_at] if o.has_key?(:created_at)
            self
        end

        def self.create(params)
            acct = from_hash(params,params["email"], params["api_key"], params["host"])
            acct.create
        end

        # Create the predef via the REST API
        def create
            megam_rest.post_credits(to_hash)
        end

        # Load all credit -
        # returns a creditCollection
        # don't return self. check if the Megam::CreditCollection is returned.
        def self.list(params)
            cr = self.new(params)
            cr.megam_rest.list_credits
        end

        # Show a particular balance by name,
        # Megam::Balance
        def self.show(params)
            pre = self.new(params)
            pre.megam_rest.get_credits(params["account_id"])
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
