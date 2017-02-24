module Megam
  class RawimagesCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @rawimages = Array.new
      @rawimages_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_rawimages
      @rawimages
    end

    def [](index)
      @rawimages[index]
    end

    def []=(index, arg)
      is_megam_rawimages(arg)
      @rawimages[index] = arg
      @rawimages_by_name[arg.id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_rawimages(a)
        @rawimages << a
        @rawimages_by_name[a.id] = @rawimages.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(rawimages)
      is_megam_rawimages(rawimages)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @rawimages.insert(@insert_after_idx + 1, rawimages)
        # update name -> location mappings and register new node
        @rawimages_by_name.each_key do |key|
        @rawimages_by_name[key] += 1 if @rawimages_by_name[key] > @insert_after_idx
        end
        @rawimages_by_name[rawimages.id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @rawimages << rawimages
      @rawimages_by_name[rawimages.id] = @rawimages.length - 1
      end
    end

    def each
      @rawimages.each do |rawimages|
        yield rawimages
      end
    end

    def each_index
      @rawimages.each_index do |i|
        yield i
      end
    end

    def empty?
      @rawimages.empty?
    end

    def lookup(rawimages)
      lookup_by = nil
      if rawimages.kind_of?(Megam::Rawimages)
      lookup_by = rawimages.id
    elsif rawimages.kind_of?(String)
      lookup_by = rawimages
      else
        raise ArgumentError, "Must pass a Megam::Rawimages or String to lookup"
      end
      res = @rawimages_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @rawimages[res]
    end

    def to_s
        @rawimages.join(", ")
    end

    def for_json
        to_a.map { |item| item.to_s }
    end

    def to_json(*a)
        Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |rawimages_list|
        rawimages_array = rawimages_list.kind_of?(Array) ? rawimages_list : [ rawimages_list ]
        rawimages_array.each do |rawimages|
          collection.insert(rawimages)
        end
      end
      collection
    end

    private

    def is_megam_rawimages(arg)
      unless arg.kind_of?(Megam::Rawimages)
        raise ArgumentError, "Members must be Megam::Rawimages's"
      end
      true
    end
  end
end
