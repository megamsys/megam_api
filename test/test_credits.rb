require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin

  def test_post_credits
    tmp_hash = { :account_id => "rrr",
                 :credit => "50"
    }

    response = megams.post_credits(tmp_hash)
    assert_equal(201, response.status)
  end
#=end

#=begin
  def test_list_credits
    response = megams.list_credits
    assert_equal(200, response.status)
  end
#=end
#=begin
  def test_get_credits
    response = megams.get_credits("rrr")
    assert_equal(200, response.status)
  end
#=end
end
