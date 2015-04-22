require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_billings
    tmp_hash = { :accounts_id => "ACT93476985797", 
                 :line1 => "paypal",
                 :line2 => "#kjbh76",
                 :country_code => "",
                 :postal_code => "",
                 :state => "",
                 :phone => "",
                 :bill_type => ""
    }

    response = megams.post_billings(tmp_hash)
    assert_equal(201, response.status)
  end
#=end

=begin
  def test_get_billings
    response = megams.get_billings
    assert_equal(200, response.status)
  end
=end
=begin
  def test_get_billings
    response = megams.get_billing("iaas_default")
    assert_equal(200, response.status)
  end
=end
end

