require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestAccounts < MiniTest::Unit::TestCase
  def test_signin_auth
    response = megams.get_accounts("test@megam.io")
    response.body.to_s
    assert_equal(200, response.status)
  end

  def test_post_accounts_good
    tmp_hash = {
      "first_name" => "Darth",
      "last_name" => "Vader",
      "email" => "test@megam.io",
      "phone" => "19090909090",
      "api_key" => "IamAtlas{74}NobdyCanSedfefdeME#07",
      "authority" => "admin",
      "password" => Base64.strict_encode64("megam"),
      "password_reset_key" => "",
      "password_reset_sent_at" => "",
    }
    response =megams_new.post_accounts(tmp_hash)
    response.body.to_s
    assert_equal(201, response.status)
  end

  def test_update_accounts_good
    tmp_hash = {
      "id" => "w3423",
      "first_name" => "Darth",
      "last_name" => "Vader",
      "email" => "test@megam.io",
      "phone" => "19090909090011111111",
      "api_key" => "IamAtlas{74}NobdyCanSedfefdeME#07",
      "password" => "tset",
      "authority" => "admin",
      "password_reset_key" => "",
      "password_reset_sent_at" => "",
      "created_at" => "2014-10-29 13:24:06 +0000"
    }
    response = megams.update_accounts(tmp_hash)
    response.body.to_s
    assert_equal(201, response.status)
  end

  def test_get_accounts_bad
    assert_raises(Megam::API::Errors::NotFound) do
      response =megams.get_accounts(sandbox_email+"_bad")
      response.body.to_s
    end
  end
end
