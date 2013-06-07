require File.expand_path("#{File.dirname(__FILE__)}/../lib/megam/api")

require 'rubygems'
gem 'minitest' # ensure we are using the gem version
require 'minitest/autorun'
require 'time'

SANDBOX_HOST_OPTIONS = {
  :host => 'localhost',
  :port => 9000
}


def megam(options={})  
  options = SANDBOX_HOST_OPTIONS.merge(options)
  mg=Megam::API.new(options)  
end

def megams(options={})  
s_options = SANDBOX_HOST_OPTIONS.merge({
  :email => sandbox_email,
  :api_key => sandbox_apikey  
}) 
  options = s_options.merge(options)
  mg=Megam::API.new(options)  
end

def random_domain
  "megam.co"
end

def random_id
  SecureRandom.random_number(1000)  
end

def random_name
  SecureRandom.hex(15)
end

def random_apikey
  SecureRandom.hex(10)
end

def random_email
  "email@#{random_apikey}.com"
end
 

def sandbox_apikey
   "IamAtlas{74}NobodyCanSeeME#07"
end

def sandbox_email
  "sandy@megamsandbox.com"
end
