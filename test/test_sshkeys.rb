require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
=begin
  def test_post_sshkey2
    tmp_hash = { :name => "test_sample",  :path => "https://s3-ap-southeast-1.amazonaws.com/cloudkeys/megam@mypaas.io/default"  }
    response = megams.post_sshkey(tmp_hash)
    assert_equal(201, response.status)
  end
=end
#=begin
  def test_get_sshkeys
    response = megams.get_sshkeys
    assert_equal(200, response.status)
  end
#=end
=begin
  def test_get_sshkey2
    response = megams.get_sshkey("rkspce_sundown_play")
    assert_equal(200, response.status)
  end
=end
=begin
  def test_get_sshkey1
    response = megams.get_sshkey("iaas_default")
    assert_equal(200, response.status)
  end

def test_get_sshkey_not_found
assert_raises(Megam::API::Errors::NotFound) do
megams.get_sshkey("stupid.megam.co")
end
end
=end
end
