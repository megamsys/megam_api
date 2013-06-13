require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestLogin < MiniTest::Unit::TestCase
#successful Testing
  def test_post_login
    response =megams.post_auth()
    assert_equal(200, response.status)
  end

end
