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
    # GET /nodes
    def list_eventsbilling(limit)
      @options = {:path => "/eventsbilling/#{limit}",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end


    def get_eventsbilling(limit, new_events)
      @options = {:path => "/eventsbilling/show/#{limit}",
        :body => Megam::JSONCompat.to_json(new_events)}.merge(@options)
      request(
        :expects  => 200,
        :method   => :post,
        :body     => @options[:body]
      )
    end

    def index_eventsbilling
      @options = {:path => "/eventsbilling",:body => ""}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end
  end
end
