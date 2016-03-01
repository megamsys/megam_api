require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
=begin
  def test_post_discount
    tmp_hash = { :accounts_id => "ACT93476985797",
                 :bill_type => "paypal",
                 :code => "#kjbh76",
                 :status => ""
    }

    response = megams.post_discounts(tmp_hash)
    assert_equal(201, response.status)
  end
=end

=begin
  def test_get_discounts
    response = megams.get_discounts
    puts response.inspect
    assert_equal(200, response.status)

  end
=end
=begin
  def test_get_discounts
    response = megams.get_discounts("iaas_default")
    assert_equal(200, response.status)
  end
=end
end
