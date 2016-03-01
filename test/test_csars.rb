require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
=begin
  def test_get_csars
    response = megams.get_csars
    assert_equal(200, response.status)
  end

  def test_get_csar
    response = megams.get_csar("CSI1116385673159507968")
    assert_equal(200, response.status)
  end


  def test_get_csar_not_found
    assert_raises(Megam::API::Errors::NotFound) do
      megams.get_csar("stupid.megam.co")
    end
  end
=end
end
