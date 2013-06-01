require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestLogin < MiniTest::Unit::TestCase
  def test_post_login
    response =megams.post_auth(sandbox_email, sandbox_apikey)
    assert_equal(200, response.status)
  end

end
