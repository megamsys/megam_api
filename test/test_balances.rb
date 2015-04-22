require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
=begin
  def test_post_balances
    tmp_hash = { :accounts_id => "ACT93476985797", 
                 :credit => "50"
    }

    response = megams.post_balances(tmp_hash)
    assert_equal(201, response.status)
  end
=end

def test_update_balances
  tmp_hash = {:id=>"BAL1200828423543586816", 
              :accounts_id=>"ACT1195015634723930112", 
              :credit=>"23", 
              :created_at=>"2015-04-17 12:33:40 +0000", 
              :updated_at=>"2015-04-17 12:33:40 +0000"
              }
   response = megams.update_balance(tmp_hash)
    assert_equal(201, response.status)
end

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

