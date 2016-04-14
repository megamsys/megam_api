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
module Megam
    class RestAdapter
        attr_reader :email
        attr_reader :api_key
        attr_reader :host
        attr_reader :password
        attr_reader :org_id
        attr_reader :header


        ## clean up this module later.
        def initialize(o)
            @email = o[:email]
            @api_key = o[:api_key] || nil
            @host = o[:host]
            @password = o[:password] || nil
            @org_id = o[:org_id]
            @header = o[:header]
        end

        # Build a megam api client
        #
        # === Parameters
        # api:: The Megam::API client
        def megam_rest
            options = {
              :email => email,
              :api_key => api_key,
              :org_id => org_id,
              :password => password,
              :host => host,
              :header => header
            }
            Megam::API.new(options)
        end
    end
end
