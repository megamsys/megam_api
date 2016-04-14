# Copyright:: 2013-2016 Megam Systems, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module Megam
  class Account < Megam::RestAdapter
    def initialize(o)
      @id = nil
      @email = nil
      @api_key = nil
      @first_name = nil
      @last_name = nil
      @phone = nil
      @password = nil
      @authority = nil
      @password_reset_key = nil
      @password_reset_sent_at = nil
      @created_at = nil
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

    def first_name(arg=nil)
      if arg != nil
        @first_name = arg
      else
      @first_name
      end
    end

    def last_name(arg=nil)
      if arg != nil
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

    def password(arg=nil)
      if arg != nil
        @password = arg
      else
      @password
      end
    end

    def authority(arg=nil)
      if arg != nil
        @authority = arg
      else
      @authority
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
      index_hash["first_name"] = first_name
      index_hash["last_name"] = last_name
      index_hash["phone"] = phone
      index_hash["password"] = password
      index_hash["password_reset_key"] = password_reset_key
      index_hash["password_reset_sent_at"] = password_reset_sent_at
      index_hash["authority"] = authority
      index_hash["created_at"] = created_at
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
        "first_name" => first_name,
        "last_name" => last_name,
        "phone" => phone,
        "password" => password,
        "password_reset_key" => password_reset_key,
        "password_reset_sent_at" => password_reset_sent_at,
        "authority" => authority,
        "created_at" => created_at
      }
      result
    end

    # Create a Megam::Account from JSON (used by the backgroud job workers)
    def self.json_create(o)
      acct = new({})
      acct.id(o["id"]) if o.has_key?("id")
      acct.email(o["email"]) if o.has_key?("email")
      acct.api_key(o["api_key"]) if o.has_key?("api_key")
      acct.authority(o["authority"]) if o.has_key?("authority")
      acct.first_name(o["first_name"]) if o.has_key?("first_name")
      acct.last_name(o["last_name"]) if o.has_key?("last_name")
      acct.phone(o["phone"]) if o.has_key?("phone")
      acct.password(o["password"]) if o.has_key?("password")
      acct.password_reset_key(o["password_reset_key"]) if o.has_key?("password_reset_key")
      acct.password_reset_key(o["password_reset_sent_at"]) if o.has_key?("password_reset_sent_at")
      acct.created_at(o["created_at"]) if o.has_key?("created_at")
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
      @authority  = o[:authority] if o.has_key?(:authority)
      @first_name = o[:first_name] if o.has_key?(:first_name)
      @last_name  = o[:last_name] if o.has_key?(:last_name)
      @phone      = o[:phone] if o.has_key?(:phone)
      @password   = o[:password] if o.has_key?(:password)
      @password_reset_key = o[:password_reset_key] if o.has_key?(:password_reset_key)
      @password_reset_sent_at = o[:password_reset_sent_at] if o.has_key?(:password_reset_sent_at)
      @created_at = o[:created_at] if o.has_key?(:created_at)
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
