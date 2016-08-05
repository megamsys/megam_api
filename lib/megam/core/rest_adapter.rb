module Megam
    class RestAdapter
        attr_reader :email
        attr_reader :api_key
        attr_reader :host
        # the name :password is used as attr_accessor in accounts,
        # hence we use gpassword
        attr_reader :gpassword
        attr_reader :org_id
        attr_reader :headers


        ## clean up this module later.
        def initialize(o)
            @email = o[:email]
            @api_key = o[:api_key] || nil
            @host = o[:host]
            @gpassword = o[:password] || nil
            @org_id = o[:org_id]
            @headers = o[:headers]
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
              :password => gpassword,
              :host => host
            }
            if headers
              options[:headers] = headers
            end
            Megam::API.new(options)
        end
    end
end
