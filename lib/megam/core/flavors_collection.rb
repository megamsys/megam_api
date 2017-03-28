module Megam
    class FlavorsCollection
        include Enumerable

        attr_reader :iterator

        def initialize
            @flavors = Array.new
            @flavors_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_flavors
            @flavors
        end

        def [](index)
            @flavors[index]
        end

        def []=(index, arg)
            is_megam_flavors(arg)
            @flavors[index] = arg
            @flavors_by_name[arg.name] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_flavors(a)
                @flavors << a
                @flavors_by_name[a.name] =@flavors.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(flavors)
            is_megam_flavors(flavors)
            if @insert_after_idx
                # in the middle of executing a run, so any flavors inserted now should
                # be placed after the most recent addition done by the currently executing
                # flavors
                @flavors.insert(@insert_after_idx + 1, flavors)
                # update name -> location mappings and register new flavors
                @flavors_by_name.each_key do |key|
                    @flavors_by_name[key] += 1 if@flavors_by_name[key] > @insert_after_idx
                end
                @flavors_by_name[flavors.name] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @flavors << flavors
                @flavors_by_name[flavors.name] =@flavors.length - 1
            end
        end

        def each
            @flavors.each do |flavors|
                yield flavors
            end
        end

        def each_index
            @flavors.each_index do |i|
                yield i
            end
        end

        def empty?
            @flavors.empty?
        end

        def lookup(flavors)
            lookup_by = nil
            if flavors.kind_of?(Megam::Flavors)
                lookup_by = flavors.name
            elsif flavors.kind_of?(String)
                lookup_by = flavors
            else
                raise ArgumentError, "Must pass a Megam::flavors or String to lookup"
            end
            res =@flavors_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a flavors matching #{lookup_by} (did you define it first?)"
            end
            @flavors[res]
        end

        def to_s
            @flavors.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |flavors_list|
                flavors_array = flavors_list.kind_of?(Array) ? flavors_list : [ flavors_list ]
                flavors_array.each do |flavors|
                    collection.insert(flavors)
                end
            end
            collection
        end

        private

        def is_megam_flavors(arg)
            unless arg.kind_of?(Megam::Flavors)
                raise ArgumentError, "Members must be Megam::Flavors's"
            end
            true
        end
    end
end
