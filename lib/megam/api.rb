require "base64"
require "time"
require "excon"
require "uri"
require "zlib"
require 'openssl'

# open it up when needed. This will be needed when a new customer onboarded via pug.
require "securerandom"

__LIB_DIR__ = File.expand_path(File.join(File.dirname(__FILE__), ".."))
unless $LOAD_PATH.include?(__LIB_DIR__)
$LOAD_PATH.unshift(__LIB_DIR__)
end

require "megam/api/errors"
require "megam/api/version"
require "megam/api/login"
require "megam/api/accounts"
require "megam/api/nodes"
require "megam/api/requests"
require "megam/api/predefs"
require "megam/api/predef_clouds"
require "megam/api/cloud_tools"
require "megam/core/config"
require "megam/core/stuff"
require "megam/core/text"
require "megam/core/json_compat"
require "megam/core/auth"
require "megam/core/error"
require "megam/core/account"
require "megam/core/node"
require "megam/core/node_collection"
require "megam/core/request"
require "megam/core/request_collection"
require "megam/core/predef"
require "megam/core/predef_collection"
require "megam/core/predefcloud"
require "megam/core/predefcloud_collection"
require "megam/core/cloudtool"
require "megam/core/cloudtool_collection"
require "megam/core/cloudtemplate"
require "megam/core/cloudtemplate_collection"
require "megam/core/cloudinstruction_group"
require "megam/core/cloudinstruction_collection"
require "megam/core/cloudinstruction"

#we may nuke logs out of the api
#require "megam/api/logs"

# Do you need a random seed now ?
#srand

module Megam
  class API

    #text is used to print stuff in the terminal (message, log, info, warn etc.)
    attr_accessor :text

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
      #:host => 'play.megam.co',
      :port => '9000',
      :nonblock => false,
      #:scheme => 'https'
      :scheme => 'http'

    }

    API_VERSION1 = "/v1"

    def text
      @text ||= Megam::Text.new(STDOUT, STDERR, STDIN, {})
    end

    def last_response
      @last_response
    end

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
      raise ArgumentError, "You must specify [:email, :api_key]" if @email.nil? || @api_key.nil?
    end

    def request(params,&block)
      start = Time.now
      text.msg "#{text.color("START", :cyan, :bold)}"
      params.each do |pkey, pvalue|
        text.msg("> #{pkey}: #{pvalue}")
      end

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
        text.msg "#{text.color("#{reerror.response.body}", :white)}"
        reerror.response.body = Megam::JSONCompat.from_json(reerror.response.body.chomp)
        text.msg("#{text.color("RESPONSE ERR: Ruby Object", :magenta, :bold)}")
        text.msg "#{text.color("#{reerror.response.body}", :white, :bold)}"
        raise(reerror)
      end

      @last_response = response
      text.msg("#{text.color("RESPONSE: HTTP Status and Header Data", :magenta, :bold)}")
      text.msg("> HTTP #{response.remote_ip} #{response.status}")

      response.headers.each do |header, value|
        text.msg("> #{header}: #{value}")
      end
      text.info("End HTTP Status/Header Data.")

      if response.body && !response.body.empty?
        if response.headers['Content-Encoding'] == 'gzip'
          response.body = Zlib::GzipReader.new(StringIO.new(response.body)).read
        end
        text.msg("#{text.color("RESPONSE: HTTP Body(JSON)", :magenta, :bold)}")

        text.msg "#{text.color("#{response.body}", :white)}"

        begin
          response.body = Megam::JSONCompat.from_json(response.body.chomp)
          text.msg("#{text.color("RESPONSE: Ruby Object", :magenta, :bold)}")

          text.msg "#{text.color("#{response.body}", :white, :bold)}"
        rescue Exception => jsonerr
          text.error(jsonerr)
          raise(jsonerr)
        # exception = Megam::JSONCompat.from_json(response_body)
        # msg = "HTTP Request Returned #{response.code} #{response.message}: "
        # msg << (exception["error"].respond_to?(:join) ? exception["error"].join(", ") : exception["error"].to_s)
        # text.error(msg)
        end
      end
      text.msg "#{text.color("END(#{(Time.now - start).to_s}s)", :blue, :bold)}"
      #  text.msg "#{text.color("END(#{(Megam::Stuff.time_ago(start))})", :blue, :bold)}"

      # reset (non-persistent) connection
      @connection.reset
      response
    end

    private

    #Make a lazy connection.
    def connection
      @options[:path] =API_VERSION1+ @options[:path]
      encoded_api_header = encode_header(@options)
      @options[:headers] = HEADERS.merge({
        'X-Megam-HMAC' => encoded_api_header[:hmac],
        'X-Megam-Date' => encoded_api_header[:date],
      }).merge(@options[:headers])


#SSL certificate file paths
#Excon.defaults[:ssl_verify_peer] = false
#Excon.defaults[:ssl_ca_path] = '/etc/nginx/ssl/'
#Excon.defaults[:ssl_ca_file] = '/etc/nginx/ssl/server.crt'

#Excon.defaults[:ssl_ca_path] = File.join(File.dirname(__FILE__), '../../test/data/')
#ENV['SSL_CERT_DIR'] = File.join(File.dirname(__FILE__), '../../test/data/')
#Excon.defaults[:ssl_ca_file] = File.join(File.dirname(__FILE__), '..', '..', 'test', 'data', 'server.crt')
#ENV['SSL_CERT_FILE'] = File.join(File.dirname(__FILE__), '..', '..', 'test', 'data', 'server.crt')


      text.info("HTTP Request Data:")
      text.msg("> HTTP #{@options[:scheme]}://#{@options[:host]}")
      @options.each do |key, value|
        text.msg("> #{key}: #{value}")
      end
      text.info("End HTTP Request Data.")
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
      body_digest = OpenSSL::Digest::MD5.digest(cmd_parms[:body])
      body_base64 = Base64.encode64(body_digest)

      current_date = Time.now.strftime("%Y-%m-%d %H:%M")

      data="#{current_date}"+"\n"+"#{cmd_parms[:path]}"+"\n"+"#{body_base64}"

      digest  = OpenSSL::Digest::Digest.new('sha1')
      movingFactor = data.rstrip!
      hash = OpenSSL::HMAC.hexdigest(digest, @api_key, movingFactor)
      final_hmac = @email+':' + hash
      header_params = { :hmac => final_hmac, :date => current_date}
    end
  end

end
