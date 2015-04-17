require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_subscriptions
    tmp_hash = { :accounts_id => "ACT93476985797", 
                 :assembly_id => "ASMkh9879847",
                 :start_date => "45",
                 :end_date => ""
    }

    response = megams.post_subscriptions(tmp_hash)
    assert_equal(201, response.status)
  end
#=end

=begin
  def test_get_subscriptions
    response = megams.get_subscriptions
    assert_equal(200, response.status)
  end
=end
=begin
  def test_get_subscriptions
    response = megams.get_subscriptions("iaas_default")
    assert_equal(200, response.status)
  end
=end
end

