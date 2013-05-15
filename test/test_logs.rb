require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestLogs < MiniTest::Unit::TestCase

  def test_get_logs
      response = megam.get_logs("tempnode")

      assert_equal(200, response.status)
      assert_match(%r{^https://localhost\.megam\.co/streams/[-a-zA-Z0-9]*\?srv=[0-9]*$}, response.body)
  end

end
