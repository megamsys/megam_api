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
    # GET /accounts
    #Yet to be tested
    def get_accounts(email)

      @options = {:path => "/accounts/#{email}",
        :body => ''}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        :body     => @options[:body]
      )
    end

    # The body content needs to be a json.
    def post_accounts(new_account)
      @options = {:path => '/accounts/content',
      :body => Megam::JSONCompat.to_json(new_account)}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        :body     => @options[:body]
        )
    end

    def update_accounts(update_account)
      @options = {:path => '/accounts/update',
     :body => Megam::JSONCompat.to_json(update_account)}.merge(@options)

      request(
      :expects => 201,
      :method => :post,
      :body => @options[:body]
      )
    end

    def reset_accounts(account)
      @options = {:path => "/accounts/reset/#{account["email"]}",
     :body => ''}.merge(@options)

      request(
      :expects => 201,
      :method => :get,
      :body => @options[:body]
      )
    end

    def repassword_accounts(account)
      @options = {:path => "/accounts/repassword",
     :body => Megam::JSONCompat.to_json(account)}.merge(@options)

      request(
      :expects => 201,
      :method => :post,
      :body => @options[:body]
      )
    end

  end
end
