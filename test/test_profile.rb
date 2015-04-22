require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestProfile < MiniTest::Unit::TestCase

  $admin = "admin-tom"
  $normal = "normal-tom"
  $tom_email = "tom@gomegam.com"
  $bob_email = "bob@gomegam.com"

   @email = "proper@account.com"


=begin
  def test_get_organizations_good
    response =megams.get_organization(sandbox_name)
    response.body.to_s
    assert_equal(200, response.status)
  end


=end
  def test_post_profile_good
    tmp_hash = {
     "first_name" => "yeshwanthzzz",
      "last_name" => "kumar",
      "email" => "new@test.com",
      "api_token" => "IamAtlas{74}NobdyCanSedfefdeME#07",
        "password" => "test",
        "password_confirmation" => "test2wdw",
        "password_reset_token" => "dummy"}
    response =megams.post_profile(tmp_hash)
    response.body.to_s
    assert_equal(201, response.status)
  end
=begin
def test_get_profile_good
    response =megams.get_profile("new@test.com")
     assert_equal(200, response.status)
 end
=end
end
