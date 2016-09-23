module Megam
    class EventsAllCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @eventsall = Array.new
            @eventsall_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_eventsall
            @eventsall
        end

        def [](index)
            @eventsall[index]
        end

        def []=(index, arg)
            is_megam_eventsall(arg)
            @eventsall[index] = arg
            @eventsall_by_name[arg.account_id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_events(a)
                @eventsall << a
                @eventsall_by_name[a.account_id] = @eventsall.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(eventsall)
            is_megam_eventsall(eventsall)
            if @insert_after_idx
                # in the middle of executing a run, so any nodes inserted now should
                # be placed after the most recent addition done by the currently executing
                # node
                @eventsall.insert(@insert_after_idx + 1, eventsall)
                # update name -> location mappings and register new node
                @eventsall_by_name.each_key do |key|
                    @eventsall_by_name[key] += 1 if @eventsall_by_name[key] > @insert_after_idx
                end
                @eventsall_by_name[eventsall.account_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @eventsall << eventsall
                @eventsall_by_name[eventsall.account_id] = @eventsall.length - 1
            end
        end

        def each
            @eventsall.each do |eventsall|
                yield eventsall
            end
        end

        def each_index
            @eventsall.each_index do |i|
                yield i
            end
        end

        def empty?
            @eventsall.empty?
        end

        def lookup(eventsall)
            lookup_by = nil
            if events.kind_of?(Megam::EventsAll)
                lookup_by = eventsall.account_id
            elsif events.kind_of?(String)
                lookup_by = eventsall
            else
                raise ArgumentError, "Must pass a Megam::EventsAll or String to lookup"
            end
            res = @eventsall_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
            end
            @eventsall[res]
        end

        def to_s
            @eventsall.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |eventsall_list|
                eventsall_array = eventsall_list.kind_of?(Array) ? eventsall_list : [ eventsall_list ]
                eventsall_array.each do |eventsall|
                    collection.insert(eventsall)

                end
            end
            collection
        end

        private

        def is_megam_eventsall(arg)
            unless arg.kind_of?(Megam::EventsAll)
                raise ArgumentError, "Members must be Megam::EventsAll's"
            end
            true
        end
    end
end
