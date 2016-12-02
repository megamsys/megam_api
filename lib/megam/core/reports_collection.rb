module Megam
  class SnapshotsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @snapshots = Array.new
      @snapshots_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_snapshots
      @snapshots
    end

    def [](index)
      @snapshots[index]
    end

    def []=(index, arg)
      is_megam_snapshots(arg)
      @snapshots[index] = arg
      @snapshots_by_name[arg.account_id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_events(a)
        @snapshots << a
        @snapshots_by_name[a.account_id] = @snapshots.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(snapshots)
      is_megam_snapshots(snapshots)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @snapshots.insert(@insert_after_idx + 1, snapshots)
        # update name -> location mappings and register new node
        @snapshots_by_name.each_key do |key|
        @snapshots_by_name[key] += 1 if @snapshots_by_name[key] > @insert_after_idx
        end
        @snapshots_by_name[snapshots.account_id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @snapshots << snapshots
      @snapshots_by_name[snapshots.account_id] = @snapshots.length - 1
      end
    end

    def each
      @snapshots.each do |snapshots|
        yield snapshots
      end
    end

    def each_index
      @snapshots.each_index do |i|
        yield i
      end
    end

    def empty?
      @snapshots.empty?
    end

    def lookup(snapshots)
      lookup_by = nil
      if events.kind_of?(Megam::Snapshots)
      lookup_by = snapshots.account_id
    elsif snapshots.kind_of?(String)
      lookup_by = snapshots
      else
        raise ArgumentError, "Must pass a Megam::Snapshots or String to lookup"
      end
      res = @snapshots_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @snapshots[res]
    end

    def to_s
        @snapshots.join(", ")
    end

    def for_json
        to_a.map { |item| item.to_s }
    end

    def to_json(*a)
        Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |snapshots_list|
        snapshots_array = snapshots_list.kind_of?(Array) ? snapshots_list : [ snapshots_list ]
        snapshots_array.each do |snapshots|
          collection.insert(snapshots)

        end
      end
      collection
    end

    private

    def is_megam_snapshots(arg)
      unless arg.kind_of?(Megam::Snapshots)
        raise ArgumentError, "Members must be Megam::Snapshots's"
      end
      true
    end
  end
end
