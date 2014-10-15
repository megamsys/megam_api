require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase


 def test_get_component
   response = megams.get_components("COM519839138036318208")
   assert_equal(200, response.status)
 end
end