#
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Megam
  module Stuff
    extend self
    def has_git?
      %x{ git --version }
      $?.success?
    end

    def git(args)
      return "" unless has_git?
      flattened_args = [args].flatten.compact.join(" ")
      %x{ git #{flattened_args} 2>&1 }.strip
    end

    def time_ago(since)
      if since.is_a?(String)
        since = Time.parse(since)
      end

      elapsed = Time.now - since

      message = since.strftime("%Y/%m/%d %H:%M:%S")
      if elapsed <= 60
        message << " (~ #{elapsed.floor}s ago)"
      elsif elapsed <= (60 * 60)
        message << " (~ #{(elapsed / 60).floor}m ago)"
      elsif elapsed <= (60 * 60 * 25)
        message << " (~ #{(elapsed / 60 / 60).floor}h ago)"
      end
      message
    end

    def spinner(ticks)
      %w(/ - \\ |)[ticks % 4]
    end

    def launchy(message, url)
      action(message) do
        require("launchy")
        launchy = Launchy.open(url)
        if launchy.respond_to?(:join)
        launchy.join
        end
      end
    end

    #
    #left justified keyed hash with newlines.
    def styled_hash(hash)
      hash.map{|k,v| "#{k.ljust(15)}=#{v}"}.join("\n")
    end

  end
end