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

    # GET /csars
    def get_csars
      @options = {:path => '/csars',:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def get_csar(id)
      @options = {:path => "/csars/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    def post_csar(new_csar)
      @options = {:path => '/csars/content',
        :body => new_csar}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
      )
    end

    def push_csar(id)
      @options = {:path => "/csars/push/#{id}",:body => ""}.merge(@options)

      request(
        :expects  => 201,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    #Yet to be tested
    # DELETE /marketplacess/:node_id
    def delete_marketplaceapp(node_id)
      @options = {:path => '/marketplaces/#{node_id}',
        :body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :delete,
        :body     => @options[:body]
      )
    end

  end
end
