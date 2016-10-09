module Megam
    class AssembliesCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @accounts = Array.new
            @accounts_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_accounts
            @accounts
        end

        def [](index)
            @accounts[index]
        end

        def []=(index, arg)
            is_megam_accounts(arg)
            @accounts[index] = arg
            @accounts_by_name[arg.assembies_name] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_accounts(a)
                @accounts << a
                @accounts_by_name[a.name] = @accounts.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(accounts)
            is_megam_accounts(accounts)
            if @insert_after_idx
                # in the middle of executing a run, so any nodes inserted now should
                # be placed after the most recent addition done by the currently executing
                # node
                @accounts.insert(@insert_after_idx + 1, accounts)
                # update name -> location mappings and register new node
                @accounts_by_name.each_key do |key|
                    @accounts_by_name[key] += 1 if @accounts_by_name[key] > @insert_after_idx
                end
                @accounts_by_name[accounts.name] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @accounts << accounts
                @accounts_by_name[accounts.name] = @accounts.length - 1
            end
        end

        def each
            @accounts.each do |accounts|
                yield accounts
            end
        end

        def each_index
            @accounts.each_index do |i|
                yield i
            end
        end

        def empty?
            @accounts.empty?
        end

        def lookup(accounts)
            lookup_by = nil
            if accounts.kind_of?(Megam::Account)
                lookup_by = accounts.name
            elsif accounts.kind_of?(String)
                lookup_by = accounts
            else
                raise ArgumentError, "Must pass a Megam::Account or String to lookup"
            end
            res = @accounts_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a node matching #{lookup_by} (did you define it first?)"
            end
            @accounts[res]
        end

        def to_s
            @accounts.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |accounts_list|
                accounts_array = accounts_list.kind_of?(Array) ? accounts_list : [ accounts_list ]
                accounts_array.each do |accounts|
                    collection.insert(accounts)

                end
            end
            collection
        end

        private

        def is_megam_accounts(arg)
            unless arg.kind_of?(Megam::Account)
                raise ArgumentError, "Members must be Megam::Account's"
            end
            true
        end
    end
end
