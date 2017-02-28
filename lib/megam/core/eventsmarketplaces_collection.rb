module Megam
    class EventsMarketplacesCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @eventsmarketplaces = Array.new
            @eventsmarketplaces_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_eventsmarketplaces
            @eventsmarketplaces
        end

        def [](index)
            @eventsmarketplaces[index]
        end

        def []=(index, arg)
            is_megam_eventsvm(arg)
            @eventsmarketplaces[index] = arg
            @eventsmarketplaces_by_name[arg.account_id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_events(a)
                @eventsmarketplaces << a
                @eventsmarketplaces_by_name[a.account_id] = @eventsmarketplaces.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(eventsmarketplaces)
            is_megam_eventsmarketplaces(eventsmarketplaces)
            if @insert_after_idx
                # in the middle of executing a run, so any nodes inserted now should
                # be placed after the most recent addition done by the currently executing
                # node
                @eventsmarketplaces.insert(@insert_after_idx + 1, eventsmarketplaces)
                # update name -> location mappings and register new node
                @eventsmarketplaces_by_name.each_key do |key|
                    @eventsmarketplaces_by_name[key] += 1 if @eventsmarketplaces_by_name[key] > @insert_after_idx
                end
                @eventsmarketplaces_by_name[eventsmarketplaces.account_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @eventsmarketplaces << eventsmarketplaces
                @eventsmarketplaces_by_name[eventsmarketplaces.account_id] = @eventsmarketplaces.length - 1
            end
        end

        def each
            @eventsmarketplaces.each do |eventsmarketplaces|
                yield eventsmarketplaces
            end
        end

        def each_index
            @eventsmarketplaces.each_index do |i|
                yield i
            end
        end

        def empty?
            @eventsmarketplaces.empty?
        end

        def lookup(eventsmarketplaces)
            lookup_by = nil
            if events.kind_of?(Megam::EventsMarketplaces)
                lookup_by = eventsmarketplaces.account_id
            elsif eventsmarketplaces.kind_of?(String)
                lookup_by = eventsmarketplaces
            else
                raise ArgumentError, "Must pass a Megam::EventsMarketplaces or String to lookup"
            end
            res = @eventsmarketplaces_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
            end
            @eventsmarketplaces[res]
        end

        def to_s
            @eventsmarketplaces.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |eventsmarketplaces_list|
                eventsmarketplaces_array = eventsmarketplaces_list.kind_of?(Array) ? eventsmarketplaces_list : [ eventsmarketplaces_list ]
                eventsmarketplaces_array.each do |eventsmarketplaces|
                    collection.insert(eventsmarketplaces)

                end
            end
            collection
        end

        private

        def is_megam_eventsmarketplaces(arg)
            unless arg.kind_of?(Megam::EventsMarketplaces)
                raise ArgumentError, "Members must be Megam::EventsMarketplaces's"
            end
            true
        end
    end
end
