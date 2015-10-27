class TestMixinsComponent < MiniTest::Unit::TestCase

  def test_app
    ## input the torpedo hash
    tmp_hash = { :accounts_id => "ACT93476985797",
                 :line1 => "paypal",
                 :line2 => "#kjbh76",
                 :country_code => "",
                 :postal_code => "",
                 :state => "",
                 :phone => "",
                 :bill_type => ""
    }

    # comp_dable
    # compare the results
    response = megams.post_billings(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_service
    ## input the torpedo hash
    tmp_hash = { :accounts_id => "ACT93476985797",
                 :line1 => "paypal",
                 :line2 => "#kjbh76",
                 :country_code => "",
                 :postal_code => "",
                 :state => "",
                 :phone => "",
                 :bill_type => ""
    }

    # comp_dable
    # compare the results
    response = megams.post_billings(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_microservice
    ## input the torpedo hash
    tmp_hash = { :accounts_id => "ACT93476985797",
                 :line1 => "paypal",
                 :line2 => "#kjbh76",
                 :country_code => "",
                 :postal_code => "",
                 :state => "",
                 :phone => "",
                 :bill_type => ""
    }

    # comp_dable
    # compare the results
    response = megams.post_billings(tmp_hash)
    assert_equal(201, response.status)
  end
end
