module Megam
    class BilledhistoriesCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @billedhistories = Array.new
            @billedhistories_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_billedhistories
            @billedhistories
        end

        def [](index)
            @billedhistories[index]
        end

        def []=(index, arg)
            is_megam_billedhistories(arg)
            @billedhistories[index] = arg
            @billedhistories_by_name[arg.accounts_id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_billedhistories(a)
                @billedhistories << a
                @billedhistories_by_name[a.accounts_id] =@billedhistories.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(billedhistories)
            is_megam_billedhistories(billedhistories)
            if @insert_after_idx
                # in the middle of executing a run, so any predefs inserted now should
                # be placed after the most recent addition done by the currently executing
                # billedhistories
                @billedhistories.insert(@insert_after_idx + 1, billedhistories)
                # update name -> location mappings and register new billedhistories
                @billedhistories_by_name.each_key do |key|
                    @billedhistories_by_name[key] += 1 if@billedhistories_by_name[key] > @insert_after_idx
                end
                @billedhistories_by_name[billedhistories.accounts_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @billedhistories << billedhistories
                @billedhistories_by_name[billedhistories.accounts_id] =@billedhistories.length - 1
            end
        end

        def each
            @billedhistories.each do |billedhistories|
                yield billedhistories
            end
        end

        def each_index
            @billedhistories.each_index do |i|
                yield i
            end
        end

        def empty?
            @billedhistories.empty?
        end

        def lookup(billedhistories)
            lookup_by = nil
            if Billedhistories.kind_of?(Megam::Billedhistories)
                lookup_by = billedhistories.accounts_id
            elsif billedhistories.kind_of?(String)
                lookup_by = billedhistories
            else
                raise ArgumentError, "Must pass a Megam::billedhistories or String to lookup"
            end
            res =@billedhistories_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a billedhistories matching #{lookup_by} (did you define it first?)"
            end
            @billedhistories[res]
        end

        def to_s
            @billedhistories.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |billedhistories_list|
                billedhistories_array = billedhistories_list.kind_of?(Array) ? billedhistories_list : [ billedhistories_list ]
                billedhistories_array.each do |billedhistories|
                    collection.insert(billedhistories)
                end
            end
            collection
        end

        private

        def is_megam_billedhistories(arg)
            unless arg.kind_of?(Megam::Billedhistories)
                raise ArgumentError, "Members must be Megam::billedhistories's"
            end
            true
        end
    end
end
