module Megam
    class Account < Megam::RestAdapter

        attr_accessor :id
        attr_accessor :email
        attr_accessor :password
        attr_accessor :api_key
        attr_accessor :name
        attr_accessor :phone
        attr_accessor :states
        attr_accessor :approval
        attr_accessor :suspend
        attr_accessor :registration_ip_address
        attr_accessor :dates
        attr_accessor :json_claz, :code, :msg_type, :msg, :links, :more
        attr_accessor :some_msg


        def initialize(o={})
            @id = nil
            @email = nil
            @api_key = nil
            @name = {}
            @phone = {}
            @password = {}
            @states = {}
            @approval = {}
            @suspend = {}
            @dates = {}
            @some_msg = {}
            super({ email: o[:email], api_key: o[:api_key],
            host: o[:host], password: o[:password], org_id: o[:org_id] })
        end

        def account
            self
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

        def to_json(*a)
            for_json.to_json(*a)
        end

        def for_json
            result = {
                'id' => @id,
                'email' => @email,
                'api_key' => @api_key,
                'name' => @name,
                'phone' => @phone,
                'password' => @password,
                'states' => @states,
                'approval' => @approval,
                'suspend' => @suspend,
                'registration_ip_address' => @registration_ip_address,
                'dates' => @dates
            }
            result
        end

        def self.json_create(o)
            acct = new()
            o.symbolize_keys!
            o = o[:results] if o.has_key?(:results)

            o.each { |k, v| acct.send("#{k}=", v) }

            acct.some_msg[:code] = @code  if @code
            acct.some_msg[:msg_type] = @msg_type if @msg_type
            acct.some_msg[:msg] = @msg if @msg
            acct.some_msg[:more] = @more if @more
            acct.some_msg[:links] = @links if @links

            acct
        end


        #Can be used by the  calling classes to get the full hash
        # (eg: Nilavu: User model)
        def expanded
            h = Hash.new
            [:id, :email, :api_key, :name, :phone, :password,:states, :approval, :suspend,
            :registration_ip_address, :dates, :some_msg].each do |setting|
                if grouped = self.send("#{setting}").is_a?(Hash)
                    self.send("#{setting}").each {|k,v|   h[k.to_sym] = v}
                else
                    h[setting] = self.send("#{setting}")
                end
            end
            h
        end


        def self.from_hash(o)
            acct = new(email: o[:email], api_key: o[:api_key], host: o[:host], password: o[:password], org_id: o[:org_id])
            acct.from_hash(o)
            acct
        end

        def from_hash(o)
            @id         = o[:id] if o.key?(:id)
            @email      = o[:email] if o.key?(:email)
            @api_key    = o[:api_key] if o.key?(:api_key)

            @name[:first_name] = o[:first_name] if o.key?(:first_name)
            @name[:last_name] = o[:last_name] if o.key?(:last_name)

            @phone[:phone] = o[:phone] if o.key?(:phone)
            @phone[:phone_verified] = o[:phone_verified] if o.key?(:phone_verified)

            @password[:password_hash] = o[:password_hash] if o.key?(:password_hash)
            @password[:password_reset_key] = o[:password_reset_key] if o.key?(:password_reset_key)
            @password[:password_reset_sent_at] = o[:password_reset_sent_at] if o.key?(:password_reset_sent_at)

            @states[:authority] = o[:authority] if o.key?(:authority)
            @states[:active] = o[:active] if o.key?(:active)
            @states[:blocked] = o[:blocked] if o.key?(:blocked)
            @states[:staged] = o[:staged] if o.key?(:staged)

            @approval[:approved] = o[:approved] if o.key?(:approved)
            @approval[:approved_by_id] = o[:approved_by_id] if o.key?(:approved_by_id)
            @approval[:approved_at] = o[:approved_at] if o.key?(:approved_at)

            @suspend[:suspended] = o[:suspended] if o.key?(:suspended)
            @suspend[:suspended_at] = o[:suspend] if o.key?(:suspended_at)
            @suspend[:suspended_till] = o[:suspended_till] if o.key?(:suspended_till)
            @registration_ip_address = o[:registration_ip_address] if o.key?(:registration_ip_address)

            @dates[:last_posted_at] = o[:last_posted_at] if o.key?(:last_posted_at)
            @dates[:last_emailed_at] = o[:last_emailed_at] if o.key?(:last_emailed_at)
            @dates[:previous_visit_at] = o[:previous_visit_at] if o.key?(:previous_visit_at)
            @dates[:first_seen_at] = o[:first_seen_at] if o.key?(:first_seen_at)
            @dates[:created_at] = o[:created_at] if o.key?(:created_at)
            self
        end

        def self.create(o)
            acct = from_hash(o)
            acct.create
        end

        def create
            megam_rest.post_accounts(to_hash)
        end

        def self.show(o)
            acct = new(email: o[:email], api_key: o[:api_key], host: o[:host], password: o[:password], org_id: o[:org_id])
            acct.megam_rest.get_accounts(o[:email])
        end

        def self.update(o)
            acct = from_hash(o)
            acct.update
        end

        def self.forgot(o)
            acct = from_hash(o)
            acct.forgot
        end

        def self.password_token(o)
            acct = from_hash(o)
            acct.password_token
        end

        def update
            megam_rest.update_accounts(to_hash)
        end

        def forgot
            megam_rest.forgot(to_hash)
        end

        def password_token
            megam_rest.password_token(to_hash)
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

        private

        def to_hash
            h = Hash.new
            h['json_claz'] = self.class.name
            h['id'] = @id
            h['email'] = @email
            h['api_key'] = @api_key
            h['name'] = @name
            h['phone'] = @phone
            h['password'] = @password
            h['states'] = @states
            h['approval'] = @approval
            h['suspend'] = @suspend
            h['registration_ip_address'] = @registration_ip_address
            h['dates'] = @dates
            h['some_msg'] = some_msg
            h
        end
    end
end
