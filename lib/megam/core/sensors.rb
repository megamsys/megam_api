module Megam
    class Sensors < Megam::RestAdapter
        def initialize(email = nil, api_key = nil, host = nil)
            @id = nil
            @sensor_type = nil
            @payload = {}
            @created_at = nil
            super(email, api_key, host)
        end

        def sensors
            self
        end

        def id(arg = nil)
            if !arg.nil?
                @id = arg
            else
                @id
            end
        end

        def sensor_type(arg = nil)
            if !arg.nil?
                @sensor_type = arg
            else
                @sensor_type
            end
        end

        def payload(arg = nil)
            if !arg.nil?
                @payload = arg
            else
                @payload
            end
        end

        def created_at(arg = nil)
            if !arg.nil?
                @created_at = arg
            else
                @created_at
            end
        end

        def error?
            crocked = true if some_msg.key?(:msg_type) && some_msg[:msg_type] == 'error'
        end

        # Transform the ruby obj ->  to a Hash
        def to_hash
            index_hash = {}
            index_hash['json_claz'] = self.class.name
            index_hash['id'] = id

            index_hash['sensor_type'] = sensor_type
            index_hash['payload'] = payload
            index_hash['created_at'] = created_at
            index_hash
        end

        # Serialize this object as a hash: called from JsonCompat.
        # Verify if this called from JsonCompat during testing.
        def to_json(*a)
            for_json.to_json(*a)
        end

        def for_json
            result = {
                'id' => id,
                'sensor_type' => sensor_type,
                'payload' => payload,
                'created_at' => created_at
            }
            result
        end

        def self.json_create(o)
            asm = new
            asm.id(o['id']) if o.key?('id')
            asm.sensor_type(o['sensor_type']) if o.key?('sensor_type')
            asm.payload(o['payload']) if o.key?('payload')
            asm.created_at(o['created_at']) if o.key?('created_at')
            asm
        end

        def self.from_hash(o, tmp_email = nil, tmp_api_key = nil, tmp_host = nil)
            asm = new(tmp_email, tmp_api_key, tmp_host)
            asm.from_hash(o)
            asm
        end

        def from_hash(o)
            @id = o['id'] if o.key?('id')
            @sensor_type = o['sensor_type'] if o.key?('sensor_type')
            @payload = o['payload'] if o.key?('payload')
            @created_at = o['created_at'] if o.key?('created_at')
            self
        end

        def self.create(params)
            sensors = from_hash(params, params['email'], params['api_key'], params['host'])
            sensors.create
        end

        # Load a account by email_p
        def self.show(params)
            sensors = new(params['email'], params['api_key'], params['host'])
            sensors.megam_rest.get_sensor(params['id'])
        end

        def self.list(params)
            sensors = self.new(params["email"], params["api_key"], params["host"])
            sensors.megam_rest.get_sensors
        end

        def self.update(params)
            sensors = from_hash(params, params['email'] || params[:email], params['api_key'] || params[:api_key], params['host'] || params[:host])
            sensors.update
        end

        def self.list(o)
            app = self.new(o["email"], o["api_key"], o["host"])
            app.megam_rest.get_sensors
        end

        # Create the node via the REST API
        def update
            megam_rest.update_(to_hash)
        end

        def create
            megam_rest.post_sensors(to_hash)
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
        end
    end
end
