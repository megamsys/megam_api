require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

  def test_post_predefcloud1
    tmp_hash = { :name => "aws_morning_rails", :spec => {
        :type_name => "aws-ec2",
        :groups => "dev_india_corsproject",
        :image => "AWXI0E009",
        :flavor => "t1-micro"
      },
      :access => {
        :ssh_key => "cors_securessh",
        :identity_file => "https://s3.closedloc/aorc.pem",
        :ssh_user => "ubuntu"
      },
      :ideal => "ror,redis,riak",
      :performance => "10rpm"
    }

      options = { :email => "a@b.com", :api_key => "iShmBtKrP99lUO0ggDBhDQ==" }
me = megams_new.new(options)
    response = me.post_predefcloud(tmp_hash)
    assert_equal(201, response.status)
  end
=begin
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
        :ssh_user => "ubuntu"
      },
      :ideal => "play,redis,riak",
      :performance => "10rpm"
    }
    response = megams.post_predefcloud(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_get_predefclouds
    response = megams.get_predefclouds
    assert_equal(200, response.status)
  end

  def test_get_predefcloud2
    response = megams.get_predefcloud("aws_morning_rails")
    assert_equal(200, response.status)
  end

  def test_get_predefcloud1
    response = megams.get_predefcloud("rkspce_sundown_play")
    assert_equal(200, response.status)
  end

  def test_get_predefcloud_not_found
    assert_raises(Megam::API::Errors::NotFound) do
      megams.get_predefcloud("stupid.megam.co")
    end
  end
=end
end

