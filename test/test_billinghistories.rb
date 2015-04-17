require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_billinghistories
    tmp_hash = { :accounts_id => "ACT93476985797", 
                 :assembly_id => "ASM89687",
                 :bill_type => "paypal",
                 :billing_amount => "45",
                 :currency_type => "USD"
    }

    response = megams.post_billinghistories(tmp_hash)
    assert_equal(201, response.status)
  end
#=end

=begin
  def test_get_billinghistories
    response = megams.get_billinghistories
    assert_equal(200, response.status)
  end
=end
=begin
  def test_get_billinghistories
    response = megams.get_billinghistory("iaas_default")
    assert_equal(200, response.status)
  end
=end
end

