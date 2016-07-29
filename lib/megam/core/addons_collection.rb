module Megam
    class AddonsCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @addons = Array.new
            @addons_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_addons
            @addons
        end

        def [](index)
            @addons[index]
        end

        def []=(index, arg)
            is_megam_addons(arg)
            @addons[index] = arg
            @addons_by_name[arg.account_id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_addons(a)
                @addons << a
                @addons_by_name[a.account_id] =@addons.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(addons)
            is_megam_addons(addons)
            if @insert_after_idx
                # in the middle of executing a run, so any predefs inserted now should
                # be placed after the most recent addition done by the currently executing
                # addons
                @addons.insert(@insert_after_idx + 1, addons)
                # update name -> location mappings and register new addons
                @addons_by_name.each_key do |key|
                    @addons_by_name[key] += 1 if@addons_by_name[key] > @insert_after_idx
                end
                @addons_by_name[addons.account_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @addons << addons
                @addons_by_name[addons.account_id] =@addons.length - 1
            end
        end

        def each
            @addons.each do |addons|
                yield addons
            end
        end

        def each_index
            @addons.each_index do |i|
                yield i
            end
        end

        def empty?
            @addons.empty?
        end

        def lookup(addons)
            lookup_by = nil
            if Addons.kind_of?(Megam::Addons)
                lookup_by = addons.account_id
            elsif addons.kind_of?(String)
                lookup_by = addons
            else
                raise ArgumentError, "Must pass a Megam::Addons or String to lookup"
            end
            res =@addons_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a addons matching #{lookup_by} (did you define it first?)"
            end
            @addons[res]
        end

        def to_s
            @addons.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |addons_list|
                addons_array = addons_list.kind_of?(Array) ? addons_list : [ addons_list ]
                addons_array.each do |addons|
                    collection.insert(addons)
                end
            end
            collection
        end

        private

        def is_megam_addons(arg)
            unless arg.kind_of?(Megam::Addons)
                raise ArgumentError, "Members must be Megam::addons's"
            end
            true
        end
    end
end
