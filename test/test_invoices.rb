require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
=begin
  def test_post_invoices
    tmp_hash = { :from_date => "2015-10-09",
                 :to_date => "2015-11-30",
                 :month => "oct",
                 :bill_type => "paypal",
                 :billing_amount => "45",
                 :currency_type => "USD"
    }

    response = megams.post_invoices(tmp_hash)
    assert_equal(201, response.status)
  end
=end

=begin
  def test_get_invoices
    response = megams.get_invoices
    assert_equal(200, response.status)
  end
=end
#=begin
  def test_get_invoice
    response = megams.get_invoice("iaas_default")
    assert_equal(200, response.status)
  end
#=end
end
