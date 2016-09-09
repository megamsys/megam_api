require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
    def test_post_billingtransactions
=begin
        tmp_hash = { :accounts_id => "5555555",
            :gateway => "paypal",
            :amountin => "5",
            :amountout => "5.99",
            :fees => "0.99",
            :tranid => "HGH111",
            :trandate => "31/21/2012",
            :currency_type => "USD"
        }
=end
        tmp_hash = {
                  :gateway => "paypal",
                  :amountin => "5",
                  :amountout => "5.99",
                  :fees => "0.99",
                  :tranid => "HGrH111",
                  :trandate => "2016-08-24 12:23",
                  :currency_type => "USD"
                }


        response = megams.post_billingtransactions(tmp_hash)
        assert_equal(201, response.status)
    end

    def test_get_billingtransactions
        response = megams.get_billingtransactions
        assert_equal(200, response.status)
    end
end
