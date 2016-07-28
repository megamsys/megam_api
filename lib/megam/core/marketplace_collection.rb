module Megam
  class MarketPlaceCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @apps = Array.new
      @apps_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_apps
      @apps
    end

    def [](index)
      @apps[index]
    end

    def []=(index, arg)
      is_megam_app(arg)
      @apps[index] = arg
      @apps_by_name[arg.flavor] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_app(a)
        @apps << a
        @apps_by_name[a.flavor] = @apps.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(app)
      is_megam_app(app)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @apps.insert(@insert_after_idx + 1, app)
        # update name -> location mappings and register new node
        @apps_by_name.each_key do |key|
        @apps_by_name[key] += 1 if @apps_by_name[key] > @insert_after_idx
        end
        @apps_by_name[app.flavor] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @apps << app
      @apps_by_name[app.flavor] = @apps.length - 1
      end
    end

    def each
      @apps.each do |app|
        yield app
      end
    end

    def each_index
      @apps.each_index do |i|
        yield i
      end
    end

    def empty?
      @apps.empty?
    end

    def lookup(app)
      lookup_by = nil
      if app.kind_of?(Megam::MarketPlace)
      lookup_by = app.flavor
      elsif app.kind_of?(String)
      lookup_by = app
      else
        raise ArgumentError, "Must pass a Megam::MarketPlace or String to lookup"
      end
      res = @apps_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a app matching #{lookup_by} (did you define it first?)"
      end
      @apps[res]
    end

    def to_s
        @apps.join(", ")
    end

    def for_json
      to_a.map { |item| item.to_s }
    end

    def to_json(*a)
      Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |apps_list|
        apps_array = apps_list.kind_of?(Array) ? apps_list : [ apps_list ]
        apps_array.each do |app|
          collection.insert(app)
        end
      end
      collection
    end

    private



    def is_megam_app(arg)
      unless arg.kind_of?(Megam::MarketPlace)
        raise ArgumentError, "Members must be Megam::MarketPlace's"
      end
      true
    end
  end
end
