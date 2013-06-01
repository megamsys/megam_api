require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestAccounts < MiniTest::Unit::TestCase
  
  def test_get_accounts

    response =megam({:api_key => sandbox_apikey, :email => sandbox_email}).get_accounts('email@example.com')

puts "before response"
#Test for account post
	#response =megam.post_accounts('1', 'email@example.com', 'fake_password', 'paid')

#Test for account get
	#response =megam.get_accounts('email@example.com')
    assert_equal(200, response.status)

  end
  
  def test_post_accounts

    response =megam.post_accounts('1',random_email,random_apikey,'admin')

    assert_equal(200, response.status)

  end

end
