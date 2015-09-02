require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

  @@tmp_hash = {
    "cat_id" => "ASM1136003656177549312",
    "name" => "careworn", #APP or Bolt
    "cattype" => "app",
    "action" => "start",
    "category" => "control"
  }


  def test_request_app_start
    response = megams.post_catrequest(@@tmp_hash)
    assert_equal(201, response.status)
  end
#=end

end
