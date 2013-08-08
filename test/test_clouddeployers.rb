require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

  def test_post_clouddeployer1
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

    response = megams.post_clouddeployer(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_get_clouddeployers
    response = megams.get_clouddeployers
    assert_equal(200, response.status)
  end

  def test_get_clouddeployers1
    response = megams.get_clouddeployer("chef")
    assert_equal(200, response.status)
  end
  

  def test_get_clouddeployer_not_found
    assert_raises(Megam::API::Errors::NotFound) do
      megams.get_clouddeployer("stupid.megam.co")
    end
  end

end