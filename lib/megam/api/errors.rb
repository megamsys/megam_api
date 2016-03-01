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
    module Errors
      class Error < StandardError; end

      class ErrorWithResponse < Error
        attr_reader :response

        def initialize(message, response)
          super message
          @response = response
        end


      end

      class Unauthorized < ErrorWithResponse; end
      class Forbidden < ErrorWithResponse; end
      class NotFound < ErrorWithResponse; end
      class Timeout < ErrorWithResponse; end
      class Locked < ErrorWithResponse; end
      class Socket < ErrorWithResponse; end
      class RequestFailed < ErrorWithResponse; end

      class AuthKeysMissing < ArgumentError; end

    end
  end
end
