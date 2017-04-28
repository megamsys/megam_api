module Megam
    class API
        # GET /nodes
        def list_backups
            @options = {:path => "/backups",:body => ""}.merge(@options)

            request(
                :expects  => 200,
                :method   => :get,
                :body     => @options[:body]
            )
        end

        def get_backups(asm_id)
            @options = {:path => "/backups/#{asm_id}",:body => ""}.merge(@options)

            request(
                :expects  => 200,
                :method   => :get,
                :body     => @options[:body]
            )
        end

        def get_one_backup(backup_id)
            @options = {:path => "/backups/show/#{backup_id}",:body => ""}.merge(@options)

            request(
                :expects  => 200,
                :method   => :get,
                :body     => @options[:body]
            )
        end

        def post_backups(new_sps)
            @options = {:path => '/backups/content',
            :body => Megam::JSONCompat.to_json(new_sps)}.merge(@options)

            request(
                :expects  => 201,
                :method   => :post,
                :body     => @options[:body]
            )
        end

        def update_backups(update_sps)
            @options = {:path => '/backups/update',
            :body => Megam::JSONCompat.to_json(update_sps)}.merge(@options)

            request(
                :expects  => 201,
                :method   => :post,
                :body     => @options[:body]
            )
        end

    end
end
