# Copyright:: Copyright (c) 2013-2016 Megam Systems
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
require 'hashie'

module Megam
  class MarketPlace < Megam::ServerAPI
    def initialize(o)
      @id = nil
      @settings_name = nil
      @cattype = nil
      @flavor = nil
      @image = nil
      @catorder = nil
      @url = nil
      @envs = []
      @plans = nil
      @created_at = nil
      super(o)
    end

    def market_place
      self
    end

    def settings_name(arg = nil)
      if !arg.nil?
        @settings_name = arg
      else
        @settings_name
      end
    end

    def id(arg = nil)
      if !arg.nil?
        @id = arg
      else
        @id
      end
    end

    def plans(arg = nil)
      if !arg.nil?
        @plans = arg
      else
        @plans
      end
    end

    def cattype(arg = nil)
      if !arg.nil?
        @cattype = arg
      else
        @cattype
      end
    end

    def flavor(arg = nil)
      if !arg.nil?
        @flavor = arg
      else
        @flavor
      end
    end
    
    def catorder(arg = nil)
      if !arg.nil?
        @catorder = arg
      else
        @catorder
      end
    end

    def image(arg = nil)
      if !arg.nil?
        @image = arg
      else
        @image
      end
    end

    def url(arg = nil)
      if !arg.nil?
        @url = arg
      else
        @url
      end
    end

    def envs(arg = [])
      if arg != []
        @envs = arg
      else
        @envs
      end
    end


    def created_at(arg = nil)
      if !arg.nil?
        @created_at = arg
      else
        @created_at
      end
    end

    def some_msg(arg = nil)
      if !arg.nil?
        @some_msg = arg
      else
        @some_msg
      end
    end

    def error?
      crocked = true if some_msg.key?(:msg_type) && some_msg[:msg_type] == 'error'
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = {}
      index_hash['json_claz'] = self.class.name
      index_hash['id'] = id
      index_hash['settings_name'] = settings_name
      index_hash['cattype'] = cattype
      index_hash['flavor'] = flavor
      index_hash['image'] = image
      index_hash['catorder'] = catorder
      index_hash['url'] = url
      index_hash['envs'] = envs
      index_hash['plans'] = plans
      index_hash['created_at'] = created_at
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

    def for_json
      result = {
        'id' => id,
        'settings_name' => settings_name,
        'cattype' => cattype,
        'flavor' => flavor,
        'image' => image,
        'catorder' => catorder,
        'url' => url,
        'envs' => envs,
        'plans' => plans,
        'created_at' => created_at
      }
      result
    end

    def self.json_create(o)
      app = new({})
      app.id(o['id']) if o.key?('id')
      app.settings_name(o['settings_name']) if o.key?('settings_name')
      app.cattype(o['cattype']) if o.key?('cattype')
      app.flavor(o['flavor']) if o.key?('flavor')
      app.image(o['image']) if o.key?('image')
      app.catorder(o['catorder']) if o.key?('catorder')
      app.url(o['url']) if o.key?('url')
      app.envs(o['envs']) if o.key?('envs')
      app.plans(o['plans']) if o.key?('plans')
      app.created_at(o['created_at']) if o.key?('created_at')

      app
    end

    def self.from_hash(o)
      app = new(o)
      app.from_hash(o)
      app
    end

    def from_hash(o)
      @settings_name  = o['settings_name'] if o.key?('settings_name')
      @id             = o['id'] if o.key?('id')
      @cattype        = o['cattype'] if o.key?('cattype')
      @flavor         = o['flavor'] if o.key?('flavor')
      @image          = o['image'] if o.key?('image')
      @catorder            = o['catorder'] if o.key?('catorder')
      @url            = o['url'] if o.key?('url')
      @envs           = o['envs'] if o.key?('envs')
      @plans          = o['plans'] if o.key?('plans')
      @created_at     = o['created_at'] if o.key?('created_at')
      self
    end

    def self.create(params)
      acct = from_hash(params)
      acct.create
    end

    # Create the marketplace app via the REST API
    def create
      megam_rest.post_marketplaceapp(to_hash)
    end

    # Load a account by email_p
    def self.show(params)
      app = new(params)
      app.megam_rest.get_marketplaceapp(params['id'])
    end

    def self.list(params)
      app = new(params)
      app.megam_rest.get_marketplaceapps
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
      # "---> Megam::Account:[error=#{error?}]\n"+
    end
  end
end
