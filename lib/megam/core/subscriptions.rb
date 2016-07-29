module Megam
    class Subscriptions < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @accounts_id = nil
            @model = nil
            @license = nil
            @trial_ends = nil
            @created_at = nil
            @some_msg = {}
            super(o)
        end

        def subscriptions
            self
        end

        def id(arg=nil)
            if arg != nil
                @id = arg
            else
                @id
            end
        end

        def accounts_id(arg=nil)
            if arg != nil
                @accounts_id= arg
            else
                @accounts_id
            end
        end

        def model(arg=nil)
            if arg != nil
                @model = arg
            else
                @model
            end
        end

        def license(arg=nil)
            if arg != nil
                @license= arg
            else
                @license
            end
        end

        def trial_ends(arg=nil)
            if arg != nil
                @trial_ends = arg
            else
                @trial_ends
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
            index_hash["accounts_id"] = accounts_id
            index_hash["model"] = model
            index_hash["license"] = license
            index_hash["trial_ends"] = trial_ends
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
                "accounts_id" => accounts_id,
                "model" => model,
                "license" => license,
                "trial_ends" => trial_ends,
                "created_at" => created_at
            }
            result
        end

        #
        def self.json_create(o)
            sbs = new({})
            sbs.id(o["id"]) if o.has_key?("id")
            sbs.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")
            sbs.model(o["model"]) if o.has_key?("model")
            sbs.license(o["license"]) if o.has_key?("license")
            sbs.trial_ends(o["trial_ends"]) if o.has_key?("trial_ends")
            sbs.created_at(o["created_at"]) if o.has_key?("created_at")
            #success or error
            sbs.some_msg[:code] = o["code"] if o.has_key?("code")
            sbs.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            sbs.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            sbs.some_msg[:links] = o["links"] if o.has_key?("links")
            sbs
        end

        def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
            sbs = self.new(tmp_email, tmp_api_key, tmp_host)
            sbs.from_hash(o)
            sbs
        end

        def from_hash(o)
            @id        = o[:id] if o.has_key?(:id)
            @accounts_id = o[:accounts_id] if o.has_key?(:accounts_id)
            @model     = o[:model] if o.has_key?(:model)
            @license   = o[:license] if o.has_key?(:license)
            @trial_ends   = o[:trial_ends] if o.has_key?(:trial_ends)
            @created_at   = o[:created_at] if o.has_key?(:created_at)
            self
        end

        def self.create(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
            acct = from_hash(o,tmp_email, tmp_api_key, tmp_host)
            acct.create
        end

        # Create the subscriptions via the REST API
        def create
            megam_rest.post_subscriptions(to_hash)
        end

        # Load all subscriptions -
        # returns a SubscriptionsCollection
        # don't return self. check if the Megam::SubscriptionsCollection is returned.

        def self.show(p_name,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
            pre = self.new(tmp_email,tmp_api_key, tmp_host)
            pre.megam_rest.get_subscription
        end


        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
