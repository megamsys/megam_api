# Copyright:: Copyright (c) 2012, 2014 Megam Systems
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
  class CSAR < Megam::ServerAPI
    def initialize(email=nil, api_key=nil, host=nil)
      @id = nil
      @desc = nil
      @link = {}
      @some_msg = {}
      @created_at = nil
      super(email, api_key, host)
    end

    def csar
      self
    end

    def id(arg=nil)
      if arg != nil
        @id = arg
      else
        @id
      end
    end

    def desc(arg=nil)
      if arg != nil
        @desc = arg
      else
      @desc
      end
    end

    def yamldata(arg=nil)
      if arg != nil
        @yamldata = arg
      else
      @yamldata
      end
    end

    def link(arg=nil)
      if arg != nil
        @link = arg
      else
      @link
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
      index_hash["desc"] = desc
      index_hash["link"] = link
      index_hash["some_msg"] = some_msg
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
        "desc" => desc,
        "link" => link,
        "created_at" => created_at
      }
      result
    end

    def self.json_create(o)
      csarjslf = new
      csarjslf.id(o["id"]) if o.has_key?("id")
      csarjslf.desc(o["desc"]) if o.has_key?("desc")
      csarjslf.link(o["link"]) if o.has_key?("link")
      csarjslf.created_at(o["created_at"]) if o.has_key?("created_at")

      #success or error
      csarjslf.some_msg[:code] = o["code"] if o.has_key?("code")
      csarjslf.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      csarjslf.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      csarjslf.some_msg[:links] = o["links"] if o.has_key?("links")

      csarjslf
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      csarhslf = self.new(tmp_email, tmp_api_key, tmp_host)
      csarhslf.from_hash(o)
      csarhslf
    end

    def from_hash(o)
      @id        = o["id"] if o.has_key?("id")
      @desc      = o["desc"] if o.has_key?("desc")
      @link      = o["link"] if o.has_key?("link")
      @yamldata  = o["yamldata"] if o.has_key?("yamldata")
      @created_at = o["created_at"] if o.has_key?("created_at")
      self
    end

    #This won't work, as the body just needs the yaml string.
    def self.create(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      csarslf = from_hash(o, tmp_email, tmp_api_key, tmp_host)
      csarslf.create
    end

    # Create the csar yaml
    #This won't work, as the body just needs the yaml string.
    def create
      megam_rest.post_csar(@yamldata)
    end

    # Load the yaml back from the link
    def self.show(tmp_email=nil, tmp_api_key=nil, tmp_host=nil, csarlink_name)
      csarslf = self.new(tmp_email, tmp_api_key, tmp_host)
      csarslf.megam_rest.get_csar(csarlink_name)
    end

    #list all csars (links)
    def self.list(tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      csarslf = self.new(tmp_email, tmp_api_key, tmp_host)
      csarslf.megam_rest.get_csars
    end

     #push csar (links)
    def self.push(tmp_email=nil, tmp_api_key=nil, tmp_host=nil, csar_id)
      csarslf = self.new(tmp_email, tmp_api_key, tmp_host)
      csarslf.megam_rest.push_csar(csar_id)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
