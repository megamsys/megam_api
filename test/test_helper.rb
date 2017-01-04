require File.expand_path("#{File.dirname(__FILE__)}/../lib/megam/api")

require 'rubygems'
gem 'minitest' # ensure we are using the gem version
require 'minitest/autorun'
require 'time'

SANDBOX_HOST_OPTIONS = {
    :scheme => 'http',
    #:host => 'localhost',
    #:host => 'cloud.det.io',
    :nonblock => false,
    :port => 9000
}


def megam(options)
    options = SANDBOX_HOST_OPTIONS.merge(options)
    mg=Megam::API.new(options)
end

def megams_new(options={})
    s_options = SANDBOX_HOST_OPTIONS.merge({
        :email => "test@megam.io",
        :api_key => "faketest"
    })
    options = s_options.merge(options)
    mg=Megam::API.new(options)
end

def megams(options={})
    s_options = SANDBOX_HOST_OPTIONS.merge({
        :email => "rajeshr@virtengine.com",
        :api_key => "5e08ad5a1a3c89910a2e51fb522812fee4560baa",
        :org_id => "ORG6974933279242510669",
        #:password => "bWVnYW0="
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
    "IamAtlas{74}NobdyCanSedfefdeME#07"
end

def sandbox_email
    "tour@megam.io"
end
