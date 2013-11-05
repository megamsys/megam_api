require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

  def test_post_boltreqs

   tmp_hash = {
      "req_type" => "NStart",
      "node_name" => "night.megam.co",
      "boltdefns_id" => "12455454",
      "lc_apply" => "APPly",
      "lc_additional" => "ADDition",
      "lc_when" => "When"
    }

puts "======================> POST BOLTREQS TEMP HASH <============================================= "
puts tmp_hash
    response = megams.post_boltreq(tmp_hash)
    assert_equal(201, response.status)
  end
=begin
  def test_get_appdefns
    response = megams.get_appdefn("night.megam.co")
    assert_equal(200, response.status)
  end
=end

end
