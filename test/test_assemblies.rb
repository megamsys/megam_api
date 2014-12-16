require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase


  def test_get_assemblies
   response = megams.get_assemblies
   assert_equal(200, response.status)
 end

 def test_get_assembly
   response = megams.get_one_assemblies("AMS1133263480544165888")
   assert_equal(200, response.status)
 end
end
