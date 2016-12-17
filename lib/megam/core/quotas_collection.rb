module Megam
  class QuotasCollection
    include Enumerable

    attr_reader :iterator
    def initialize
      @quotas = Array.new
      @quotas_by_name = Hash.new
      @insert_after_idx = nil
    end

    def all_quotas
      @quotas
    end

    def [](index)
      @quotas[index]
    end

    def []=(index, arg)
      is_megam_quotas(arg)
      @quotas[index] = arg
      @quotas_by_name[arg.id] = index
    end

    def <<(*args)
      args.flatten.each do |a|
        is_megam_quotas(a)
        @quotas << a
        @quotas_by_name[a.id] = @quotas.length - 1
      end
      self
    end

    # 'push' is an alias method to <<
    alias_method :push, :<<

    def insert(quotas)
      is_megam_quotas(quotas)
      if @insert_after_idx
        # in the middle of executing a run, so any nodes inserted now should
        # be placed after the most recent addition done by the currently executing
        # node
        @quotas.insert(@insert_after_idx + 1, quotas)
        # update name -> location mappings and register new node
        @quotas_by_name.each_key do |key|
        @quotas_by_name[key] += 1 if @quotas_by_name[key] > @insert_after_idx
        end
        @quotas_by_name[quotas.id] = @insert_after_idx + 1
        @insert_after_idx += 1
      else
      @quotas << quotas
      @quotas_by_name[quotas.id] = @quotas.length - 1
      end
    end

    def each
      @quotas.each do |quotas|
        yield quotas
      end
    end

    def each_index
      @quotas.each_index do |i|
        yield i
      end
    end

    def empty?
      @quotas.empty?
    end

    def lookup(quotas)
      lookup_by = nil
      if quotas.kind_of?(Megam::Quotas)
      lookup_by = quotas.id
    elsif quotas.kind_of?(String)
      lookup_by = quotas
      else
        raise ArgumentError, "Must pass a Megam::Quotas or String to lookup"
      end
      res = @quotas_by_name[lookup_by]
      unless res
        raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
      end
      @quotas[res]
    end

    def to_s
        @quotas.join(", ")
    end

    def for_json
        to_a.map { |item| item.to_s }
    end

    def to_json(*a)
        Megam::JSONCompat.to_json(for_json, *a)
    end

    def self.json_create(o)
      collection = self.new()
      o["results"].each do |quotas_list|
        quotas_array = quotas_list.kind_of?(Array) ? quotas_list : [ quotas_list ]
        quotas_array.each do |quotas|
          collection.insert(quotas)
        end
      end
      collection
    end

    private

    def is_megam_quotas(arg)
      unless arg.kind_of?(Megam::Quotas)
        raise ArgumentError, "Members must be Megam::Quotas's"
      end
      true
    end
  end
end
