#
# Copyright:: Copyright (c) 2012-2013 Megam Systems.
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

require 'mixlib/config'

module Megam
  class Config

    extend Mixlib::Config

    def self.inspect
      configuration.inspect
    end

    email nil
    password nil
    api_key nil

    # Set these to enable SSL authentication / mutual-authentication
    # with the server
    ssl_client_cert nil
    ssl_client_key nil
    ssl_verify_mode :verify_none
    ssl_ca_path nil
    ssl_ca_file nil

  end
end
