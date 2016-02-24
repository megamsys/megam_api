require File.expand_path("#{File.dirname(__FILE__)}/../lib/megam/api")

require 'rubygems'
gem 'minitest' # ensure we are using the gem version
require 'minitest/autorun'
require 'time'

SANDBOX_HOST_OPTIONS = {
      :scheme => 'http',
  :host => '192.168.1.105',
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
  :email => "test@megam.io",
  :api_key => "IamAtlas{74}NobdyCanSedfefdeME#07"
})
  options = s_options.merge(options)
  mg=Megam::API.new(options)
end

=begin
def megams(options={})
s_options = SANDBOX_HOST_OPTIONS.merge({
  :email => sandbox_email,
  :api_key => sandbox_apikey

})
=end

def megams(options={})
s_options = SANDBOX_HOST_OPTIONS.merge({
  :email => "test@megam.io",
  :api_key => "",
  :password => "bWVnYW0="

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
 "faketour"
end

def sandbox_email
#  "darth@vader.com"
#"qwe@qwe.co"
"tour@megam.io"
end
