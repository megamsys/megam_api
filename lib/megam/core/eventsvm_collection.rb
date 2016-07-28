module Megam
    class EventsVmCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @eventsvm = Array.new
            @eventsvm_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_eventsvm
            @eventsvm
        end

        def [](index)
            @eventsvm[index]
        end

        def []=(index, arg)
            is_megam_eventsvm(arg)
            @eventsvm[index] = arg
            @eventsvm_by_name[arg.account_id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_events(a)
                @eventsvm << a
                @eventsvm_by_name[a.account_id] = @eventsvm.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(eventsvm)
            is_megam_eventsvm(eventsvm)
            if @insert_after_idx
                # in the middle of executing a run, so any nodes inserted now should
                # be placed after the most recent addition done by the currently executing
                # node
                @eventsvm.insert(@insert_after_idx + 1, eventsvm)
                # update name -> location mappings and register new node
                @eventsvm_by_name.each_key do |key|
                    @eventsvm_by_name[key] += 1 if @eventsvm_by_name[key] > @insert_after_idx
                end
                @eventsvm_by_name[eventsvm.account_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @eventsvm << eventsvm
                @eventsvm_by_name[eventsvm.account_id] = @eventsvm.length - 1
            end
        end

        def each
            @eventsvm.each do |eventsvm|
                yield eventsvm
            end
        end

        def each_index
            @eventsvm.each_index do |i|
                yield i
            end
        end

        def empty?
            @eventsvm.empty?
        end

        def lookup(eventsvm)
            lookup_by = nil
            if events.kind_of?(Megam::EventsVm)
                lookup_by = eventsvm.account_id
            elsif events.kind_of?(String)
                lookup_by = eventsvm
            else
                raise ArgumentError, "Must pass a Megam::EventsVm or String to lookup"
            end
            res = @eventsvm_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
            end
            @eventsvm[res]
        end

        def to_s
            @eventsvm.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |eventsvm_list|
                eventsvm_array = eventsvm_list.kind_of?(Array) ? eventsvm_list : [ eventsvm_list ]
                eventsvm_array.each do |eventsvm|
                    collection.insert(eventsvm)

                end
            end
            collection
        end

        private

        def is_megam_eventsvm(arg)
            unless arg.kind_of?(Megam::EventsVm)
                raise ArgumentError, "Members must be Megam::EventsVm's"
            end
            true
        end
    end
end
