require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_billedhistories
    tmp_hash = { :accounts_id => "ACT1262792663065821184",
                 :assembly_id => "ASM89687",
                 :bill_type => "paypal",
                 :billing_amount => "45",
                 :currency_type => "USD"
    }

    response = megams.post_billedhistories(tmp_hash)
    assert_equal(201, response.status)
  end
#=end

=begin
  def test_get_billedhistories
    response = megams.get_billedhistories
    assert_equal(200, response.status)
  end
=end
=begin
  def test_get_billedhistories
    response = megams.get_billedhistory("iaas_default")
    assert_equal(200, response.status)
  end
=end
end
