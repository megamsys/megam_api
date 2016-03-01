require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
=begin
def test_post_addon
@com = {
"disaster"=>{
"locations"=>"locations",
"fromhost"=>"appsample1.megam.co",
"tohosts"=>"appsample2.megam.co;appsample3.megam.co",
"recipe"=>"role[drbd]"
},
"loadbalancing"=>{
"haproxyhost"=>"",
"loadbalancehost"=>"",
"recipe"=>""
},
"autoscaling"=>{
"cputhreshold"=>"",
"memorythreshold"=>"",
"noofinstances"=>"",
"recipe"=>""
},
"monitoring"=>{
"agent"=>"op5",
"recipe"=>"role[op5]"
}
}

tmp_hash = {
"node_id" => "NOD450939631320432640",
"node_name" => "appsample1.megam.co",
"marketplace_id" => "APP",
"config" => @com
}
response = megams.post_addon(tmp_hash)
assert_equal(201, response.status)
end
#=end

 # def test_get_nodes
 #   response = megams.get_addons("appsample1.megam.co")
  #  assert_equal(200, response.status)
  #=end
=end
end
