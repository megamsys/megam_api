require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_addons
    tmp_hash = { :provider_id => "2334",
                 :account_id => "",
                 :provider_name => "whmcs",
                 :options => [],
    }

    response = megams.post_addons(tmp_hash)
    assert_equal(201, response.status)
  end
#=end
#=begin
def test_get_addon
  response = megams.get_addon("whmcs")
  assert_equal(200, response.status)
end
#=end
end
