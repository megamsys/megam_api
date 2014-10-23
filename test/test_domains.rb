require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestDomains < MiniTest::Unit::TestCase

  $admin = "admin-tom"
  $normal = "normal-tom"
  $tom_email = "tom@gomegam.com"
  $bob_email = "bob@gomegam.com"

=begin
  def test_get_domains_good
    response =megams.get_domains(domain_name)
    response.body.to_s
    assert_equal(200, response.status)
  end

=end

  def test_post_domains_good
  tmp_hash = {
    "name" => "dmnname1"}

    response =megams1.post_domains(tmp_hash)
    response.body.to_s
    assert_equal(201, response.status)
  end

end
