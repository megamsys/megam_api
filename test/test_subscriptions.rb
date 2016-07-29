require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_subscriptions
    tmp_hash = { :account_id => "",
                 :model => "ondemand",
                 :license => "trial",
                 :trial_ends => "21/11/2016 20:30:00"
    }

    response = megams.post_subscriptions(tmp_hash)
    assert_equal(201, response.status)
  end
#=end
#=begin
def test_get_subscription
    response = megams.get_subscription
    assert_equal(200, response.status)
end
#=end
end
