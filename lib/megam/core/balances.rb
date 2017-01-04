module Megam
    class Balances < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @account_id = nil
            @credit = nil
            @created_at = nil
            @updated_at = nil
            @some_msg = {}
            super(o)
        end

        def balances
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

        def updated_at(arg=nil)
            if arg != nil
                @updated_at = arg
            else
                @updated_at
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
            index_hash["updated_at"] = updated_at
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
                "updated_at" => updated_at
            }
            result
        end

        def self.json_create(o)
            balances = new({})
            balances.id(o["id"]) if o.has_key?("id")
            balances.account_id(o["account_id"]) if o.has_key?("account_id")
            balances.credit(o["credit"]) if o.has_key?("credit")
            balances.created_at(o["created_at"]) if o.has_key?("created_at")
            balances.updated_at(o["updated_at"]) if o.has_key?("updated_at")
            #success or error
            balances.some_msg[:code] = o["code"] if o.has_key?("code")
            balances.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            balances.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            balances.some_msg[:links] = o["links"] if o.has_key?("links")
            balances
        end

        def self.from_hash(o)
            balances = self.new(o)
            balances.from_hash(o)
            balances
        end

        def from_hash(o)
            @id        = o[:id] if o.has_key?(:id)
            @account_id = o[:account_id] if o.has_key?(:account_id)
            @credit   = o[:credit] if o.has_key?(:credit)
            @created_at   = o[:created_at] if o.has_key?(:created_at)
            @updated_at   = o[:updated_at] if o.has_key?(:updated_at)
            self
        end

        def self.create(params)
            acct = from_hash(params,params["email"], params["api_key"], params["host"])
            acct.create
        end

        # Create the predef via the REST API
        def create
            megam_rest.post_balances(to_hash)
        end

        # Load all balances -
        # returns a BalanceCollection
        # don't return self. check if the Megam::BalanceCollection is returned.
        def self.list(params)
            balance = self.new(params)
            balance.megam_rest.get_balances
        end

        # Show a particular balance by name,
        # Megam::Balance
        def self.show(params)
            pre = self.new(params)
            pre.megam_rest.get_balance(params["email"])
        end

        def self.delete(p_name,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
            pre = self.new(tmp_email,tmp_api_key,tmp_host)
            pre.megam_rest.delete_balance(p_name)
        end

        def self.update(params)
            asm = from_hash(params)
            asm.update
        end

        # Create the node via the REST API
        def update
            megam_rest.update_balance(to_hash)
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
