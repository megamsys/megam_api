module Megam
    class Reports < Megam::RestAdapter
        def initialize(o)
         @start_date = nil
         @end_date = nil
         @type = nil
         @title = nil
         @xaxis = nil
         @yaxis = nil
         @ytitles = {}
         @data = []
         @total = nil
         @category_id = nil
         @group_id = nil
         @prev30Days = nil
         @some_msg = {}
         super(o)
        end

        def reports
            self
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

        def type(arg=nil)
            if arg != nil
                @type = arg
            else
                @type
            end
        end

        def title(arg=nil)
            if arg !=nil
                @title = arg
            else
                @title
            end
        end

        def xaxis(arg=nil)
            if arg !=nil
                @xaxis = arg
            else
                @xaxis
            end
        end

        def yaxis(arg=nil)
            if arg !=nil
                @yaxis = arg
            else
                @yaxis
            end
        end

        def ytitles(arg=nil)
            if arg !=nil
                @ytitles = arg
            else
                @ytitles
            end
        end

        def data(arg = [])
            if arg != []
                @data = arg
            else
                @data
            end
        end

        def total(arg=nil)
            if arg !=nil
                @total = arg
            else
                @total
            end
        end

        def category_id(arg=nil)
            if arg !=nil
                @category_id = arg
            else
                @category_id
            end
        end

        def group_id(arg=nil)
            if arg !=nil
                @group_id = arg
            else
                @group_id
            end
        end

        def prev30Days(arg=nil)
            if arg !=nil
                @prev30Days = arg
            else
                @prev30Days
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
            index_hash["start_date"] = start_date
            index_hash["end_date"] = end_date
            index_hash["type"] = type
            index_hash
        end

        # Serialize this object as a hash: called from JsonCompat.
        # Verify if this called from JsonCompat during testing.
        def to_json(*a)
            for_json.to_json(*a)
        end


        def for_json
            result = {
              "start_date" => start_date,
                "end_date" => end_date,
                "type" => type,
                "title" => title,
                "yaxis" => yaxis,
                "xaxis" => xaxis,
                "ytitles" => ytitles,
                "data" => data,
                "total" => total,
                "category_id" => category_id,
                "group_id" => group_id,
                "prev30Days" => prev30Days
            }
            result
        end

        def self.json_create(o)
            sps = new({})
            sps.start_date(o["start_date"]) if o.has_key?("start_date")
            sps.end_date(o["end_date"]) if o.has_key?("end_date")
            sps.type(o["type"]) if o.has_key?("type")
            sps.type(o["title"]) if o.has_key?("title")
            sps.type(o["yaxis"]) if o.has_key?("yaxis")
            sps.type(o["xaxis"]) if o.has_key?("xaxis")
            sps.type(o["ytitles"]) if o.has_key?("ytitles")
            sps.type(o["data"]) if o.has_key?("data")
            sps.type(o["total"]) if o.has_key?("total")
            sps.type(o["category_id"]) if o.has_key?("category_id")
            sps.type(o["group_id"]) if o.has_key?("group_id")
            sps.type(o["prev30Days"]) if o.has_key?("prev30Days")
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
            @type             = o[:type] if o.has_key?(:type)
            self
        end

        def self.create(params)
            sps = from_hash(params)
            sps.create
        end

        # Create the node via the REST API
        def create
            megam_rest.post_reports(to_hash)
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end

    end
end
