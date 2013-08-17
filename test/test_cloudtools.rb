require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

  def test_get_cloudtools
    response = megams.get_cloudtools
    assert_equal(200, response.status)
  end
=begin
  def test_get_cloudtools1
    response = megams.get_cloudtool("chef")
    assert_equal(200, response.status)
  end
  

  def test_get_cloudtool_not_found
    assert_raises(Megam::API::Errors::NotFound) do
      megams.get_cloudtool("stupid.megam.co")
    end
  end
=end
end