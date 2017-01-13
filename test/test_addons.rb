require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_addons
    tmp_hash = {
      :json_claz => "Megam::Addons",
      :id => "48",
      :provider_id => "48",
      :account_id => "raj@world.com",
      :provider_name => "WHMCS",
      :options => [],
      :created_at => "2017-01-07 11:20:16 +0530"
    }

    response = megams.post_addons(tmp_hash)
    assert_equal(201, response.status)
  end
#=end
=begin
def test_get_addon
  response = megams.get_addon("whmcs")
  assert_equal(200, response.status)
end
=end
end
