require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestOrganizations < MiniTest::Unit::TestCase

  $admin = "admin-tom"
  $normal = "normal-tom"
  $tom_email = "tom@gomegam.com"
  $bob_email = "bob@gomegam.com"


=begin
  def test_post_organizations_good
    tmp_hash = {
     "name" => "org.megam1"}
    response =megams.post_organization(tmp_hash)
    assert_equal(201, response.status)
  end
=end
#=begin
def test_get_organizations_good1
    response =megams.get_organizations
     assert_equal(200, response.status)
 end
#=end
=begin
def test_update_organizations
  tmp_hash = {
     "id" => "ORG123",
     "accounts_id" => "ACT123123",
     "name" => "org1",
     "related_orgs" => ["etst"],
     "created_at" => ""
  }
  response = megams.update_organization(tmp_hash)
  response.body.to_s
  assert_equal(201, response.status)
   end
=end
=begin
def test_get_organization
  response = megams.get_organization("ORG1257711897088753664")
  assert_equal(200, response.status)
end
=end
end
