##
## Copyright 2013-2016 Megam Systems
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
module Megam
    class BillingtransactionsCollection
        include Enumerable

        attr_reader :iterator
        def initialize
            @billingtransactions = Array.new
            @billingtransactions_by_name = Hash.new
            @insert_after_idx = nil
        end

        def all_billingtransactions
            @billingtransactions
        end

        def [](index)
            @billingtransactions[index]
        end

        def []=(index, arg)
            is_megam_billingtransactions(arg)
            @@billingtransactions[index] = arg
            @billingtransactions_by_name[arg.accounts_id] = index
        end

        def <<(*args)
            args.flatten.each do |a|
                is_megam_billingtransactions(a)
                @billingtransactions << a
                @billingtransactions_by_name[a.accounts_id] =@billingtransactions.length - 1
            end
            self
        end

        # 'push' is an alias method to <<
        alias_method :push, :<<

        def insert(billingtransactions)
            is_megam_billingtransactions(billingtransactions)
            if @insert_after_idx
                # in the middle of executing a run, so any predefs inserted now should
                # be placed after the most recent addition done by the currently executing
                #
                @billingtransactions.insert(@insert_after_idx + 1,billingtransactions)
                # update name -> location mappings and register new
                @billingtransactions_by_name.each_key do |key|
                    @billingtransactions_by_name[key] += 1 if@billingtransactions_by_name[key] > @insert_after_idx
                end
                @billingtransactions_by_name[billingtransactions.accounts_id] = @insert_after_idx + 1
                @insert_after_idx += 1
            else
                @billingtransactions << billingtransactions
                @billingtransactions_by_name[billingtransactions.accounts_id] =@billingtransactions.length - 1
            end
        end

        def each
            @billingtransactions.each do |billingtransactions|
                yield billingtransactions
            end
        end

        def each_index
            @billingtransactions.each_index do |i|
                yield i
            end
        end

        def empty?
            @billingtransactions.empty?
        end

        def lookup(billingtransactions)
            lookup_by = nil
            if billingtransactions.kind_of?(Megam::Billingtransactions)
                lookup_by = billingtransactions.accounts_id
            elsif billingtransactions.kind_of?(String)
                lookup_by = billingtransactions
            else
                raise ArgumentError, "Must pass a Megam::Billingtransactions or String to lookup"
            end
            res =@billingtransactions_by_name[lookup_by]
            unless res
                raise ArgumentError, "Cannot find a  matching #{lookup_by} (did you define it first?)"
            end
            @billingtransactions[res]
        end

        def to_s
            @billingtransactions.join(", ")
        end

        def for_json
            to_a.map { |item| item.to_s }
        end

        def to_json(*a)
            Megam::JSONCompat.to_json(for_json, *a)
        end

        def self.json_create(o)
            collection = self.new()
            o["results"].each do |billingtransactions_list|
                billingtransactions_array = billingtransactions_list.kind_of?(Array) ? billingtransactions_list : [ billingtransactions_list ]
                billingtransactions_array.each do |billingtransactions|
                    collection.insert(billingtransactions)
                end
            end
            collection
        end

        private

        def is_megam_billingtransactions(arg)
            unless arg.kind_of?(Megam::Billingtransactions)
                raise ArgumentError, "Members must be Megam::Billingtransactions's"
            end
            true
        end

    end
end
