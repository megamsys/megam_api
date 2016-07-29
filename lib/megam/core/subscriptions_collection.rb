module Megam
    class SubscriptionsCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @subscriptions = Array.new
            @subscriptions_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_subscriptions
            @subscriptions
        end

        def [](index)
            @subscriptions[index]
        end

        def []=(index, arg)
            is_megam_subscriptions(arg)
            @subscriptions[index] = arg
            @subscriptions_by_name[arg.account_id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_subscriptions(a)
                @subscriptions << a
                @subscriptions_by_name[a.account_id] =@subscriptions.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(subscriptions)
            is_megam_subscriptions(subscriptions)
            if @insert_after_idx
                # in the middle of executing a run, so any predefs inserted now should
                # be placed after the most recent addition done by the currently executing
                # subscriptions
                @subscriptions.insert(@insert_after_idx + 1, subscriptions)
                # update name -> location mappings and register new subscriptions
                @subscriptions_by_name.each_key do |key|
                    @subscriptions_by_name[key] += 1 if@subscriptions_by_name[key] > @insert_after_idx
                end
                @subscriptions_by_name[subscriptions.account_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @subscriptions << subscriptions
                @subscriptions_by_name[subscriptions.account_id] =@subscriptions.length - 1
            end
        end

        def each
            @subscriptions.each do |subscriptions|
                yield subscriptions
            end
        end

        def each_index
            @subscriptions.each_index do |i|
                yield i
            end
        end

        def empty?
            @subscriptions.empty?
        end

        def lookup(subscriptions)
            lookup_by = nil
            if Subscriptions.kind_of?(Megam::Subscriptions)
                lookup_by = subscriptions.account_id
            elsif subscriptions.kind_of?(String)
                lookup_by = subscriptions
            else
                raise ArgumentError, "Must pass a Megam::Subscriptions or String to lookup"
            end
            res =@subscriptions_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a subscriptions matching #{lookup_by} (did you define it first?)"
            end
            @subscriptions[res]
        end

        def to_s
            @subscriptions.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |subscriptions_list|
                subscriptions_array = subscriptions_list.kind_of?(Array) ? subscriptions_list : [ subscriptions_list ]
                subscriptions_array.each do |subscriptions|
                    collection.insert(subscriptions)
                end
            end
            collection
        end

        private

        def is_megam_subscriptions(arg)
            unless arg.kind_of?(Megam::Subscriptions)
                raise ArgumentError, "Members must be Megam::subscriptions's"
            end
            true
        end
    end
end
