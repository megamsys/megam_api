require 'base64'
require 'time'
require 'excon'
require 'uri'
require 'zlib'
require 'openssl'

__LIB_DIR__ = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(__LIB_DIR__) unless $LOAD_PATH.include?(__LIB_DIR__)

require 'megam/api/accounts'
require 'megam/api/assemblies'
require 'megam/api/assembly'
require 'megam/api/balances'
require 'megam/api/billedhistories'
require 'megam/api/billingtransactions'
require 'megam/api/components'
require 'megam/api/domains'
require 'megam/api/errors'
require 'megam/api/marketplaces'
require 'megam/api/organizations'
require 'megam/api/promos'
require 'megam/api/requests'
require 'megam/api/sensors'
require 'megam/api/sshkeys'
require 'megam/api/eventsvm'
require 'megam/api/eventscontainer'
require 'megam/api/eventsbilling'
require 'megam/api/eventsstorage'
require 'megam/api/snapshots'
require 'megam/api/disks'
require 'megam/api/subscriptions'
require 'megam/api/addons'
require 'megam/api/version'

require 'megam/mixins/assemblies'
require 'megam/mixins/assembly'
require 'megam/mixins/common_deployable'
require 'megam/mixins/components'
require 'megam/mixins/megam_attributes'
require 'megam/mixins/outputs'
require 'megam/mixins/policies'

require 'megam/core/rest_adapter'
require 'megam/core/stuff'
require 'megam/core/text'
require 'megam/core/log'
require 'megam/core/json_compat'
require 'megam/core/error'
require 'megam/core/account'
require 'megam/core/request'
require 'megam/core/request_collection'
require 'megam/core/sshkey'
require 'megam/core/sshkey_collection'
require 'megam/core/eventsvm'
require 'megam/core/eventsvm_collection'
require 'megam/core/eventscontainer'
require 'megam/core/eventscontainer_collection'
require 'megam/core/eventsbilling'
require 'megam/core/eventsbilling_collection'
require 'megam/core/eventsstorage'
require 'megam/core/eventsstorage_collection'
require 'megam/core/marketplace'
require 'megam/core/marketplace_collection'
require 'megam/core/organizations'
require 'megam/core/organizations_collection'
require 'megam/core/domains'
require 'megam/core/domain_collection'
require 'megam/core/assemblies'
require 'megam/core/assemblies_collection'
require 'megam/core/konipai'
require 'megam/core/assembly'
require 'megam/core/assembly_collection'
require 'megam/core/components'
require 'megam/core/components_collection'
require 'megam/core/sensors'
require 'megam/core/sensors_collection'
require 'megam/core/snapshots'
require 'megam/core/snapshots_collection'
require 'megam/core/disks'
require 'megam/core/disks_collection'
require 'megam/core/balances_collection'
require 'megam/core/balances'
require 'megam/core/billedhistories_collection'
require 'megam/core/billedhistories'
require 'megam/core/billingtransactions_collection'
require 'megam/core/billingtransactions'
require 'megam/core/subscriptions_collection'
require 'megam/core/subscriptions'
require 'megam/core/addons_collection'
require 'megam/core/addons'
require 'megam/core/promos'

