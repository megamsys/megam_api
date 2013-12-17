require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

  def test_post_boltdefns

   tmp_hash = {
      "node_name" => "black1.megam.co",
	"boltdefns" => {"username" => "new", "apikey" => "new", "store_name" => "", "url" => "", "prime" => "", "timetokill" => "", "metered" => "", "logging" => "", "runtime_exec" => ""}
    }

    response = megams.post_boltdefn(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_get_boltdefns
    response = megams.get_boltdefn("black1.megam.co")
    assert_equal(200, response.status)
  end

end
