require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestMarketplaces < MiniTest::Unit::TestCase
=begin
def test_post_marketplace
    tmp_hash = {      
      "name" => "sample",
      "appdetails" => {"logo" => "logo", "category"=> "catagroy", "description"=> "description"},
      "features" => {"feature1" => "feature1","feature2" => "feature2","feature3" => "feature3","feature4" => "feature4"},
      "plans" => [{"price"=> "30", "description"=> "description", "plantype"=> "paid", "version"=> "0.1", "source"=> "source"}],  
      "applinks" => {"free_support"=> "String", "paid_support"=> "String", "home_link"=> "String", "info_link"=> "String", "content_link"=> "String", "wiki_link"=> "String", "source_link"=> "String"},   
      "attach" => "attach",
      "predefnode" => "predefnode",
      "approved" => "approved" }

    response = megams.post_marketplaceapp(tmp_hash)
    assert_equal(201, response.status)
  end
=end  
=begin
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

  def test_get_marketplaces
    response = megams.get_marketplaceapps
    assert_equal(200, response.status)
  end
=end
#=begin
  def test_get_node0
    response = megams.get_marketplaceapp("34-Trac")    
    assert_equal(200, response.status)
  end
#=end  
=begin
  def test_get_node1
    response = megams.get_node("night.megam.co")
    assert_equal(200, response.status)
  end

  def test_get_node_not_found
    assert_raises(Megam::API::Errors::NotFound) do
      megams.get_node("stupid.megam.co")
    end
  end

  def test_delete_node1

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
"flavor" => "",
"tenant_id" => ""
},
"access" => {
"ssh_key" => "megam_ec2",
"identity_file" => "~/.ssh/megam_ec2.pem",
"ssh_user" => "",
"vault_location" => "https://s3-ap-southeast-1.amazonaws.com/cloudkeys/sandy@megamsandbox.com/default",
"sshpub_location" => "",
"zone" => "",
"region" => "region"
}
},
"cloudtool" => {
"chef" => {
"command" => "knife",
"plugin" => "ec2 server delete", #ec2 server delete or create
"run_list" => "",
"name" => ""
}
}
}

    tmp_hash = {
      "node_name" => "black1.megam.co",
      "req_type" => "delete", #CREATE OR DELETE
      "command" => @com
    }

    response = megams.post_request(tmp_hash)
    assert_equal(201, response.status)
  end
=end  
end
