require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

  def test_post_boltdefns

   tmp_hash = {
      "node_name" => "night.megam.co",
	"boltdefns" => {"username" => "new", "apikey" => "new", "store_name" => "", "url" => "", "prime" => "", "timetokill" => "", "metered" => "", "logging" => "", "runtime_exec" => ""}
    }

puts "======================> POST APPDEFNS TEMP HASH <============================================= "
puts tmp_hash
    response = megams.post_boltdefn(tmp_hash)
    assert_equal(201, response.status)
  end

end
