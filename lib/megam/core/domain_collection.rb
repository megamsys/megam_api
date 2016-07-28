module Megam
    class DomainsCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @domains = Array.new
            @domains_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_domains
            @domains
        end

        def [](index)
            @domains[index]
        end

        def []=(index, arg)
            is_megam_domains(arg)
            @domains[index] = arg
            @domains_by_name[arg.name] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_domains(a)
                @domains << a
                @domains_by_name[a.name] =@domains.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(domains)
            is_megam_domains(domains)
            if @insert_after_idx
                # in the middle of executing a run, so any domain inserted now should
                # be placed after the most recent addition done by the currently executing
                # domain
                @domains.insert(@insert_after_idx + 1, domains)
                # update name -> location mappings and register new sshkeys
                @domains_by_name.each_key do |key|
                    @domains_by_name[key] += 1 if@domains_by_name[key] > @insert_after_idx
                end
                @domains_by_name[domains.name] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @domains << domains
                @domains_by_name[domains.name] =@domains.length - 1
            end
        end

        def each
            @domains.each do |domains|
                yield domains
            end
        end

        def each_index
            @domains.each_index do |i|
                yield i
            end
        end

        def empty?
            @domains.empty?
        end

        def lookup(domains)
            lookup_by = nil
            if domains.kind_of?(Megam::Domains)
                lookup_by = domains.name
            elsif domains.kind_of?(String)
                lookup_by = domains
            else
                raise ArgumentError, "Must pass a Megam::Domains or String to lookup"
            end
            res =@domains_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a domain matching #{lookup_by} (did you define it first?)"
            end
            @domains[res]
        end


        def to_s
            @domains.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |domains_list|
                domains_array = domains_list.kind_of?(Array) ? domains_list : [ domains_list ]
                domains_array.each do |domains|
                    collection.insert(domains)
                end
            end
            collection
        end

        private

        def is_megam_domains(arg)
            unless arg.kind_of?(Megam::Domains)
                raise ArgumentError, "Members must be Megam::Domains's"
            end
            true
        end
    end
end
