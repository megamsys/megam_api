require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_predefcloud1
    tmp_hash = { :name => "aws_ec2_predef_medium", :spec => {
        :type_name => "aws-ec2",
        :groups => "megam",
        :image => "ami-d783cd85",
        :flavor => "m1.medium"
      },
      :access => {
        :ssh_key => "megam_ec2",
        :identity_file => "~/.ssh/megam_ec2.pem",
        :ssh_user => "ubuntu",
	:vault_location => "https://s3-ap-southeast-1.amazonaws.com/cloudkeys/sandy@megamsandbox.com/default"
      },
      #:ideal => "ror,redis,riak",
      #:performance => "10rpm"
    }

    response = megams.post_predefcloud(tmp_hash)
    assert_equal(201, response.status)
  end
#=end
  def test_post_predefcloud2
    tmp_hash = { :name => "rkspce_sundown_play", :spec => {
        :type_name => "rackspace",
        :groups => "staging_france_boeing",
        :image => "RCP000XERAOl",
        :flavor => "m1-miniscule"
      },
      :access => {
        :ssh_key => "boo_flightssh",
        :identity_file => "https://boering.dropbox.closedloc/aorc.pem",
        :ssh_user => "ubuntu",
	:vault_location => "https://s3-ap-southeast-1.amazonaws.com/cloudkeys/sandy@megamsandbox.com/default"
      },
      #:ideal => "play,redis,riak",
      #:performance => "10rpm"
    }
    response = megams.post_predefcloud(tmp_hash)
    assert_equal(201, response.status)
  end

#=begin
  def test_get_predefclouds
    response = megams.get_predefclouds
    assert_equal(200, response.status)
  end
#=end

  def test_get_predefcloud2
    response = megams.get_predefcloud("rkspce_sundown_play")
    assert_equal(200, response.status)
  end
#=begin
  def test_get_predefcloud1
    response = megams.get_predefcloud("iaas_default")
    assert_equal(200, response.status)
  end

def test_get_predefcloud_not_found
assert_raises(Megam::API::Errors::NotFound) do
megams.get_predefcloud("stupid.megam.co")
end
end
#=end
end

