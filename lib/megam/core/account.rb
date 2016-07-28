module Megam
  class Account < Megam::RestAdapter
    def initialize(o)
      @id = nil
      @email = nil
      @api_key = nil
      @name = nil
      @phone = nil
      @password = nil
      @states = nil
      @approval = nil
      @suspend = nil
      @registration_ip_address = nil
      @dates = nil
      @some_msg = {}
      super({:email => o[:email], :api_key => o[:api_key], :host => o[:host], :password => o[:password], :org_id => o[:org_id]})
    end

    #used by resque workers and any other background job
    def account
      self
    end

    def id(arg=nil)
      if arg != nil
        @id = arg
      else
      @id
      end
    end

    def email(arg=nil)
      if arg != nil
        @email = arg
      else
      @email
      end
    end

    def api_key(arg=nil)
      if arg != nil
        @api_key = arg
      else
      @api_key
      end
    end

    def name(arg=nil)
      if arg != nil
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

    def phone(arg=nil)
      if arg != nil
        @phone = arg
      else
      @phone
      end
    end

    def phone_verified(arg=nil)
      if arg != nil
        @phone_verified = arg
      else
      @phone_verified
      end
    end

    def phone(arg=nil)
      if arg != nil
        @phone = arg
      else
      @phone
      end
    end

    def password(arg=nil)
      if arg != nil
        @password = arg
      else
      @password
      end
    end


    def password(arg=nil)
      if arg != nil
        @password = arg
      else
      @password
      end
    end

    def password_reset_key(arg=nil)
      if arg != nil
        @password_reset_key = arg
      else
        @password_reset_key
      end
    end

  def password_reset_sent_at(arg=nil)
      if arg != nil
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

    def authority(arg=nil)
      if arg != nil
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
      index_hash["email"] = email
      index_hash["api_key"] = api_key
      index_hash["name"] = name
      index_hash["phone"] = phone
      index_hash["password"] = password
      index_hash["states"] = states
      index_hash["approval"] = approval
      index_hash["suspend"] = suspend
      index_hash["registration_ip_address"] = registration_ip_address
      index_hash["dates"] = dates
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
        "id" => id,
        "email" => email,
        "api_key" => api_key,
        "name" => name,
        "phone" => phone,
        "password" => password,
        "states" => states,
        "approval" => approval,
        "registration_ip_address" => registration_ip_address,
        "dates" => dates
      }
      result
    end

    # Create a Megam::Account from JSON (used by the backgroud job workers)
    def self.json_create(o)
      acct = new({})
      acct.id(o["id"]) if o.has_key?("id")
      acct.email(o["email"]) if o.has_key?("email")
      acct.api_key(o["api_key"]) if o.has_key?("api_key")
      na = o['name']
      acct.name[:first_name] = na['first_name'] if na && na.key?('first_name')
      acct.name[:last_name] = na['last_name'] if na && na.key?('last_name')
      ph = o['phone']
      acct.phone[:phone] = ph['phone'] if ph && ph.key?('phone')
      acct.phone[:phone_verified] = ph['phone_verified'] if ph && ph.key?('phone_verified')
      pwd = o['password']
      acct.password[:password] = pwd['password'] if pwd && pwd.key?('password')
      acct.password[:password_reset_key] = pwd['password_reset_key'] if pwd && pwd.key?('password_reset_key')
      acct.password[:password_reset_sent_at] = pwd['password_reset_sent_at'] if pwd && pwd.key?('password_reset_sent_at')
      st = o['states']
      acct.states[:authority] = st['authority'] if st && st.key?('authority')
      acct.states[:active] = st['active'] if st && st.key?('active')
      acct.states[:blocked] = st['blocked'] if st && st.key?('blocked')
      acct.states[:staged] = st['staged'] if st && st.key?('staged')
      al = o['approval']
      acct.approval[:approved] = al['approved'] if al && al.key?('approved')
      acct.approval[:approved_by_id] = al['approved_by_id'] if al && al.key?('approved_by_id')
      acct.approval[:approved_at] = al['approved_at'] if al && al.key?('approved_at')
      sp = o['suspend']
      acct.suspend[:suspended] = sp['suspended'] if sp && sp.key?('suspended')
      acct.suspend[:suspended_at] = sp['suspended_at'] if sp && sp.key?('suspended_at')
      acct.suspend[:suspended_till] = sp['suspended_till'] if sp && sp.key?('suspended_till')
      acct.registration_ip_address(o["registration_ip_address"]) if o.has_key?("registration_ip_address")
      dt = o['dates']
      acct.dates[:last_posted_at] = dt['last_posted_at'] if dt && dt.key?('last_posted_at')
      acct.dates[:last_emailed_at] = dt['last_emailed_at'] if dt && dt.key?('last_emailed_at')
      acct.dates[:previous_visit_at] = dt['previous_visit_at'] if dt && dt.key?('previous_visit_at')
      acct.dates[:first_seen_at] = dt['first_seen_at'] if dt && dt.key?('first_seen_at')
      acct.dates[:created_at] = dt['created_at'] if dt && dt.key?('created_at')
      acct.some_msg[:code] = o["code"] if o.has_key?("code")
      acct.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      acct.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      acct.some_msg[:links] = o["links"] if o.has_key?("links")
      acct
    end

    def self.from_hash(o)
      acct = self.new({:email => o[:email], :api_key => o[:api_key], :host => o[:host], :password => o[:password], :org_id => o[:org_id]})
      acct.from_hash(o)
      acct
    end

    def from_hash(o)
      @id         = o[:id] if o.has_key?(:id)
      @email      = o[:email] if o.has_key?(:email)
      @api_key    = o[:api_key] if o.has_key?(:api_key)
      @name       = o[:name] if o.has_key?(:name)
      @phone      = o[:phone] if o.has_key?(:phone)
      @password   = o[:password] if o.has_key?(:password)
      @states     = o[:states] if o.has_key?(:states)
      @approval   = o[:approval] if o.has_key?(:approval)
      @suspend    = o[:suspend] if o.has_key?(:suspend)
      @registration_ip_address = o[:registration_ip_address] if o.has_key?(:registration_ip_address)
      @dates     = o[:dates] if o.has_key?(:dates)
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
      acct = self.new({:email => o[:email], :api_key => o[:api_key], :host => o[:host], :password => o[:password], :org_id => o[:org_id]})
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
