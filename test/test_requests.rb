require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

  def test_get_requests
    response = megams.get_requests
    assert_equal(200, response.status)
  end

  def test_get_request_faulty
    assert_raises(Megam::API::Errors::NotFound) do
      response = megams.get_request("faulty")
    end
  end

  def test_get_request_good
    response = megams.get_request("morning.megam.co")
    assert_equal(200, response.status)
  end

  
end