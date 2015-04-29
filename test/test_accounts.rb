require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestAccounts < MiniTest::Unit::TestCase

  $admin = "admin-tom"
  $normal = "normal-tom"
  $tom_email = "tom@gomegam.com"
  $bob_email = "bob@gomegam.com"

  def test_get_accounts_good
    response =megams.get_accounts(sandbox_email)
    response.body.to_s
    assert_equal(200, response.status)
  end

  def test_post_profile_good
    tmp_hash = {
      "id" => "000099090909000",
      "first_name" => "Darth",
      "last_name" => "Vader",
      "email" => "coolvader@enterprise.com",
      "phone" => "19090909090",
      "api_key" => "IamAtlas{74}NobdyCanSedfefdeME#07",
      "password" => "test",
      "authority" => "admin",
      "password_reset_key" => "",
      "created_at" => "2014-10-29 13:24:06 +0000"
      }
    response =megams.post_accounts(tmp_hash)
    response.body.to_s
    assert_equal(201, response.status)
  end

=begin
  def test_get_accounts_bad
    assert_raises(Megam::API::Errors::NotFound) do
    response =megams.get_accounts(sandbox_email+"_bad")
    response.body.to_s
    end
  end

  def test_post_accounts_admin
    response =megams.post_accounts(
    {:id => random_id, :email => $tom_email, :api_key => sandbox_apikey, :authority => $admin})
    response.body.to_s
    assert_equal(201, response.status)
  end

  def test_post_accounts_normal
    response =megams.post_accounts(
    {:id => random_id, :email => $bob_email, :api_key => sandbox_apikey, :authority => $normal})
    response.body.to_s
    assert_equal(201, response.status)
  end

  def test_post_accounts_normal_bad
    assert_raises(ArgumentError) do
    response =megam.post_accounts(
    {:id => random_id, :emailo => sandbox_email,
      :apik_key => sandbox_apikey, :authority => $admin})
    response.body.to_s
    end
  end
=end
end
