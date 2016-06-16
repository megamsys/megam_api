require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

=begin
  def test_get_events
    response = megams.get_events("ASM9038606864211614815")
    assert_equal(200, response.status)
  end
=end
#=begin
def test_list_events
  response = megams.list_events("10")
  assert_equal(200, response.status)
end
#=end
end
