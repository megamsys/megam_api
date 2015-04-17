require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_balances
    tmp_hash = { :accounts_id => "ACT93476985797", 
                 :credit => "50"
    }

    response = megams.post_balances(tmp_hash)
    assert_equal(201, response.status)
  end
#=end

=begin
  def test_get_balances
    response = megams.get_balances
    assert_equal(200, response.status)
  end
=end
=begin
  def test_get_balances
    response = megams.get_balance("iaas_default")
    assert_equal(200, response.status)
  end
=end
end

