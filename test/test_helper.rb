require File.expand_path("#{File.dirname(__FILE__)}/../lib/megam/api")

require 'rubygems'
gem 'minitest' # ensure we are using the gem version
require 'minitest/autorun'
require 'time'

SANDBOX_HOST_OPTIONS = {
      :scheme => 'http',
  :host => '127.0.0.1',
      :nonblock => false,
  :port => 9000
   #:port => 443
}


def megam(options)
  options = SANDBOX_HOST_OPTIONS.merge(options)
  mg=Megam::API.new(options)
end

def megams_new(options={})
s_options = SANDBOX_HOST_OPTIONS.merge({
  :email => "rr@e.com",
  :api_key => "FwNcgem0_T8AkxpkW4sD-A=="
})
  options = s_options.merge(options)
  mg=Megam::API.new(options)
end


def megams(options={})
s_options = SANDBOX_HOST_OPTIONS.merge({
  :email => sandbox_email,
  :api_key => sandbox_apikey

})
Megam::Log.level(:debug)
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

def domain_name
   "megambox.com"
end

def sandbox_name
  "org.megam"
end

def sandbox_apikey
"FwNcgem0_T8AkxpkW4sD-A=="  #{}"IamAtlas{74}NobdyCanSedfefdeME#07"
end

def sandbox_email
#  "darth@vader.com"
#"coolvader@iamswag.com"
"rr@e.com"
end
