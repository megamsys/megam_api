module Megam
    class CreditsCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @credits = Array.new
            @credits_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_credits
            @credits
        end

        def [](index)
            @credits[index]
        end

        def []=(index, arg)
            is_megam_credits(arg)
            @credits[index] = arg
            @credits_by_name[arg.id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_credits(a)
                @credits << a
                @credits_by_name[a.id] =@credits.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(credits)
            is_megam_credits(credits)
            if @insert_after_idx
                # in the middle of executing a run, so any predefs inserted now should
                # be placed after the most recent addition done by the currently executing
                # credit
                @credits.insert(@insert_after_idx + 1, credits)
                # update id -> location mappings and register new credit
                @credits_by_name.each_key do |key|
                    @credits_by_name[key] += 1 if@credits_by_name[key] > @insert_after_idx
                end
                @credits_by_name[credits.account_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @credits << credits
                @credits_by_name[credits.account_id] =@credits.length - 1
            end
        end

        def each
            @credits.each do |credits|
                yield credits
            end
        end

        def each_index
            @credits.each_index do |i|
                yield i
            end
        end

        def empty?
            @credits.empty?
        end

        def lookup(credits)
            lookup_by = nil
            if credits.kind_of?(Megam::Credits)
                lookup_by = credits.account_id
            elsif credits.kind_of?(String)
                lookup_by = credits
            else
                raise ArgumentError, "Must pass a Megam::Credits or String to lookup"
            end
            res =@credits_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a credits matching #{lookup_by} (did you define it first?)"
            end
            @credits[res]
        end

        def to_s
            @credits.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |credits_list|
                credits_array = credits_list.kind_of?(Array) ? credits_list : [ credits_list ]
                credits_array.each do |credits|
                    collection.insert(credits)
                end
            end
            collection
        end

        private

        def is_megam_credits(arg)
            unless arg.kind_of?(Megam::Credits)
                raise ArgumentError, "Members must be Megam::credits's"
            end
            true
        end
    end
end
