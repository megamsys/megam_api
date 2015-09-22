require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

=begin
  def test_get_assemblies
   response = megams.get_assemblies
   assert_equal(200, response.status)
 end
=end
 def test_get_assembly
   response = megams.get_one_assemblies("AMS1257720849197301760")
   assert_equal(200, response.status)
 end
=begin
 def test_post_assembly
   tmp_hash =  {
      "name" => "testAsm",
     "org_id" => "ORG123",
     "assemblies" => [],
     "inputs" => []
     }
   response = megams.post_assemblies(tmp_hash)
   assert_equal(200, response.status)
end
=end
end
