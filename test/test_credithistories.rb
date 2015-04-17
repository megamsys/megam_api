require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_credithistories
    tmp_hash = { :accounts_id => "ACT93476985797", 
                 :bill_type => "paypal",
                 :credit_amount => "50",
                 :currency_type => ""
    }

    response = megams.post_credithistories(tmp_hash)
    assert_equal(201, response.status)
  end
#=end

=begin
  def test_get_credithistories
    response = megams.get_credithistories
    assert_equal(200, response.status)
  end
=end
=begin
  def test_get_credithistories
    response = megams.get_credithistories("iaas_default")
    assert_equal(200, response.status)
  end
=end
end

