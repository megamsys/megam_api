module Megam
  class DisksCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @disks = Array.new
      @disks_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_disks
      @disks
    end

    def [](index)
      @disks[index]
    end

    def []=(index, arg)
      is_megam_disks(arg)
      @disks[index] = arg
      @disks_by_name[arg.account_id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_events(a)
        @disks << a
        @disks_by_name[a.account_id] = @disks.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(disks)
      is_megam_disks(disks)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @disks.insert(@insert_after_idx + 1, disks)
        # update name -> location mappings and register new node
        @disks_by_name.each_key do |key|
        @disks_by_name[key] += 1 if @disks_by_name[key] > @insert_after_idx
        end
        @disks_by_name[disks.account_id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @disks << disks
      @disks_by_name[disks.account_id] = @disks.length - 1
      end
    end

    def each
      @disks.each do |disks|
        yield disks
      end
    end

    def each_index
      @disks.each_index do |i|
        yield i
      end
    end

    def empty?
      @disks.empty?
    end

    def lookup(disks)
      lookup_by = nil
      if events.kind_of?(Megam::Disks)
      lookup_by = disks.account_id
    elsif disks.kind_of?(String)
      lookup_by = disks
      else
        raise ArgumentError, "Must pass a Megam::Disks or String to lookup"
      end
      res = @disks_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @disks[res]
    end

    def to_s
        @disks.join(", ")
    end

    def for_json
        to_a.map { |item| item.to_s }
    end

    def to_json(*a)
        Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |disks_list|
        disks_array = disks_list.kind_of?(Array) ? disks_list : [ disks_list ]
        disks_array.each do |disks|
          collection.insert(disks)

        end
      end
      collection
    end

    private

    def is_megam_disks(arg)
      unless arg.kind_of?(Megam::Disks)
        raise ArgumentError, "Members must be Megam::Disks's"
      end
      true
    end
  end
end
