require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestAccounts < MiniTest::Unit::TestCase

  $admin = "admin-tom"

  $normal = "normal-tom"


#Successful testing
#Get accounts yet to be tested
  def test_get_accounts
    response =megams.get_accounts(sandbox_email)
    assert_equal(200, response.status)
  end

#Successful testing
#POST accounts success
#Json added in riak


  def test_post_accounts_admin
    response =megams.post_accounts(random_id, sandbox_email, sandbox_apikey, $admin)
    assert_equal(200, response.status)
  end


  def test_post_accounts_normal
    response =megams.post_accounts(random_id, random_email, random_apikey, $normal)
    assert_equal(200, response.status)
  end

end

