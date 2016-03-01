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
  class API
    def get_organizations
      @options = {:path => '/organizations',:body => ''}.merge(@options)

      request(
        :expects => 200,
        :method => :get,
        :body => @options[:body]

      )
    end

    def get_organization(id)

      @options = {:path => "/organizations/#{id}",
      :body => ''}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_organization(new_organization)

      @options = {:path => '/organizations/content',
      :body =>  Megam::JSONCompat.to_json(new_organization)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

    def update_organization(new_organization)

      @options = {:path => '/organizations/update',
      :body =>  Megam::JSONCompat.to_json(new_organization)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end
  end
end
