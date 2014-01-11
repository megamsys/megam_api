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
  class CloudTool < Megam::ServerAPI
    
    def initialize(email=nil, api_key=nil)
      @id = nil
      @name = nil
      @cli = nil
      @cloudtemplates = nil
      @some_msg = {}
      super(email, api_key)
    end

    def cloud_tool
      self
    end

    
    def id(arg=nil)
      if arg != nil
        @id = arg
      else
      @id
      end
    end

    def cli(arg=nil)
      if arg != nil
        @cli = arg
      else
      @cli
      end
    end

    def name(arg=nil)
      if arg != nil
        @name = arg
      else
      @name
      end
    end

    def cloudtemplates(arg=nil)
      if arg != nil
        @cloudtemplates = arg
      else
      @cloudtemplates
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
      index_hash["name"] = name
      index_hash["cli"] = cli
      index_hash["cloudtemplates"] = cloudtemplates
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
        "name" => name,
        "cli" => cli,
        "cloudtemplates" => cloudtemplates
      }
      result
    end

    #
    def self.json_create(o)
      cloudtool = new
      cloudtool.id(o["id"]) if o.has_key?("id")
      cloudtool.name(o["name"]) if o.has_key?("name")
      cloudtool.cli(o["cli"]) if o.has_key?("cli")
      cloudtool.cloudtemplates(o["cloudtemplates"]) if o.has_key?("cloudtemplates")
      
      #success or error
      cloudtool.some_msg[:code] = o["code"] if o.has_key?("code")
      cloudtool.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      cloudtool.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      cloudtool.some_msg[:links] = o["links"] if o.has_key?("links")
      cloudtool
    end

    def self.from_hash(o)
      cloudtool = self.new()
      cloudtool.from_hash(o)
      cloudtool
    end

    def from_hash(o)
      @provider   = o[:provider] if o.has_key?(:provider)
      self
    end

    # Load all cloudtools -
    # returns a CloudToolsCollection
    def self.list(tmp_email=nil, tmp_api_key=nil)
      ct = self.new(tmp_email, tmp_api_key)
      ct.megam_rest.get_cloudtools
    end

    # Show a particular cloudtool by name,
    # Megam::CloudTool
    def self.show(p_name,tmp_email=nil, tmp_api_key=nil)
      ct = self.new(tmp_email=nil, tmp_api_key=nil)
      ct.megam_rest.get_cloudtool(p_name)
      self
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
