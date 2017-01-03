module Megam
    class CreditCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @credit = Array.new
            @credit_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_credit
            @credit
        end

        def [](index)
            @credit[index]
        end

        def []=(index, arg)
            is_megam_credit(arg)
            @credit[index] = arg
            @credit_by_name[arg.id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_credit(a)
                @credit << a
                @credit_by_name[a.id] =@credit.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(credit)
            is_megam_credit(credit)
            if @insert_after_idx
                # in the middle of executing a run, so any predefs inserted now should
                # be placed after the most recent addition done by the currently executing
                # credit
                @credit.insert(@insert_after_idx + 1, credit)
                # update id -> location mappings and register new credit
                @credit_by_name.each_key do |key|
                    @credit_by_name[key] += 1 if@credit_by_name[key] > @insert_after_idx
                end
                @credit_by_name[credit.account_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @credit << credit
                @credit_by_name[credit.account_id] =@credit.length - 1
            end
        end

        def each
            @credit.each do |credit|
                yield credit
            end
        end

        def each_index
            @credit.each_index do |i|
                yield i
            end
        end

        def empty?
            @credit.empty?
        end

        def lookup(credit)
            lookup_by = nil
            if credit.kind_of?(Megam::Credit)
                lookup_by = credit.account_id
            elsif credit.kind_of?(String)
                lookup_by = credit
            else
                raise ArgumentError, "Must pass a Megam::Credit or String to lookup"
            end
            res =@credit_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a credit matching #{lookup_by} (did you define it first?)"
            end
            @credit[res]
        end

        def to_s
            @credit.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |credit_list|
                credit_array = credit_list.kind_of?(Array) ? credit_list : [ credit_list ]
                credit_array.each do |credit|
                    collection.insert(credit)
                end
            end
            collection
        end

        private

        def is_megam_credit(arg)
            unless arg.kind_of?(Megam::Credit)
                raise ArgumentError, "Members must be Megam::credit's"
            end
            true
        end
    end
end
