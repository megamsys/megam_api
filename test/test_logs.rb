require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestLogs < MiniTest::Unit::TestCase

#Testing with the logstash key(syslog).
#This testing gives 303(See Other)
#The result will be redirected to somewhere, from where we can get the logs.
  def test_get_logs
      response = megams.get_logs("syslog")

      assert_equal(200, response.status)
      assert_match(%r{^https://localhost\.megam\.co/streams/[-a-zA-Z0-9]*\?srv=[0-9]*$}, response.body)
  end

end
