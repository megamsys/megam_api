require "base64"
require "digest/md5"
require "digest/sha1"
require "time"
require "excon"
require "securerandom"
require "uri"
require "zlib"
require 'openssl'

#require "iconv"

__LIB_DIR__ = File.expand_path(File.join(File.dirname(__FILE__), ".."))
unless $LOAD_PATH.include?(__LIB_DIR__)
$LOAD_PATH.unshift(__LIB_DIR__)
end

require "megam/api/json/okjson"
require "megam/api/errors"
require "megam/api/version"
require "megam/api/nodes"
require "megam/api/login"
require "megam/api/logs"
require "megam/api/predefs"
require "megam/api/accounts"

srand

module Megam
  class API

    HEADERS = {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip',
      'User-Agent' => "megam-api/#{Megam::API::VERSION}",
      'X-Ruby-Version' => RUBY_VERSION,
      'X-Ruby-Platform' => RUBY_PLATFORM
    }

    OPTIONS = {
      :headers => {},
      :host => 'localhost',
      :port => '9000',
      :nonblock => false,
      :scheme => 'http'
    }

    API_VERSION1 = "v1"

    # It is assumed that every API call will use an API_KEY/email. This ensures validity of the person
    # really the same guy on who he claims.
    # 3 levels of options exits
    # 1. The global OPTIONS as available inside the API (OPTIONS)
    # 2. The options as passed via the instantiation of API will override global options. The ones that are passed are :email and :api_key and will
    # be  merged into a class variable @options
    # 3. Upon merge of the options, the api_key, email as available in the @options is deleted.
    def initialize(options={})
      @options = OPTIONS.merge(options)
      @api_key = @options.delete(:api_key) || ENV['MEGAM_API_KEY']
      @email = @options.delete(:email)
    end

    def request(params,&block)
      begin
        puts "REQUEST PARAMS ==========>>>>>"
        puts params
        response = connection.request(params, &block)
        puts "RESPONSE=========> "
        puts response.inspect
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
        raise(reerror)
      end
      if response.body && !response.body.empty?
        if response.headers['Content-Encoding'] == 'gzip'
          response.body = Zlib::GzipReader.new(StringIO.new(response.body)).read
        end
        begin
          response.body = Megam::API::OkJson.decode(response.body)
        rescue
        end
      end

      # reset (non-persistent) connection
      @connection.reset
      puts("response    ===> #{response}")
      puts("------------------------------------")
      response
    end

    private

    #Make a lazy connection.
    def connection
      @options[:path] =API_VERSION1+ @options[:path]
      encoded_api_header = encode_header(@options)

      puts("enc_api_hea ===> #{encoded_api_header}")
      puts encoded_api_header.inspect

      @options[:headers] = HEADERS.merge({
        'hmac' => encoded_api_header[:hmac],
        'date' => encoded_api_header[:date],
      }).merge(@options[:headers])
      puts "OPTIONS=================>>>>>>>>> "
      puts @options
      #@connection = Excon.new("#{@options[:scheme]}://#{@options[:host]}:#{@options[:port]}/#{@options[:path]}",@options)
      @connection = Excon.new("#{@options[:scheme]}://#{@options[:host]}",@options)
    end

    ## encode header as per rules.
    # The input hash will have
    # :api_key, :email, :body, :path
    # The output will have
    # :hmac
    # :date
    # (Refer https://Github.com/indykish/megamplay.git/test/AuthenticateSpec.scala)
    def encode_header(cmd_parms)
      header_params ={}
      # body_digest = Digest::MD5.digest(cmd_parms[:body])
      #encode the body

      puts("------------------------------------")
      puts("cmd_parms   ===> #{cmd_parms}")

      body_digest = OpenSSL::Digest::MD5.digest(cmd_parms[:body])
      body_base64 = Base64.encode64(body_digest)
      puts("body_base64 ===> #{body_base64}")

      current_date = Time.now.strftime("%Y-%m-%d %H:%M")
      puts("curr_date   ===> #{current_date}")

      data = current_date + "\n" + cmd_parms[:path] + "\n" + body_base64
      puts "DATA==========================>>>>>>>>>"
      puts data

      puts "API KEY=====>  "
      puts @api_key

      dummy_hmac = [OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), @api_key, data)].pack("m").strip
      dummy_hmac1 = Base64.encode64(dummy_hmac)
      puts dummy_hmac1
      final_hmac = @email+':' + dummy_hmac

      puts("Final HMAC   ===> "+final_hmac)

      header_params = { :hmac => final_hmac, :date => current_date}

    end

    def node_params(params)
      node_params = {}
      params.each do |key, value|
        node_params["nodes[#{key}]"] = value
      end
      node_params
    end
  end
end
