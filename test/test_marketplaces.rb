require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestMarketplaces < MiniTest::Unit::TestCase

  def test_post_marketplace
    tmp_hash = {
      "name" => "34-Trac",
      "catalog" => {"logo" => "logo", "category"=> "catagroy", "description"=> "description"},
      "plans" => [{"price"=> "30", "description"=> "description", "plantype"=> "paid", "version"=> "0.1", "source"=> "source"}],
      "cattype" => "DEW",
      "predefnode" => "java",
      "status" => "ACTIVE" }

    response = megams.post_marketplaceapp(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_get_marketplaces
    response = megams.get_marketplaceapps
    assert_equal(200, response.status)
  end

 def test_get_marketplace
    response = megams.get_marketplaceapp("34-Trac")
    assert_equal(200, response.status)
  end

end
