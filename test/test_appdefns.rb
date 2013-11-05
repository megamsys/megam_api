require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

  def test_post_appdefns

   tmp_hash = {
      "node_name" => "night.megam.co",
	"appdefns" => {"username" => "new", "apikey" => "new", "store_name" => "", "url" => "", "prime" => "", "timetokill" => "", "metered" => "", "logging" => "", "runtime_exec" => ""}
    }

puts "======================> POST APPDEFNS TEMP HASH <============================================= "
puts tmp_hash
    response = megams.post_appdefn(tmp_hash)
    assert_equal(201, response.status)
  end

end
