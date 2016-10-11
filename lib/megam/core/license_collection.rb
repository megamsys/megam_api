module Megam
    class LicenseCollection
        include Enumerable

        attr_reader :iterator

        def initialize
            @license = Array.new
            @license_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_license
            @license
        end

        def [](index)
            @license[index]
        end

        def []=(index, arg)
            is_megam_license(arg)
            @license[index] = arg
            @license_by_name[arg.name] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_license(a)
                @license << a
                @license_by_name[a.name] =@license.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(license)
            is_megam_license(license)
            if @insert_after_idx
                # in the middle of executing a run, so any license inserted now should
                # be placed after the most recent addition done by the currently executing
                # license
                @license.insert(@insert_after_idx + 1, license)
                # update name -> location mappings and register new license
                @license_by_name.each_key do |key|
                    @license_by_name[key] += 1 if@license_by_name[key] > @insert_after_idx
                end
                @license_by_name[license.name] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @license << license
                @license_by_name[license.name] =@license.length - 1
            end
        end

        def each
            @license.each do |license|
                yield license
            end
        end

        def each_index
            @license.each_index do |i|
                yield i
            end
        end

        def empty?
            @license.empty?
        end

        def lookup(license)
            lookup_by = nil
            if license.kind_of?(Megam::License)
                lookup_by = license.name
            elsif license.kind_of?(String)
                lookup_by = license
            else
                raise ArgumentError, "Must pass a Megam::license or String to lookup"
            end
            res =@license_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a license matching #{lookup_by} (did you define it first?)"
            end
            @license[res]
        end

        def to_s
            @license.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |license_list|
                license_array = license_list.kind_of?(Array) ? license_list : [ license_list ]
                license_array.each do |license|
                    collection.insert(license)
                end
            end
            collection
        end

        private

        def is_megam_license(arg)
            unless arg.kind_of?(Megam::License)
                raise ArgumentError, "Members must be Megam::License's"
            end
            true
        end
    end
end