module Megam
    class API
        attr_accessor :text
        attr_accessor :email, :api_key, :password_hash, :org_id
        attr_accessor :api_url, :api_version
        attr_reader   :last_response
 
        API_VERSION2      = '/v2'.freeze

        X_Megam_DATE      = 'X-Megam-DATE'.freeze
        X_Megam_HMAC      = 'X-Megam-HMAC'.freeze
        X_Megam_OTTAI     = 'X-Megam-OTTAI'.freeze
        X_Megam_ORG       = 'X-Megam-ORG'.freeze
        X_Megam_PUTTUSAVI = 'X-Megam-PUTTUSAVI'.freeze

        HEADERS = {
            'Accept'          => 'application/json',
            'Accept-Encoding' => 'gzip',
            'User-Agent'      => "megam-api/#{Megam::API::VERSION}",
            'X-Ruby-Version'  => RUBY_VERSION,
            'X-Ruby-Platform' => RUBY_PLATFORM
        }

        OPTIONS = {
            headers: {},
            nonblock: false
        }

        def initialize(options = {})
            @options = OPTIONS.merge(options)
            
            assign_credentials
            
            ensure_host_is_flattened

            ensure_authkeys unless is_passthru?
            
            turn_off_ssl_verify
        end
        
        
        def text
            @text ||= Megam::Text.new(STDOUT, STDERR, STDIN, {})
        end

        def request(params, &block)
            just_color_debug("#{@options[:path]}")
            start = Time.now
            Megam::Log.debug('START')
        
            begin
                response = connection.request(params, &block)
            rescue Excon::Errors::HTTPStatusError => error
                klass = case error.response.status

                when 401 then Megam::API::Errors::Unauthorized
                when 403 then Megam::API::Errors::Forbidden
                when 404 then Megam::API::Errors::NotFound
                when 408 then Megam::API::Errors::Timeout
                when 422 then Megam::API::Errors::RequestFailed
                when 423 then Megam::API::Errors::Locked
                when /50./ then Megam::API::Errors::RequestFailed
                else Megam::API::Errors::ErrorWithResponse
                end
                reerror = klass.new(error.message, error.response)
                reerror.set_backtrace(error.backtrace)
                reerror.response.body = Megam::JSONCompat.from_json(reerror.response.body.chomp)
                raise(reerror)
            end

            @last_response = response
            
            if response.body && !response.body.empty?
                if response.headers['Content-Encoding'] == 'gzip'
                    response.body = Zlib::GzipReader.new(StringIO.new(response.body)).read
                end

                begin
                    unless response.headers[X_Megam_OTTAI]
                        response.body = Megam::JSONCompat.from_json(response.body.chomp)
                    else
                        response.body = Megam::KoniPai.new.koni(response.body.chomp)
                    end
                rescue Exception => jsonerr
                    raise(jsonerr)
                end
            end
            
            Megam::Log.debug("END(#{(Time.now - start)}s)")
            
            @connection.reset
            response
        end

        private
        
        def assign_credentials
            @api_key       = @options.delete(:api_key) || ENV['MEGAM_API_KEY']
            @email         = @options.delete(:email)
            @password_hash = @options.delete(:password_hash)
            @org_id        = @options.delete(:org_id)
        end
        
        def ensure_host_is_flattened
            uri          = URI(@options.delete(:host)) if @options.has_key?(:host)
            
            scheme       = (uri && uri.scheme) ? uri.scheme : 'http'
    
            host         = (uri && uri.host)   ? uri.host : '127.0.0.1'
            
            port         = (uri && uri.port)   ? uri.port.to_s : '9000'
            
            @api_version = (uri && uri.path)   ? uri.path :  API_VERSION2
            
            @api_url     =  scheme +  "://" + host  + ":" + port + @api_version
        end
        
        def is_passthru?
            @options[:passthru]
        end    
        
        def ensure_authkeys
            if api_combo_missing? || pw_combo_missing?
                fail Megam::API::Errors::AuthKeysMissing 
            end
        end
        
        def api_combo_missing?
            (!@email.nil? && !@api_key.nil?)
        end
        
        
        
        def pw_combo_missing?
            (!@email.nil? && !@password_hash.nil?)
        end
        
        def turn_off_ssl_verify
           Excon.defaults[:ssl_verify_peer] = false   unless @api_url.include?("https")

        end

        def just_color_debug(path)
            text.msg "--> #{text.color("(#{path})", :cyan, :bold)}"                  
        end

        def connection
            @options[:path] = @api_version + @options[:path]
            
            build_headers

            @connection = Excon.new(@api_url, @options)
        end
        
        
        def build_headers
            encoded = encode_header
            
            @options[:headers] = HEADERS.merge(X_Megam_HMAC => encoded[:hmac],
                                        X_Megam_DATE => encoded[:date], 
                                        X_Megam_ORG => @org_id).merge(@options[:headers])
            
            
            build_header_puttusavi
        end   

        def encode_header
            body_base64 = Base64.urlsafe_encode64(OpenSSL::Digest::MD5.digest(@options[:body]))

            current_date = Time.now.strftime('%Y-%m-%d %H:%M')

            movingFactor = "#{current_date}" + "\n" + "#{@options[:path]}" + "\n" + "#{body_base64}"

            digest  = OpenSSL::Digest.new('sha256')

            if pw_combo_missing?
                hash = OpenSSL::HMAC.hexdigest(digest, Base64.strict_decode64(@password_hash), movingFactor)
            elsif api_combo_missing?
                hash = OpenSSL::HMAC.hexdigest(digest, @api_key, movingFactor)
            else
                hash = OpenSSL::HMAC.hexdigest(digest, "", movingFactor)
            end
            
            { hmac: (@email + ':' + hash), date: current_date }
        end
        
        def build_header_puttusavi
          if pw_combo_missing?
               @options[:headers] = @options[:headers].merge(X_Megam_PUTTUSAVI => "true") 
          end
        end
        
    end
end
