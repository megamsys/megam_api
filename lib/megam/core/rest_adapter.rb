module Megam
    class RestAdapter
        attr_reader :email
        attr_reader :api_key
        attr_reader :host
        # the name :password is used as attr_accessor in accounts,
        # hence we use gpassword
        attr_reader :password_hash
        attr_reader :master_key
        attr_reader :org_id
        attr_reader :headers


        ## clean up this module later.
        def initialize(o)
            @email            = o[:email]
            @api_key          = o[:api_key] || nil
            @master_key       = o[:master_key] || nil
            @host             = o[:host]
            @password_hash    = o[:password_hash] || nil
            @org_id           = o[:org_id]
            @headers          = o[:headers]
        end

        # Build a megam api client
        #
        # === Parameters
        # api:: The Megam::API client
        def megam_rest
            options = {
              :email => email,
              :api_key => api_key,
              :org_id => org_id,
              :password_hash => password_hash,
              :master_key => master_key
              :host => host
            }
            if headers
              options[:headers] = headers
            end
            Megam::API.new(options)
        end
    end
end
