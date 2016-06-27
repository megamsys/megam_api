require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_billingtranscations
    tmp_hash = { :accounts_id => "5555555",
                 :gateway => "paypal",
                 :amountin => "5",
                 :amountout => "5.99",
                 :fees => "0.99",
                 :tranid => "HGH111",
                 :trandate => "31/21/2012",
                 :currency_type => "USD"
    }

    response = megams.post_billingtranscations(tmp_hash)
    assert_equal(201, response.status)
  end
#=end

#=begin
  def test_get_billingtranscations
    response = megams.get_billingtranscations
    assert_equal(200, response.status)
  end
#=end
=begin
  def test_get_billingtranscations
    response = megams.get_billingtranscations("iaas_default")
    assert_equal(200, response.status)
  end
=end
end
