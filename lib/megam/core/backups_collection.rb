module Megam
  class BackupsCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @backups = Array.new
      @backups_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_backups
      @backups
    end

    def [](index)
      @backups[index]
    end

    def []=(index, arg)
      is_megam_backups(arg)
      @backups[index] = arg
      @backups_by_name[arg.account_id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_backups(a)
        @backups << a
        @backups_by_name[a.account_id] = @backups.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(backups)
      is_megam_backups(backups)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @backups.insert(@insert_after_idx + 1, backups)
        # update name -> location mappings and register new node
        @backups_by_name.each_key do |key|
        @backups_by_name[key] += 1 if @backups_by_name[key] > @insert_after_idx
        end
        @backups_by_name[backups.account_id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @backups << backups
      @backups_by_name[backups.account_id] = @backups.length - 1
      end
    end

    def each
      @backups.each do |backups|
        yield backups
      end
    end

    def each_index
      @backups.each_index do |i|
        yield i
      end
    end

    def empty?
      @backups.empty?
    end

    def lookup(backups)
      lookup_by = nil
      if events.kind_of?(Megam::Backups)
      lookup_by = backups.account_id
    elsif backups.kind_of?(String)
      lookup_by = backups
      else
        raise ArgumentError, "Must pass a Megam::Backups or String to lookup"
      end
      res = @backups_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @backups[res]
    end

    def to_s
        @backups.join(", ")
    end

    def for_json
        to_a.map { |item| item.to_s }
    end

    def to_json(*a)
        Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |backups_list|
        backups_array = backups_list.kind_of?(Array) ? backups_list : [ backups_list ]
        backups_array.each do |backups|
          collection.insert(backups)

        end
      end
      collection
    end

    private

    def is_megam_backups(arg)
      unless arg.kind_of?(Megam::Backups)
        raise ArgumentError, "Members must be Megam::Backups's"
      end
      true
    end
  end
end
