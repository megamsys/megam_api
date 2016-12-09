module Megam
    class Reports < Megam::RestAdapter

        def initialize(o)
            @id = nil
            @start_date = nil
            @end_date = nil
            @type_of = nil
            @data = []
            @category = nil
            @group = nil
            @created_at = nil
            @some_msg = {}
            super(o)
        end

        def reports
            self
        end

        def id(arg=nil)
          if arg != nil
              @id = arg
          else
              @id
          end
        end

        def start_date(arg=nil)
            if arg != nil
                @start_date = arg
            else
                @start_date
            end
        end

        def end_date(arg=nil)
            if arg != nil
                @end_date = arg
            else
                @end_date
            end
        end

        def type_of(arg=nil)
            if arg != nil
                @type_of = arg
            else
                @type_of
            end
        end

        def data(arg = [])
            if arg != []
                @data = arg
            else
                @data
            end
        end

        def category(arg=nil)
            if arg !=nil
                @category = arg
            else
                @category
            end
        end

        def group(arg=nil)
            if arg !=nil
                @group = arg
            else
                @group
            end
        end

        def created_at(arg=nil)
            if arg != nil
                @created_date = arg
            else
                @created_date
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

        def to_hash
            index_hash = Hash.new
            index_hash["start_date"] = start_date
            index_hash["end_date"] = end_date
            index_hash["type_of"] = type_of
            index_hash["category"] = category
            index_hash["group"] = group
            index_hash
        end

        def to_json(*a)
            for_json.to_json(*a)
        end

        def for_json
            result = {
                "id" => id,
                "start_date" => start_date,
                "end_date" => end_date,
                "type_of" => type_of,
                "data" => data,
                "category" => category,
                "group" => group,
                "created_at" =>  created_at
            }
            result
        end

        def self.json_create(o)
            sps = new({})
            sps.id(o["id"]) if o.has_key?("id")
            sps.start_date(o["start_date"]) if o.has_key?("start_date")
            sps.end_date(o["end_date"]) if o.has_key?("end_date")
            sps.type_of(o["type_of"]) if o.has_key?("type_of")
            sps.data(o["data"]) if o.has_key?("data")
            sps.category(o["category"]) if o.has_key?("category")
            sps.group(o["group"]) if o.has_key?("group")
            sps.created_at(o["created_at"]) if o.has_key?("created_at")
            sps
        end

        def self.from_hash(o)
            sps = self.new(o)
            sps.from_hash(o)
            sps
        end

        def from_hash(o)
            @start_date       = o[:start_date] if o.has_key?(:start_date)
            @end_date         = o[:end_date] if o.has_key?(:end_date)
            @type_of          = o[:type_of] if o.has_key?(:type_of)
            @category         = o[:category] if o.has_key?(:category)
            @group            = o[:group] if o.has_key?(:group)
            self
        end

        def self.create(params)
            sps = from_hash(params)
            sps.create
        end

        def create
            megam_rest.post_reports(to_hash)
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
