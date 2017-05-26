module Megam
    class EventsMarketplaceCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @eventsmarketplace = Array.new
            @eventsmarketplace_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_eventsmarketplace
            @eventsmarketplace
        end

        def [](index)
            @eventsmarketplace[index]
        end

        def []=(index, arg)
            is_megam_eventsvm(arg)
            @eventsmarketplace[index] = arg
            @eventsmarketplace_by_name[arg.account_id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_events(a)
                @eventsmarketplace << a
                @eventsmarketplace_by_name[a.account_id] = @eventsmarketplace.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(eventsmarketplace)
            is_megam_eventsmarketplace(eventsmarketplace)
            if @insert_after_idx
                # in the middle of executing a run, so any nodes inserted now should
                # be placed after the most recent addition done by the currently executing
                # node
                @eventsmarketplace.insert(@insert_after_idx + 1, eventsmarketplace)
                # update name -> location mappings and register new node
                @eventsmarketplace_by_name.each_key do |key|
                    @eventsmarketplace_by_name[key] += 1 if @eventsmarketplace_by_name[key] > @insert_after_idx
                end
                @eventsmarketplace_by_name[eventsmarketplace.account_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @eventsmarketplace << eventsmarketplace
                @eventsmarketplace_by_name[eventsmarketplace.account_id] = @eventsmarketplace.length - 1
            end
        end

        def each
            @eventsmarketplace.each do |eventsmarketplace|
                yield eventsmarketplace
            end
        end

        def each_index
            @eventsmarketplace.each_index do |i|
                yield i
            end
        end

        def empty?
            @eventsmarketplace.empty?
        end

        def lookup(eventsmarketplace)
            lookup_by = nil
            if events.kind_of?(Megam::EventsMarketplace)
                lookup_by = eventsmarketplace.account_id
            elsif eventsmarketplace.kind_of?(String)
                lookup_by = eventsmarketplace
            else
                raise ArgumentError, "Must pass a Megam::EventsMarketplace or String to lookup"
            end
            res = @eventsmarketplace_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
            end
            @eventsmarketplace[res]
        end

        def to_s
            @eventsmarketplace.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |eventsmarketplace_list|
                eventsmarketplace_array = eventsmarketplace_list.kind_of?(Array) ? eventsmarketplace_list : [ eventsmarketplace_list ]
                eventsmarketplace_array.each do |eventsmarketplace|
                    collection.insert(eventsmarketplace)

                end
            end
            collection
        end

        private

        def is_megam_eventsmarketplace(arg)
            unless arg.kind_of?(Megam::EventsMarketplace)
                raise ArgumentError, "Members must be Megam::EventsMarketplace's"
            end
            true
        end
    end
end
