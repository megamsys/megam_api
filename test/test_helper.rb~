require File.expand_path("#{File.dirname(__FILE__)}/../lib/megam/api")

require 'rubygems'
gem 'minitest' # ensure we are using the gem version
require 'minitest/autorun'
require 'time'



def megam
  puts "working"
  # ENV['MEGAM_API_KEY'] used for :api_key
  mg=Megam::API.new()
  puts "ended successfully"
  mg
  
end

def random_domain
  "megam.co"
end

def random_name
  "megam-api_#{SecureRandom.hex(10)}"
end

def random_email_address
  "email@#{random_name}.com"
end
