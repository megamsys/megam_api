module Megam
    module Stuff
        extend self
        def has_git?
            %x{ git --version }
            $?.success?
        end

        def git(args)
            return "" unless has_git?
            flattened_args = [args].flatten.compact.join(" ")
            %x{ git #{flattened_args} 2>&1 }.strip
        end

        #
        #left justified keyed hash with newlines.
        def styled_hash(hash)
            hash.map{|k,v| "#{k.ljust(15)}=#{v}"}.join("\n")
        end

    end
end
