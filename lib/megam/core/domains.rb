# Copyright:: Copyright (c) 2013-2016 Megam Systems, Inc.
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
  class Domains < Megam::ServerAPI
    def initialize(o)
      @id = nil
      @name = nil
      @created_at = nil
      super(o)
    end

    def domain
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

    def created_at(arg=nil)
      if arg != nil
        @created_at = arg
      else
        @created_at
      end
    end

    def to_hash
      index_hash = Hash.new
      index_hash["json_claz"] = self.class.name
      index_hash["id"] = id
      index_hash["name"] = name
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
        "created_at" => created_at
      }
      result
    end

    # Create a Megam::Domains from JSON (used by the backgroud job workers)
    def self.json_create(o)
      dmn = new
      dmn.id(o["id"]) if o.has_key?("id")
      dmn.name(o["name"]) if o.has_key?("name")
      dmn.created_at(o["created_at"]) if o.has_key?("created_at")
      dmn
    end

    def self.from_hash(o)
      org = self.new(o)
      org.from_hash(o)
      org
    end


    def from_hash(o)
      @id        = o[:id] if o.has_key?(:id)
      @name     = o[:name] if o.has_key?(:name)
      @created_at = o[:created_at] if o.has_key?(:created_at)
      self
    end

    def self.create(o)
      dom = from_hash(o)
      dom.create
    end

    def self.show(o)
      dom = from_hash(o)
      dom.show
    end

    def create
      megam_rest.post_domains(to_hash)
    end

    def show
      megam_rest.get_domains(to_hash)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end
  end
end
