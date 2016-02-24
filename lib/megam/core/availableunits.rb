##
## Copyright [2013-2015] [Megam Systems]
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
module Megam
  class Availableunits < Megam::ServerAPI
    def initialize(email=nil, api_key=nil, host=nil)
      @id = nil
      @name = nil
      @duration = nil
      @charges_per_duration = nil     
      @created_at = nil
      @some_msg = {}
      super(email, api_key, host)
    end

    def availableunits
      self
    end

    
    def id(arg=nil)
      if arg != nil
        @id = arg
      else
      @id
      end
    end

    def name(arg=nil)
      if arg != nil
        @name = arg
      else
      @name
      end
    end

    def duration(arg=nil)
      if arg != nil
        @duration= arg
      else
      @duration
      end
    end

    def charges_per_duration(arg=nil)
      if arg != nil
        @charges_per_duration = arg
      else
      @charges_per_duration
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
      index_hash["name"] = name
      index_hash["duration"] = duration
      index_hash["charges_per_duration"] = charges_per_duration      
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
        "name" => name,
        "duration" => duration,
        "charges_per_duration" => charges_per_duration,       
        "created_at" => created_at
      }
      result
    end

    #
    def self.json_create(o)
      aunit = new
      aunit.id(o["id"]) if o.has_key?("id")
      aunit.name(o["name"]) if o.has_key?("name")     
      aunit.duration(o["duration"]) if o.has_key?("duration")
      aunit.charges_per_duration(o["charges_per_duration"]) if o.has_key?("charges_per_duration")
      aunit.created_at(o["created_at"]) if o.has_key?("created_at")
      #success or error
      aunit.some_msg[:code] = o["code"] if o.has_key?("code")
      aunit.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      aunit.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      aunit.some_msg[:links] = o["links"] if o.has_key?("links")
      aunit
    end

    def self.from_hash(o,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
      aunit = self.new(tmp_email, tmp_api_key, tmp_host)
      aunit.from_hash(o)
      aunit
    end

    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @name = o[:name] if o.has_key?(:name)
      @duration   = o[:duration] if o.has_key?(:duration)
      @charges_per_duration     = o[:charges_per_duration] if o.has_key?(:charges_per_duration)   
      @created_at   = o[:created_at] if o.has_key?(:created_at)
      self
    end

    def self.create(o,tmp_email=nil, tmp_api_key=nil, tmp_host)
      acct = from_hash(o,tmp_email, tmp_api_key, tmp_host)
      acct.create
    end

    # Create the predef via the REST API
    def create
      megam_rest.post_availableunits(to_hash)
    end

    # Load all available units -
    # returns a AvailableUnitsCollection
    # don't return self. check if the Megam::AvailableUnitsCollection is returned.
    def self.list(tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
    aunit = self.new(tmp_email,tmp_api_key,tmp_host)
      aunit.megam_rest.get_availableunits
    end

    # Show a particular available units by name,
    # Megam::Availables
    def self.show(p_name,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
    pre = self.new(tmp_email,tmp_api_key, tmp_host)
    pre.megam_rest.get_availableunit(p_name)
    end

    def self.delete(p_name,tmp_email=nil, tmp_api_key=nil, tmp_host=nil)
    pre = self.new(tmp_email,tmp_api_key,tmp_host)
    pre.megam_rest.delete_availableunit(p_name)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    #"---> Megam::Account:[error=#{error?}]\n"+
    end

  end
end

