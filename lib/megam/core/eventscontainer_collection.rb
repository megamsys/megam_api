module Megam
    class EventsContainerCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @eventscontainer = Array.new
            @eventscontainer_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_eventscontainer
            @eventscontainer
        end

        def [](index)
            @eventscontainer[index]
        end

        def []=(index, arg)
            is_megam_eventsvm(arg)
            @eventscontainer[index] = arg
            @eventscontainer_by_name[arg.account_id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_events(a)
                @eventscontainer << a
                @eventscontainer_by_name[a.account_id] = @eventscontainer.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(eventscontainer)
            is_megam_eventscontainer(eventscontainer)
            if @insert_after_idx
                # in the middle of executing a run, so any nodes inserted now should
                # be placed after the most recent addition done by the currently executing
                # node
                @eventscontainer.insert(@insert_after_idx + 1, eventscontainer)
                # update name -> location mappings and register new node
                @eventscontainer_by_name.each_key do |key|
                    @eventscontainer_by_name[key] += 1 if @eventscontainer_by_name[key] > @insert_after_idx
                end
                @eventscontainer_by_name[eventscontainer.account_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @eventscontainer << eventscontainer
                @eventscontainer_by_name[eventscontainer.account_id] = @eventscontainer.length - 1
            end
        end

        def each
            @eventscontainer.each do |eventscontainer|
                yield eventscontainer
            end
        end

        def each_index
            @eventscontainer.each_index do |i|
                yield i
            end
        end

        def empty?
            @eventscontainer.empty?
        end

        def lookup(eventscontainer)
            lookup_by = nil
            if events.kind_of?(Megam::EventsContainer)
                lookup_by = eventscontainer.account_id
            elsif eventscontainer.kind_of?(String)
                lookup_by = eventscontainer
            else
                raise ArgumentError, "Must pass a Megam::EventsContainer or String to lookup"
            end
            res = @eventscontainer_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
            end
            @eventscontainer[res]
        end

        def to_s
            @eventscontainer.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |eventscontainer_list|
                eventscontainer_array = eventscontainer_list.kind_of?(Array) ? eventscontainer_list : [ eventscontainer_list ]
                eventscontainer_array.each do |eventscontainer|
                    collection.insert(eventscontainer)

                end
            end
            collection
        end

        private

        def is_megam_eventscontainer(arg)
            unless arg.kind_of?(Megam::EventsContainer)
                raise ArgumentError, "Members must be Megam::EventsContainer's"
            end
            true
        end
    end
end
