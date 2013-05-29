require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestLogin < MiniTest::Unit::TestCase

  def test_post_login
    
   response =megam.post_auth('email@example.com', 'fake_password')

   assert_equal(200, response.status)
  
end


end
