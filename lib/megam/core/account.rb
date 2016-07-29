module Megam
  class Account < Megam::RestAdapter
    def initialize(o)
      @id = nil
      @email = nil
      @api_key = nil
      @first_name = nil
      @last_name = nil
      @phone = nil
      @phone_verified = nil
      @password = nil
      @password_reset_key = nil
      @password_reset_sent_at = nil
      @authority = nil
      @active = nil
      @blocked = nil
      @staged = nil
      @approved = nil
      @approved_by_id = nil
      @approved_at = nil
      @suspended = nil
      @suspended_at = nil
      @suspended_till = nil
      @registration_ip_address = nil
      @last_posted_at = nil
      @last_emailed_at = nil
      @previous_visit_at = nil
      @first_seen_at = nil
      @created_at = nil
      @some_msg = {}
      super({ email: o[:email], api_key: o[:api_key], host: o[:host], password: o[:password], org_id: o[:org_id] })
    end

    # used by resque workers and any other background job
    def account
      self
    end

    def id(arg = nil)
      if !arg.nil?
        @id = arg
      else
        @id
      end
    end

    def email(arg = nil)
      if !arg.nil?
        @email = arg
      else
        @email
      end
    end

    def api_key(arg = nil)
      if !arg.nil?
        @api_key = arg
      else
        @api_key
      end
    end

    def name(arg = nil)
      if !arg.nil?
        @name = arg
      else
        @name
      end
    end

    def first_name(arg = nil)
      if !arg.nil?
        @first_name = arg
      else
        @first_name
      end
    end

    def last_name(arg = nil)
      if !arg.nil?
        @last_name = arg
      else
        @last_name
      end
    end

    def phone(arg = nil)
      if !arg.nil?
        @phone = arg
      else
        @phone
      end
    end

    def phone_verified(arg = nil)
      if !arg.nil?
        @phone_verified = arg
      else
        @phone_verified
      end
    end

    def phone(arg = nil)
      if !arg.nil?
        @phone = arg
      else
        @phone
      end
    end

    def password(arg = nil)
      if !arg.nil?
        @password = arg
      else
        @password
      end
    end

    def password(arg = nil)
      if !arg.nil?
        @password = arg
      else
        @password
      end
    end

    def password_reset_key(arg = nil)
      if !arg.nil?
        @password_reset_key = arg
      else
        @password_reset_key
      end
    end

    def password_reset_sent_at(arg = nil)
      if !arg.nil?
        @password_reset_sent_at = arg
      else
        @password_reset_sent_at
      end
      end

    def states(arg = nil)
      if !arg.nil?
        @states = arg
      else
        @states
      end
    end

    def authority(arg = nil)
      if !arg.nil?
        @authority = arg
      else
        @authority
      end
    end

    def active(arg = nil)
      if !arg.nil?
        @active = arg
      else
        @active
      end
    end

    def blocked(arg = nil)
      if !arg.nil?
        @blocked = arg
      else
        @blocked
      end
    end

    def staged(arg = nil)
      if !arg.nil?
        @staged = arg
      else
        @staged
      end
    end

    def approval(arg = nil)
      if !arg.nil?
        @approval = arg
      else
        @approval
      end
    end

    def approved(arg = nil)
      if !arg.nil?
        @approved = arg
      else
        @approved
      end
    end

    def approved_by_id(arg = nil)
      if !arg.nil?
        @approved_by_id = arg
      else
        @approved_by_id
      end
    end

    def approved_at(arg = nil)
      if !arg.nil?
        @approved_at = arg
      else
        @approved_at
      end
    end

    def suspend(arg = nil)
      if !arg.nil?
        @suspend = arg
      else
        @suspend
      end
    end

    def suspended(arg = nil)
      if !arg.nil?
        @suspended = arg
      else
        @suspended
      end
    end

    def suspended_at(arg = nil)
      if !arg.nil?
        @suspended_at = arg
      else
        @suspended_at
      end
    end

    def suspended_till(arg = nil)
      if !arg.nil?
        @suspended_till = arg
      else
        @suspended_till
      end
    end

    def registration_ip_address(arg = nil)
      if !arg.nil?
        @registration_ip_address = arg
      else
        @registration_ip_address
      end
    end

    def dates(arg = nil)
      if !arg.nil?
        @dates = arg
      else
        @dates
      end
    end

    def last_posted_at(arg = nil)
      if !arg.nil?
        @last_posted_at = arg
      else
        @last_posted_at
      end
    end

    def last_emailed_at(arg = nil)
      if !arg.nil?
        @last_emailed_at = arg
      else
        @last_emailed_at
      end
    end

    def previous_visit_at(arg = nil)
      if !arg.nil?
        @previous_visit_at = arg
      else
        @previous_visit_at
      end
    end

    def first_seen_at(arg = nil)
      if !arg.nil?
        @first_seen_at = arg
      else
        @first_seen_at
      end
    end

    def created_at(arg = nil)
      if !arg.nil?
        @created_at = arg
      else
        @created_at
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
      index_hash = Hash.new
      index_hash['json_claz'] = self.class.name
      index_hash['id'] = id
      index_hash['email'] = email
      index_hash['api_key'] = api_key
      index_hash['name'] = Hash.new
      index_hash['name']['first_name'] = first_name
      index_hash['name']['last_name'] = last_name
      index_hash['phone'] = Hash.new
      index_hash['phone']['phone'] = phone
      index_hash['phone']['phone_verified'] = phone_verified
      index_hash['password'] = Hash.new
      index_hash['password']['password'] = password
      index_hash['password']['password_reset_key'] = password_reset_key
      index_hash['password']['password_reset_sent_at'] = password_reset_sent_at
      index_hash['states'] = Hash.new
      index_hash['states']['authority'] = authority
      index_hash['states']['active'] = active
      index_hash['states']['blocked'] = blocked
      index_hash['states']['staged'] = staged
      index_hash['approval'] = Hash.new
      index_hash['approval']['approved'] = approved
      index_hash['approval']['approved_by_id'] = approved_by_id
      index_hash['approval']['approved_at'] = approved_at
      index_hash['suspend'] = Hash.new
      index_hash['suspend']['suspended'] = suspended
      index_hash['suspend']['suspended_at'] = suspended_at
      index_hash['suspend']['suspended_till'] = suspended_till
      index_hash['registration_ip_address'] = registration_ip_address
      index_hash['dates'] = Hash.new
      index_hash['dates']['last_posted_at'] = last_posted_at
      index_hash['dates']['last_emailed_at'] = last_emailed_at
      index_hash['dates']['previous_visit_at'] = previous_visit_at
      index_hash['dates']['first_seen_at'] = first_seen_at
      index_hash['dates']['created_at'] = created_at
      index_hash['some_msg'] = some_msg
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
        'email' => email,
        'api_key' => api_key,
        'name' => name,
        'phone' => phone,
        'password' => password,
        'states' => states,
        'approval' => approval,
        'suspend' => suspend,
        'registration_ip_address' => registration_ip_address,
        'dates' => dates
      }
      result
    end

    # Create a Megam::Account from JSON (used by the backgroud job workers)
    def self.json_create(o)
      acct = new({})
      acct.id(o['id']) if o.key?('id')
      acct.email(o['email']) if o.key?('email')
      acct.api_key(o['api_key']) if o.key?('api_key')
      acct.name.first_name(o['first_name']) if o.key?('first_name')
      acct.name.last_name(o['last_name']) if o.key?('last_name')
      acct.phone.phone(o['phone']) if o.key?('phone')
      acct.phone.phone_verified(o['phone_verified']) if o.key?('phone_verified')
      acct.password.password(o['password']) if o.key?('password')
      acct.password.password_reset_key(o['password_reset_key']) if o.key?('password_reset_key')
      acct.password.password_reset_sent_at(o['password_reset_sent_at']) if o.key?('password_reset_sent_at')
      acct.states.authority(o['authority']) if o.key?('authority')
      acct.states.active(o['active']) if o.key?('active')
      acct.states.blocked(o['blocked']) if o.key?('blocked')
      acct.states.staged(o['staged']) if o.key?('staged')
      acct.approval.approved(o['approved']) if o.key?('approved')
      acct.approval.approved_by_id(o['approved_by_id']) if o.key?('approved_by_id')
      acct.approval.approved_at(o['approved_at']) if o.key?('approved_at')
      acct.suspend.suspended(o['suspended']) if o.key?('suspended')
      acct.suspend.suspended_at(o['suspended_at']) if o.key?('suspended_at')
      acct.suspend.suspended_till(o['suspended_till']) if o.key?('suspended_till')
      acct.registration_ip_address(o['registration_ip_address']) if o.key?('registration_ip_address')
      acct.dates.last_posted_at(o['last_posted_at']) if o.key?('last_posted_at')
      acct.dates.last_emailed_at(o['last_emailed_at']) if o.key?('last_emailed_at')
      acct.dates.previous_visit_at(o['previous_visit_at']) if o.key?('previous_visit_at')
      acct.dates.first_seen_at(o['first_seen_at']) if o.key?('first_seen_at')
      acct.dates.created_at(o['created_at']) if o.key?('created_at')
      acct.some_msg[:code] = o['code'] if o.key?('code')
      acct.some_msg[:msg_type] = o['msg_type'] if o.key?('msg_type')
      acct.some_msg[:msg] = o['msg'] if o.key?('msg')
      acct.some_msg[:links] = o['links'] if o.key?('links')
      acct
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
      @name       = o[:name]
      o[:name][:first_name] = o[:first_name] if o.key?(:first_name)
      o[:name][:last_name] = o[:last_name] if o.key?(:last_name)
      @phone = o[:phone]
      o[:phone][:phone] = o[:phone] if o.key?(:phone)
      o[:phone][:phone_verified] = o[:phone_verified] if o.key?(:phone_verified)
      @password = o[:password]
      o[:password][:password] = o[:password] if o.key?(:password)
      o[:password][:password_reset_key] = o[:password_reset_key] if o.key?(:password_reset_key)
      o[:password][:password_reset_sent_at] = o[:password_reset_sent_at] if o.key?(:password_reset_sent_at)
      @states = o[:states]
      o[:states][:authority] = o[:authority] if o.key?(:authority)
      o[:states][:active] = o[:active] if o.key?(:active)
      o[:states][:blocked] = o[:blocked] if o.key?(:blocked)
      o[:name][:staged] = o[:staged] if o.key?(:staged)
      @approval = o[:approval]
      o[:approval][:approved] = o[:approved] if o.key?(:approved)
      o[:approval][:approved_by_id] = o[:approved_by_id] if o.key?(:approved_by_id)
      o[:approval][:approved_at] = o[:approved_at] if o.key?(:approved_at)
      @suspend = o[:suspend]
      o[:suspend][:suspended] = o[:suspended] if o.key?(:suspended)
      o[:suspend][:suspended_at] = o[:suspend] if o.key?(:suspended_at)
      o[:suspend][:suspended_till] = o[:suspended_till] if o.key?(:suspended_till)
      @registration_ip_address = o[:registration_ip_address] if o.key?(:registration_ip_address)
      @dates = o[:dates]
      o[:dates][:last_posted_at] = o[:last_posted_at] if o.key?(:last_posted_at)
      o[:dates][:last_emailed_at] = o[:last_emailed_at] if o.key?(:last_emailed_at)
      o[:dates][:previous_visit_at] = o[:previous_visit_at] if o.key?(:previous_visit_at)
      o[:dates][:first_seen_at] = o[:first_seen_at] if o.key?(:first_seen_at)
      o[:dates][:created_at] = o[:created_at] if o.key?(:created_at)
      self
    end

    def self.create(o)
      acct = from_hash(o)
      acct.create
    end

    # Create the node via the REST API
    def create
      megam_rest.post_accounts(to_hash)
    end

    # Load a account by email_p
    def self.show(o)
      acct = new(email: o[:email], api_key: o[:api_key], host: o[:host], password: o[:password], org_id: o[:org_id])
      acct.megam_rest.get_accounts(o[:email])
    end

    def self.update(o)
      acct = from_hash(o)
      acct.update
   end

    def self.reset(o)
      acct = from_hash(o)
      acct.reset
    end

    def self.repassword(o)
      acct = from_hash(o)
      acct.repassword
    end

    # Create the node via the REST API
    def update
      megam_rest.update_accounts(to_hash)
    end

    def reset
      megam_rest.reset_accounts(to_hash)
   end

    def repassword
      megam_rest.repassword_accounts(to_hash)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end
  end
end
