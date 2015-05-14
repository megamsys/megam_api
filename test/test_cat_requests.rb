require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
  
  @@tmp_hash = {
    "cat_id" => "ASM1136003656177549312",
    "name" => "HermanWard.megam.co", #APP or Bolt
    "action" => "start"
  }

  
  def test_request_app_start  
    response = megams.post_request(@@tmp_hash)
    assert_equal(201, response.status)
  end
#=end

end
