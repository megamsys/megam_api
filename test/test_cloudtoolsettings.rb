require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
=begin
  def test_post_cloudtoolsetting1
    tmp_hash = { :cloud_type => "chef", 
                 :repo => "https://github.com"
                 :vault_location => "https://s3-ap-southeast-1.amazonaws.com/cloudkeys/sandy@megamsandbox.com/default"  
    }

    response = megams.post_cloudtoolsetting(tmp_hash)
    assert_equal(201, response.status)
  end
=end
=begin
  def test_post_cloudtoolsetting2
    tmp_hash = { :cloud_type => "chef", 
                 :repo => "https://github.com",
                 :vault_location => "https://s3-ap-southeast-1.amazonaws.com/cloudkeys/sandy@megamsandbox.com/default"  
    }
    response = megams.post_cloudtoolsetting(tmp_hash)
    assert_equal(201, response.status)
  end
=end
#=begin
  def test_get_cloudtoolsettings
    response = megams.get_cloudtoolsettings
    assert_equal(200, response.status)
  end
#=end
=begin
  def test_get_cloudtoolsetting2
    response = megams.get_cloudtoolsetting("rkspce_sundown_play")
    assert_equal(200, response.status)
  end
#=begin
  def test_get_cloudtoolsetting1
    response = megams.get_cloudtoolsetting("iaas_default")
    assert_equal(200, response.status)
  end

def test_get_cloudtoolsetting_not_found
assert_raises(Megam::API::Errors::NotFound) do
megams.get_cloudtoolsetting("stupid.megam.co")
end
end
=end
end

