# Copyright:: Copyright (c) 2012-2013 Megam Systems, Inc.
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
  class Organizations < Megam::ServerAPI
   def initialize(email=nil, api_key=nil)
     @id = nil
     @name = nil
     @accounts_id = nil
     @created_at = nil
     super(email, api_key)
   end


def organization
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
     @accounts_id = arg
  else
    @accounts_id
  end
end

def name(arg=nil)
  if arg != nil
     @name = arg
  else
    @name
  end
end



def created_at(arg=nil)
  if arg != nil
    @created_at = arg
  else
  @created_at
  end
end



    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["json_claz"] = self.class.name
      index_hash["id"] = id
      index_hash["name"] = name
      index_hash["accounts_id"] = accounts_id
      index_hash["created_at"] = created_at
      index_hash
    end

def to_json(*a)
  for_json.to_json(*a)
end

def for_json
  result = {
    "id" => id,
    "name" => name,
    "accounts_id" => accounts_id,
    "created_at" => created_at
  }
  result
end

# Create a Megam::Organization from JSON (used by the backgroud job workers)
def self.json_create(o)
  org = new
  org.id(o["id"]) if o.has_key?("id")
  org.name(o["name"]) if o.has_key?("name")
  org.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")
  org.created_at(o["created_at"]) if o.has_key?("created_at")
  org
end

def self.from_hash(o)
  org = self.new(o[:email], o[:api_key])
  org.from_hash(o)
  org
end

def from_hash(o)
  @id        = o[:id] if o.has_key?(:id)
  @name     = o[:name] if o.has_key?(:name)
  @accounts_id = o[:accounts_id] if o.has_key?(:accounts_id)
  @created_at = o[:created_at] if o.has_key?(:created_at)
  self
end

def self.create(o)
  org = from_hash(o)
  org.create
end

# Load a organization by email_p
def self.show(email,api_key=nil)
  org = self.new(email, api_key)
  org.megam_rest.get_organizations(email)
end


def create
      megam_rest.post_organizations(to_hash)
end

def to_s
      Megam::Stuff.styled_hash(to_hash)
    end


  end

end
