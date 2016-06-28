##
## Copyright 2013-2016 Megam Systems
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
module Megam
    class Billingtransactions < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @accounts_id = nil
            @gateway = nil
            @amountin = nil
            @amountout = nil
            @fees = nil
            @tranid = nil
            @trandate = nil
            @currency_type = nil
            @created_at = nil
            @some_msg = {}
            super(o)
        end

        def
            self
        end

        def id(arg=nil)
            if arg != nil
                @id = arg
            else
                @id
            end
        end

        def accounts_id(arg=nil)
            if arg != nil
                @accounts_id= arg
            else
                @accounts_id
            end
        end

        def gateway(arg=nil)
            if arg != nil
                @gateway= arg
            else
                @gateway
            end
        end

        def amountin(arg=nil)
            if arg != nil
                @amountin= arg
            else
                @amountin
            end
        end

        def amountout(arg=nil)
            if arg != nil
                @amountout= arg
            else
                @amountout
            end
        end

        def fees(arg=nil)
            if arg != nil
                @fees = arg
            else
                @fees
            end
        end

        def tranid(arg=nil)
            if arg != nil
                @tranid = arg
            else
                @tranid
            end
        end

        def trandate(arg=nil)
            if arg != nil
                @trandate = arg
            else
                @trandate
            end
        end

        def currency_type(arg=nil)
            if arg != nil
                @currency_type = arg
            else
                @currency_type
            end
        end

        def created_at(arg=nil)
            if arg != nil
                @created_at = arg
            else
                @created_at
            end
        end

        def some_msg(arg=nil)
            if arg != nil
                @some_msg = arg
            else
                @some_msg
            end
        end

        def error?
            crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
        end

        # Transform the ruby obj ->  to a Hash
        def to_hash
            index_hash = Hash.new
            index_hash["json_claz"] = self.class.name
            index_hash["id"] = id
            index_hash["accounts_id"] = accounts_id
            index_hash["gateway"] = gateway
            index_hash["amountin"] = amountin
            index_hash["amountout"] = amountout
            index_hash["fees"] = fees
            index_hash["tranid"] = tranid
            index_hash["trandate"] = trandate
            index_hash["currency_type"] = currency_type
            index_hash["created_at"] = created_at
            index_hash
        end

        # Serialize this object as a hash: called from JsonCompat.
        # Verify if this called from JsonCompat during testing.
        def to_json(*a)
            for_json.to_json(*a)
        end

        def for_json
            result = {
                "id" => id,
                "accounts_id" => accounts_id,
                "gateway" => gateway,
                "amountin" => amountin,
                "amountout" => amountout,
                "fees" => fees,
                "tranid" => tranid,
                "trandate" => trandate,
                "currency_type" => currency_type,
                "created_at" => created_at
            }
            result
        end

        #
        def self.json_create(o)
            bal = new({})
            bal.id(o["id"]) if o.has_key?("id")
            bal.accounts_id(o["accounts_id"]) if o.has_key?("accounts_id")
            bal.gateway(o["gateway"]) if o.has_key?("gateway")
            bal.amountin(o["amountin"]) if o.has_key?("amountin")
            bal.amountout(o["amountout"]) if o.has_key?("amountout")
            bal.fees(o["fees"]) if o.has_key?("fees")
            bal.tranid(o["tranid"]) if o.has_key?("tranid")
            bal.trandate(o["trandate"]) if o.has_key?("trandate")
            bal.currency_type(o["currency_type"]) if o.has_key?("currency_type")
            bal.created_at(o["created_at"]) if o.has_key?("created_at")
            #success or error
            bal.some_msg[:code] = o["code"] if o.has_key?("code")
            bal.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            bal.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            bal.some_msg[:links] = o["links"] if o.has_key?("links")
            bal
        end

        def self.from_hash(o)
            bal = self.new(o)
            bal.from_hash(o)
            bal
        end

        def from_hash(o)
            @id            = o[:id] if o.has_key?(:id)
            @accounts_id   = o[:accounts_id] if o.has_key?(:accounts_id)
            @gateway       = o[:gateway] if o.has_key?(:gateway)
            @amountin      = o[:amountin] if o.has_key?(:amountin)
            @amountout     = o[:amountout] if o.has_key?(:amountout)
            @fees          = o[:fees] if o.has_key?(:fees)
            @tranid        = o[:tranid] if o.has_key?(:tranid)
            @trandate      = o[:trandate] if o.has_key?(:trandate)
            @currency_type = o[:currency_type] if o.has_key?(:currency_type)
            @created_at    = o[:created_at] if o.has_key?(:created_at)
            self
        end

        def self.create(params)
            acct = from_hash(params)
            acct.create
        end

        def create
            megam_rest.post_billedhistories(to_hash)
        end

        def self.list(params)
            bill = self.new(params)
            bill.megam_rest.get_billingtransactions
        end


        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
