require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin

  def test_post_credit
    tmp_hash = { :account_id => "info@megam.io",
                 :credit => "50"
    }

    response = megams.post_credit(tmp_hash)
    assert_equal(201, response.status)
  end
#=end

#=begin
  def test_list_credit
    response = megams.list_credit
    assert_equal(200, response.status)
  end
#=end
#=begin
  def test_get_credit
    response = megams.get_credit("rrr")
    assert_equal(200, response.status)
  end
#=end
end
