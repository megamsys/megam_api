require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase


 def test_get_assemblies0
   response = megams.get_assemblies("AMS520182421052719104")
   assert_equal(200, response.status)
 end
end
