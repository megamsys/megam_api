require "base64"
require "excon"
require "securerandom"
require "uri"
require "zlib"

__LIB_DIR__ = File.expand_path(File.join(File.dirname(__FILE__), ".."))
unless $LOAD_PATH.include?(__LIB_DIR__)
  $LOAD_PATH.unshift(__LIB_DIR__)
end

require "megam/api/json"
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
      'Accept'                => 'application/json',
      'Accept-Encoding'       => 'gzip',
      #'Accept-Language'       => 'en-US, en;q=0.8',
      'User-Agent'            => "megam-api/#{Megam::API::VERSION}",
      'X-Ruby-Version'        => RUBY_VERSION,
      'X-Ruby-Platform'       => RUBY_PLATFORM
    }

    OPTIONS = {
      :headers  => {},
      :host     => 'api.megam.co',
      :nonblock => false,
      :scheme   => 'http'
    }

    def initialize(options={})
      options = OPTIONS.merge(options)

      @api_key = options.delete(:api_key) || ENV['MEGAM_API_KEY']
      if !@api_key && options.has_key?(:email) && options.has_key?(:password)
        @connection = Excon.new("#{options[:scheme]}://#{options[:host]}", options.merge(:headers => HEADERS))
        @api_key = self.post_login(options[:email], options[:password]).body["api_key"]
      end

      user_pass = ":#{@api_key}"
      options[:headers] = HEADERS.merge({
        'Authorization' => "Basic #{Base64.encode64(user_pass).gsub("\n", '')}",
      }).merge(options[:headers])

      @connection = Excon.new("#{options[:scheme]}://#{options[:host]}", options)
    end

    def request(params, &block)
      begin
        response = @connection.request(params, &block)
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
          # leave non-JSON body as is
        end
      end

      # reset (non-persistent) connection
      @connection.reset

      response
    end

    private

    def node_params(params)
      node_params = {}
      params.each do |key, value|
        node_params["nodes[#{key}]"] = value
      end
      app_params
    end

    
  end
end
