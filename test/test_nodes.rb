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
"cctype" => "ec2",
"cc" => {
"groups" => "megam",
"image" => "ami-d783cd85",
"flavor" => "t1.micro"
},
"access" => {
"ssh_key" => "megam_ec2",
"identity_file" => "~/.ssh/megam_ec2.pem",
"ssh_user" => "ubuntu"
}
},
"cloudtool" => {
"chef" => {
"command" => "knife",
"plugin" => "ec2 server create", #ec2 server delete or create
"run_list" => "role[opendj]",
"name" => "-N TestOverAll"
}
}
}

    tmp_hash = {
      "node_name" => "night.megam.co",
      "node_type" => "BOLT", #APP or Bolt
      "req_type" => "create", #CREATE OR DELETE
      "noofinstances" => 2, # integer
	"command" => @com,
      "predefs" => {"name" => "rails", "scm" => "https://github.com/temp.git",
        "db" => "postgres@postgresql1.megam.com/night.megam.co", "war" => "http://s3pub.com/0.1/granny.war", "queue" => "queue@queue1"},
	"appdefns" => {"timetokill" => "timetokillTOM", "metered" => "meteredTOM", "logging" => "loggingTOM", "runtime_exec" => "runtime_execTOM"},
	"boltdefns" => {"username" => "tom", "apikey" => "123456", "store_name" => "tom_db", "url" => "", "prime" => "", "timetokill" => "", "metered" => "", "logging" => "", "runtime_exec" => ""},
	"appreq" => {},
	"boltreq" => {}
    }

puts "======================> TEMP HASH <============================================= "
puts tmp_hash.class
puts tmp_hash
    response = megams.post_node(tmp_hash)
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
    response = megams.get_node("night.megam.co")
puts "=================> Response ========>"
puts response.data.body.nodes
    assert_equal(200, response.status)
  end


=begin
  def test_get_node1
    response = megams.get_node("sundown.megam.co")
    assert_equal(200, response.status)
  end

  def test_get_node_not_found
    assert_raises(Megam::API::Errors::NotFound) do
      megams.get_node("stupid.megam.co")
    end
  end
=end
end

