module Megam
  class ReportsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @reports = Array.new
      @reports_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_reports
      @reports
    end

    def [](index)
      @reports[index]
    end

    def []=(index, arg)
      is_megam_reports(arg)
      @reports[index] = arg
      @reports_by_name[arg.account_id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_events(a)
        @reports << a
        @reports_by_name[a.account_id] = @reports.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(reports)
      is_megam_reports(reports)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @reports.insert(@insert_after_idx + 1, reports)
        # update name -> location mappings and register new node
        @reports_by_name.each_key do |key|
        @reports_by_name[key] += 1 if @reports_by_name[key] > @insert_after_idx
        end
        @reports_by_name[reports.account_id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @reports << reports
      @reports_by_name[reports.account_id] = @reports.length - 1
      end
    end

    def each
      @reports.each do |reports|
        yield reports
      end
    end

    def each_index
      @reports.each_index do |i|
        yield i
      end
    end

    def empty?
      @reports.empty?
    end

    def lookup(reports)
      lookup_by = nil
      if events.kind_of?(Megam::reports)
      lookup_by = reports.account_id
    elsif reports.kind_of?(String)
      lookup_by = reports
      else
        raise ArgumentError, "Must pass a Megam::reports or String to lookup"
      end
      res = @reports_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @reports[res]
    end

    def to_s
        @reports.join(", ")
    end

    def for_json
        to_a.map { |item| item.to_s }
    end

    def to_json(*a)
        Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |reports_list|
        reports_array = reports_list.kind_of?(Array) ? reports_list : [ reports_list ]
        reports_array.each do |reports|
          collection.insert(reports)

        end
      end
      collection
    end

    private

    def is_megam_reports(arg)
      unless arg.kind_of?(Megam::reports)
        raise ArgumentError, "Members must be Megam::reports's"
      end
      true
    end
  end
end
