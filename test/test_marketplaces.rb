require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestMarketplaces < MiniTest::Unit::TestCase
=begin
  def test_post_marketplace
    tmp_hash = {
      "name" => "34-Trac",
      "catalog" => {"logo" => "logo", "category"=> "catagroy", "description"=> "description"},
      "plans" => [{"price"=> "30", "description"=> "description", "plantype"=> "paid", "version"=> "0.1", "source"=> "source"}],
      "cattype" => "DEW",
      "predefnode" => "java",
      "status" => "ACTIVE",
      "order" => "",
      "image" => "",
      "url" => "",
      "envs" => []
     }

    response = megams.post_marketplaceapp(tmp_hash)
    assert_equal(201, response.status)
  end
=end

#=begin
  def test_get_marketplaces
    response = megams.get_marketplaceapps
    assert_equal(200, response.status)
  end
#=end
=begin
 def test_get_marketplace
    response = megams.get_marketplaceapp("Mysql")
    assert_equal(200, response.status)
  end
=end
end
