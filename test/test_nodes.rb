require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase


  def test_post_node1

@com = {
"systemprovider" => {
"provider" => {
"prov" => "chef"
}
},
"compute" => {
"ec2" => {
"groups" => "megam",
"image" => "ami-d783cd85",
"flavor" => "t1.micro"
},
"access" => {
"ssh-key" => "megam_ec2",
"identity-file" => "~/.ssh/megam_ec2.pem",
"ssh-user" => "ubuntu"
}
},
"chefservice" => {
"chef" => {
"command" => "knife",
"plugin" => "ec2 server create",
"run-list" => "'role[opendj]'",
"name" => "TestOverAll"
}
}
}


    tmp_hash = {
      "node_name" => "morning.megam.co",
	"command" => "#{@com}",
      "predefs" => {"name" => "rails", "scm" => "https://github.com/temp.git",
        "db" => "postgres@postgresql1.megam.com/morning.megam.co", "war" => "http://s3pub.com/0.1/granny.war", "queue" => "queue@queue1"}
    }
    response = megams_new.post_node(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_post_node2
    tmp_hash = {
      "node_name" => "sundown.megam.co",
      "command" => "commands2",
      "predefs" => {"name" => "rails", "scm" => "https://github.com/awesome.git",
        "db" => "postgres@postgresql2.megam.com/morning.megam.co", "war" => "http://s3pub.com/0.1/orion.war", "queue" => "rabbit@queue1"}
    }
    response = megams.post_node(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_get_nodes
    response = megams.get_nodes
    assert_equal(200, response.status)
  end

  def test_get_node0
    response = megams.get_node("morning.megam.co")
    assert_equal(200, response.status)
  end
  
  def test_get_node1
    response = megams.get_node("sundown.megam.co")
    assert_equal(200, response.status)
  end

  def test_get_node_not_found
    assert_raises(Megam::API::Errors::NotFound) do
      megams.get_node("stupid.megam.co")
    end
  end
end

