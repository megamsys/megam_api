require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

#=begin
  def test_get_requests
    response = megams.get_requests
    assert_equal(200, response.status)
  end

  def test_get_request_faulty
    assert_raises(Megam::API::Errors::NotFound) do
      response = megams.get_request("faulty")
    end
  end
#=end
  def test_get_request_good
    response = megams.get_request("black1.megam.co")
    assert_equal(200, response.status)
  end


#=begin
@com = {
"systemprovider" => {
"provider" => {
"prov" => "chef"
}
},
"compute" => {
"cctype" => "ec2",
"cc" => {
"groups" => "",
"image" => "",
"flavor" => ""
},
"access" => {
"ssh_key" => "megam_ec2",
"identity_file" => "~/.ssh/megam_ec2.pem",
"ssh_user" => "",
"vault_location" => "https://s3-ap-southeast-1.amazonaws.com/cloudkeys/sandy@megamsandbox.com/default",
"sshpub_location" => "",
"zone" => ""
}
},
"cloudtool" => {
"chef" => {
"command" => "knife",
"plugin" => "ec2 server delete",
"run_list" => "",
"name" => ""
}
}
}

    @@tmp_hash = {
      "node_name" => "black1.megam.co",
      "node_type" => "APP", #APP or Bolt
      "req_type" => "delete",
      "noofinstances" => 0,
	"command" => @com,
      "predefs" => {"name" => "", "scm" => "", "db" => "", "war" => "", "queue" => ""},
	"appdefns" => {"timetokill" => "", "metered" => "", "logging" => "", "runtime_exec" => ""},
	"boltdefns" => {"username" => "", "apikey" => "", "store_name" => "", "url" => "", "prime" => "", "timetokill" => "", "metered" => "", "logging" => "", "runtime_exec" => ""},
	"appreq" => {},
	"boltreq" => {}
    }

  def test_request_node_delete

puts "======================> DELETE NODE Request TEMP HASH <============================================= "
puts @@tmp_hash
    response = megams.post_request(@@tmp_hash)
    assert_equal(201, response.status)
  end

  def test_request_node_stop
    @@tmp_hash["req_type"] = "stop"
    @@tmp_hash["command"]["cloudtool"]["chef"]["plugin"] = "ec2 server stop"
puts "======================> STOP NODE Request TEMP HASH <============================================= "
puts @@tmp_hash

    response = megams.post_request(@@tmp_hash)
    assert_equal(201, response.status)
  end
#=end
  
end
