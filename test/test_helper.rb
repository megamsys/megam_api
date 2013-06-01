require File.expand_path("#{File.dirname(__FILE__)}/../lib/megam/api")

require 'rubygems'
gem 'minitest' # ensure we are using the gem version
require 'minitest/autorun'
require 'time'


def megam(options={})
  # ENV['MEGAM_API_KEY'] used for :api_key
  mg=Megam::API.new(options={})  
end

def random_domain
  "megam.co"
end

def random_apikey
  SecureRandom.hex(10)
end

def random_email
  "email@#{"#{random_apikey}"}.com"
end


def sandbox_apikey
  "IamAtlas{74}NobodyCanSeeME#07"
end

def sandbox_email
  "sandy@megamsandbox.com"
end
