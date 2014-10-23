require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestOrganizations < MiniTest::Unit::TestCase

  $admin = "admin-tom"
  $normal = "normal-tom"
  $tom_email = "tom@gomegam.com"
  $bob_email = "bob@gomegam.com"


  def test_get_organizations_good
    response =megams.get_organizations(sandbox_name)
    response.body.to_s
    assert_equal(200, response.status)
  end


  def test_post_organizations_good
    tmp_hash = {
     "name" => "orgname3"}
    response =megams.post_organizations(tmp_hash)
    response.body.to_s
    assert_equal(201, response.status)
  end

end
