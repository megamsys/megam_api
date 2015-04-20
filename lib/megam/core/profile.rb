# Copyright:: Copyright (c) 2012-2015 Megam Systems, Inc.
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
  class Profile < Megam::ServerAPI
    def initialize(email=nil, api_key=nil)
      @first_name = nil
      @last_name = nil
      #@admin = true
      @phone = nil
      #@onboarded_api = false
      @user_type = nil
      @email = nil
      @api_token = nil
      @password = nil
      @password_confirmation = nil
      #@verified_email = false
      @verification_hash = nil
      @app_attributes = nil
      @cloud_identity_attributes = nil
      @apps_item_attributes = nil
      @password_reset_token = nil
      @password_reset_sent_at = nil
      super(email, api_key)
    end

    #used by resque workers and any other background job
    def profile
      self
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

    def user_type(arg=nil)
      if arg != nil
        @user_type = arg
      else
        @user_type
      end
    end

      def email(arg=nil)
        if arg != nil
          @email = arg
        else
          @email
        end
      end

    def api_token(arg=nil)
      if arg != nil
        @api_key = arg
      else
      @api_key
      end
    end

    def password(arg=nil)
      if arg != nil
        @password = arg
      else
        @password
      end
    end

      def password_confirmation(arg=nil)
        if arg != nil
          @password_confirmation = arg
        else
          @password_confirmation
        end
      end

    def verification_hash(arg=nil)
      if arg != nil
        @verification_hash = arg
      else
          @verification_hash
      end
    end

    def app_attributes(arg=nil)
      if arg != nil
          @app_attributes = arg
      else
            @app_attributes
      end
    end

    def cloud_identity_attributes(arg=nil)
     if arg != nil
          @cloud_identity_attributes = arg
        else
          @cloud_identity_attributes
    end
  end

    def apps_item_attributes(arg=nil)
       if arg != nil
             @apps_item_attributes = arg
         else
           @apps_item_attributes
     end
   end

    def password_reset_token(arg=nil)
      if arg != nil
          @password_reset_token = arg
      else
          @password_reset_token
    end
  end

    def password_reset_sent_at(arg=nil)
        if arg != nil
            @password_reset_sent_at = arg
        else
              @password_reset_sent_at
        end
      end


    def error?
      crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["first_name"] = first_name
      index_hash["last _name"] = last_name
      index_hash["phone"] = phone
      index_hash["user_type"] = user_type
      index_hash["email"] = email
      index_hash["api_token"] = api_token
      index_hash["password"] = password
      index_hash["password_confirmation"] = password_confirmation
      index_hash["verification_hash"] = verification_hash
      index_hash["app_attributes"] = app_attributes
      index_hash["cloud_indentity_attributes"] = cloud_indentity_attributes
      index_hash["app_item_attributes"] = app_item_attributes
      index_hash["password_reset_token"] = password_reset_token
      index_hash["password_reset_sent_at"] = password_reset_sent_at
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

    def for_json
      result = {
        "first_name" => first_name,
        "last_name" => last_name,
        "phone" => phone,
        "user_type" => user_type,
        "email" => email,
        "api_token" => api_token,
        "password" => password,
        "password_confirmation" => password_confirmation,
        "verification_hash" => verification_hash,
        "app_attributes" => app_attributes,
        "cloud_indentity_attributes" => cloud_indentity_attributes,
        "app_item_attributes" => app_item_attributes,
        "password_reset_token" => password_reset_token,
        "password_reset_sent_at" => password_reset_sent_at
      }
      result
    end

    # Create a Megam::Profile from JSON (used by the backgroud job workers)
    def self.json_create(o)
      profile = new
      profile.first_name(o["first_name"]) if o.has_key?("first_name")
      profile.last_name(o["last_name"]) if o.has_key?("last_name")
      profile.phone(o["phone"]) if o.has_key?("phone")
      profile.user_type(o["user_type"]) if o.has_key?("user_type")
      profile.email(o["email"]) if o.has_key?("email")
      profile.api_token(o["api_token"]) if o.has_key?("api_token")
      profile.password(o["password"]) if o.has_key?("password")
      profile.password_confirmation(o["password_confirmation"]) if o.has_key?("password_confirmation")
      profile.verification_hash(o["verification_hash"]) if o.has_key?("verification_hash")
      profile.app_attributes(o["app_attributes"]) if o.has_key?("app_attributes")
      profile.cloud_indentity_attributes(o["cloud_indentity_attributes"]) if o.has_key?("cloud_indentity_attributes")
      profile.app_item_attributes(o["app_item_attributes"]) if o.has_key?("app_item_attributes")
      profile.password_reset_token(o["password_reset_token"]) if o.has_key?("password_reset_token")
      profile.password_reset_sent_at(o["password_reset_sent_at"]) if o.has_key?("password_reset_sent_at")
      profile
    end

    def self.from_hash(o)
      profile = self.new(o[:email], o[:api_token])
      profile.from_hash(o)
      profile
    end

    def from_hash(o)
      @first_name=o[:first_name] if o.has_key?(:first_name)
      @last_name=o[:last_name] if o.has_key?(:last_name)
      @phone=o[:phone] if o.has_key?(:phone)
      @user_type=o[:user_type] if o.has_key?(:user_type)
      @email=o[:email] if o.has_key?(:email)
      @api_token=o[:api_token] if o.has_key?(:api_token)
      @password=o[:password] if o.has_key?(:password)
      @password_confirmation=o[:password_confirmation] if o.has_key?(:password_confirmation)
      @verification_hash=o[:verification_hash] if o.has_key?(:verification_hash)
      @app_attributes=o[:app_attributes] if o.has_key?(:app_attributes)
      @cloud_indentity_attributes=o[:cloud_indentity_attributes] if o.has_key?(:cloud_indentity_attributes)
      @app_item_attributes=o[:app_item_attributes] if o.has_key?(:app_item_attributes)
      @password_reset_token=o[:password_reset_token] if o.has_key?(:password_reset_token)
      @password_reset_sent_at=o[:password_reset_sent_at] if o.has_key?(:password_reset_sent_at)
      self
    end

    def self.create(o)
      profile = from_hash(o)
      profile.create
    end

    # Load a profile by email_p
    def self.show(email,api_token=nil)
      profile = self.new(email, api_token)
      profile.megam_rest.get_profile(email)
    end

    # Create the node via the REST API
    def create
      megam_rest.post_profile(to_hash)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end
  end
end
