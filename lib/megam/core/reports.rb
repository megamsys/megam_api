module Megam
    class Reports < Megam::RestAdapter
        def initialize(o)
         @start_date = nil
         @end_date = nil
         @type_of = nil
         @title = nil
         @xaxis = nil
         @yaxis = nil
         @ytitles = {}
         @data = []
         @total = nil
         @category = nil
         @group = nil
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

        def type_of(arg=nil)
            if arg != nil
                @type_of = arg
            else
                @type_of
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
            index_hash["start_date"] = start_date
            index_hash["end_date"] = end_date
            index_hash["type_of"] = type_of
            index_hash["category"] = category
            index_hash["group"] = group
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
                "type_of" => type_of,
                "title" => title,
                "yaxis" => yaxis,
                "xaxis" => xaxis,
                "ytitles" => ytitles,
                "data" => data,
                "total" => total,
                "category" => category,
                "group" => group
            }
            result
        end

        def self.json_create(o)
            sps = new({})
            sps.start_date(o["start_date"]) if o.has_key?("start_date")
            sps.end_date(o["end_date"]) if o.has_key?("end_date")
            sps.type_of(o["type_of"]) if o.has_key?("type_of")
            sps.title(o["title"]) if o.has_key?("title")
            sps.yaxis(o["yaxis"]) if o.has_key?("yaxis")
            sps.xaxis(o["xaxis"]) if o.has_key?("xaxis")
            sps.ytitles(o["ytitles"]) if o.has_key?("ytitles")
            sps.data(o["data"]) if o.has_key?("data")
            sps.total(o["total"]) if o.has_key?("total")
            sps.category(o["category"]) if o.has_key?("category")
            sps.group(o["group"]) if o.has_key?("group")
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
