# Copyright:: Copyright (c) 2012, 2013 Megam Systems
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
  class CloudToolSetting < Megam::ServerAPI
    
    def initialize(email=nil, api_key=nil)
      @id = nil
      @accounts_id = nil
      @cloud_type = nil
      @repo_name = nil
      @repo = nil
      @vault_location=nil
      @conf_location=nil
      @created_at = nil
      @some_msg = {}
      super(email, api_key)
    end

    def cloud_tool_setting
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

    def cloud_type(arg=nil)
      if arg != nil
        @cloud_type = arg
      else
      @cloud_type
      end
    end

    def repo_name(arg=nil)
      if arg != nil
        @repo_name = arg
      else
      @repo_name
      end
    end

    def repo(arg=nil)
      if arg != nil
        @repo = arg
      else
      @repo
      end
    end

    def vault_location(arg=nil)
      if arg != nil
        @vault_location= arg
      else
      @vault_location
      end
    end

    def conf_location(arg=nil)
      if arg != nil
        @conf_location= arg
      else
      @conf_location
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
      index_hash["cloud_type"] = cloud_type
      index_hash["repo_name"] = repo_name
      index_hash["repo"] = repo
      index_hash["vault_location"] = vault_location
      index_hash["conf_location"] = conf_location
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
        "accounts_id" => accounts_id,
        "cloud_type" => cloud_type,
        "repo" => repo,
        "repo_name" => repo_name,
        "vault_location" => vault_location,
        "conf_location" => conf_location,
        "created_at" => created_at
      }
      result
    end

    #
    def self.json_create(o)
      cts = new
      cts.id(o["id"]) if o.has_key?("id")
      cts.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")
      cts.cloud_type(o["cloud_type"]) if o.has_key?("cloud_type")
      cts.repo_name(o["repo_name"]) if o.has_key?("repo_name")
      cts.repo(o["repo"]) if o.has_key?("repo")
      cts.vault_location(o["vault_location"]) if o.has_key?("vault_location")
      cts.conf_location(o["conf_location"]) if o.has_key?("conf_location")

      cts.created_at(o["created_at"]) if o.has_key?("created_at")
      #success or error
      cts.some_msg[:code] = o["code"] if o.has_key?("code")
      cts.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      cts.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      cts.some_msg[:links] = o["links"] if o.has_key?("links")
      cts
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil)
      cts = self.new(tmp_email,tmp_api_key)
      cts.from_hash(o)
      cts
    end

    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @accounts_id = o[:accounts_id] if o.has_key?(:accounts_id)
      @cloud_type   = o[:cloud_type] if o.has_key?(:cloud_type)
      @repo_name     = o[:repo_name] if o.has_key?(:repo_name)
      @repo     = o[:repo] if o.has_key?(:repo)
      @vault_location   = o[:vault_location] if o.has_key?(:vault_location)
      @conf_location   = o[:conf_location] if o.has_key?(:conf_location)
      @created_at   = o[:created_at] if o.has_key?(:created_at)
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil)
      acct = from_hash(o,tmp_email, tmp_api_key)
      acct.create
    end

    # Create the cloudtoolsetting via the REST API
    def create
      megam_rest.post_cloudtoolsetting(to_hash)
    end

    # Load all cloudtoolsettings -
    # returns a cloudtoolsettingsCollection
    # don't return self. check if the Megam::cloudtoolsettingCollection is returned.
    def self.list(tmp_email=nil, tmp_api_key=nil)
      cts = self.new(tmp_email, tmp_api_key)
      cts.megam_rest.get_cloudtoolsettings
    end

    # Show a particular cloudtoolsetting by name,
    # Megam::cloudtoolsetting
    def self.show(p_name,tmp_email=nil, tmp_api_key=nil)
      pre = self.new(tmp_email, tmp_api_key)
      pre.megam_rest.get_cloudtoolsetting(p_name)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
