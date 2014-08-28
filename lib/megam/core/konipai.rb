# Copyright:: Copyright (c) 2012, 2014 Megam Systems
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
  class KoniPai

    def initialize()
      @koni = nil
    end

    def konipai
      self
    end

    def koni(arg=nil)
      if arg != nil
        @koni = arg
      else
      @koni
      end
    end


    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["json_claz"] = self.class.name
      index_hash["koni"] = koni
      index_hash
    end


    def self.json_create(o)
      kp  = new
      kp.koni(o) if o != null
      kp
    end


    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end

  end
end
