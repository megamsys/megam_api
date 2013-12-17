require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
  def test_post_appreqs

    tmp_hash = {
      "req_type" => "NStart",
      "node_name" => "black1.megam.co",
      "appdefns_id" => "12455",
      "lc_apply" => "APPly",
      "lc_additional" => "ADDition",
      "lc_when" => "When"
    }

    response = megams.post_appreq(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_get_appreqs
    response = megams.get_appreq("oceanographer1.megam.co")
    assert_equal(200, response.status)
  end


end
