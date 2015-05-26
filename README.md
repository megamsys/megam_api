Megam api for ruby
==================

[![Gem Version](https://badge.fury.io/rb/megam_api.svg)](http://badge.fury.io/rb/megam_api)

Megam api is used to talk to console.megam.io

For more about the REST API <http://docs.megam.io/v1.0/docs/assemblies>

[![Build Status](https://travis-ci.org/megamsys/megam_api.png)](https://travis-ci.org/megamsys/megam_api)


Usage
-----

```shell

gem install megam_api

```

* Let us show an account with email = "your_email_id"

```ruby

    require 'megam_api'

    require 'meggy/meg'
    require 'megam/core/server_api'
    require 'command_line_reporter'

    class Meggy
      class Meg
        class AccountShow < Meg
          include CommandLineReporter

          banner "meg account show"
          def run
            begin
              Megam::Config[:email] = Meggy::Config[:email]
              Megam::Config[:api_key] = Meggy::Config[:api_key]
              @excon_res = Megam::Account.show(Megam::Config[:email])
              acct_res = @excon_res.data[:body]
              report(acct_res)
            rescue Megam::API::Errors::ErrorWithResponse => ewr
              res = ewr.response.data[:body].some_msg
              text.error(res[:msg])
              text.msg("#{text.color("Retry Again", :white, :bold)}")
              text.info(res[:links])
            end
          end

          def report(acct_res)
            table :border => true do
              row :header => true, :color => 'green' do
                column 'Account', :width => 15
                column 'Information', :width => 32, :align => 'left'
              end
              row do
                column 'email'
                column acct_res.email
              end
              row do
                column 'api_key'
                column acct_res.api_key
              end
              row do
                column 'authority'
                column acct_res.authority
              end
              row do
                column 'created_at'
                column acct_res.created_at
              end
            end
          end

        end
      end
    end
```

* See [meggy](https://github.com/megamsys/meggy.git) where the files like `Meg` are there.

For more implementation details [see meggy](https://github.com/megamsys/meggy.git)

We are glad to help if you have questions, or request for new features..

[twitter @megamsys](http://twitter.com/megamsys) [email support@megam.co.in](<support@megam.co.in>)




# License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Kishorekumar Neelamegam (<nkishore@megam.io>)
|                      | Raj Thilak (<rajthilak@megam.io>)
|                      | Yeshwanth Kumar (<getyesh@megam.io>)
|                      | Subash Sethurajan (<subash.avc@gmail.com>)
|                      | Thomas Alrin (<thomasalrin@megam.io>)
| **Copyright:**       | Copyright (c) 2012-2014 Megam Systems.
| **License:**         | Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
