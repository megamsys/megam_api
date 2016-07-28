module Megam
    class EventsBillingCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @eventsbilling = Array.new
            @eventsbilling_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_eventsbilling
            @eventsbilling
        end

        def [](index)
            @eventsbilling[index]
        end

        def []=(index, arg)
            is_megam_eventsbilling(arg)
            @eventsbilling[index] = arg
            @eventsbilling_by_name[arg.account_id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_events(a)
                @eventsbilling << a
                @eventsbilling_by_name[a.account_id] = @eventsbilling.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(eventsbilling)
            is_megam_eventsbilling(eventsbilling)
            if @insert_after_idx
                # in the middle of executing a run, so any nodes inserted now should
                # be placed after the most recent addition done by the currently executing
                # node
                @eventsbilling.insert(@insert_after_idx + 1, eventsbilling)
                # update name -> location mappings and register new node
                @eventsbilling_by_name.each_key do |key|
                    @eventsbilling_by_name[key] += 1 if @eventsbilling_by_name[key] > @insert_after_idx
                end
                @eventsbilling_by_name[eventsbilling.account_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @eventsbilling << eventsbilling
                @eventsbilling_by_name[eventsbilling.account_id] = @eventsbilling.length - 1
            end
        end

        def each
            @eventsbilling.each do |eventsbilling|
                yield eventsbilling
            end
        end

        def each_index
            @eventsbilling.each_index do |i|
                yield i
            end
        end

        def empty?
            @eventsbilling.empty?
        end

        def lookup(eventsbilling)
            lookup_by = nil
            if events.kind_of?(Megam::EventsBilling)
                lookup_by = eventsbilling.account_id
            elsif events.kind_of?(String)
                lookup_by = eventsbilling
            else
                raise ArgumentError, "Must pass a Megam::EventsBilling or String to lookup"
            end
            res = @eventsbilling_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
            end
            @eventsbilling[res]
        end

        def to_s
            @eventsbilling.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |eventsbilling_list|
                eventsbilling_array = eventsbilling_list.kind_of?(Array) ? eventsbilling_list : [ eventsbilling_list ]
                eventsbilling_array.each do |eventsbilling|
                    collection.insert(eventsbilling)

                end
            end
            collection
        end

        private

        def is_megam_eventsbilling(arg)
            unless arg.kind_of?(Megam::EventsBilling)
                raise ArgumentError, "Members must be Megam::EventsBilling's"
            end
            true
        end
    end
end
