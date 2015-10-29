require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

  def test_get_promos()
    response = megams.get_promos("megamfree5")
    assert_equal(200, response.status)
   
  end

end

