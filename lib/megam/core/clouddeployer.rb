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
  class CloudDeployer
    # Each notify entry is a resource/action pair, modeled as an
    # Struct with a #resource and #action member
    def initialize
      @provider = {}
      @some_msg = {}
    end

    def cloud_deployer
      self
    end

    def megam_rest
      Megam::API.new(Megam::Config[:email], Megam::Config[:api_key])
    end

    def provider(arg=nil)
      if arg != nil
        @provider = arg
      else
      @provider
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
      index_hash["provider"] = provider
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

    def for_json
      result = {
        "provider" => provider 
      }
      result
    end

    #
    def self.json_create(o)
      clouddep = new
      #requests
      oq = o["provider"]
      clouddep.provider[:name] = oq["name"] if oq && oq.has_key?("name")
      
      #success or error
      clouddep.some_msg[:code] = o["code"] if o.has_key?("code")
      clouddep.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      clouddep.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      clouddep.some_msg[:links] = o["links"] if o.has_key?("links")
      clouddep
    end

    def self.from_hash(o)
      clouddep = self.new()
      clouddep.from_hash(o)
      clouddep
    end

    def from_hash(o)
      @provider   = o[:provider] if o.has_key?(:provider)
      self
    end

    def self.create
      clouddep = build
      clouddep.create
    end

    #
    #build the node as per the need
    def self.build
      payload = {:id => self.id, :name => self.name, :provider => self.provider,
        :provider_role => self.provider_role, :build_monkey => self.build_monkey}
      from_hash(payload)
    end

    # Create the clouddeployer via the REST API
    def create(clouddep_input)
      megam_rest.post_clouddep(clouddep_input)
      self
    end

    # Load all clouddeps -
    # returns a PredefsCollection
    # don't return self. check if the Megam::PredefCollection is returned.
    def self.list
      megam_rest.get_clouddeps
    end

    # Show a particular clouddep by name,
    # Megam::Predef
    def self.show(p_name)
      megam_rest.get_clouddeps(p_name)
      self
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end