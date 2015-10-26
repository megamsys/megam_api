require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

=begin
  def test_get_assemblies
   response = megams.get_assemblies
   assert_equal(200, response.status)
 end
=end
=begin
 def test_get_assembly
   response = megams.get_one_assemblies("AMS1257720849197301760")
   assert_equal(200, response.status)
 end
=end

#=begin
 def test_post_sensor
   tmp_hash =  {

        "sensor_type" => "compute.instance.launch",

        "payload" => {
          "accounts_id" => "ACT000000111",
          "assemblies_id" => "ASM000001",
          "assembly_id" => "AMS0000001",
          "component_id" => "CMP0000001",
        "state" => "active",
          "source" => "one",
          "node" => "192.168.1.100",
          "message" => "Periodic billing event",
          "audit_period_begining" => "2015-10-09:01:01:01",
          "audit_period_ending" => "2015-10-09:01:10:01",
          "metrics" => [ {
            "metric_type" => "delta",
             "metric_value" => 42,
             "metric_units" => "hits",
             "metric_name" => "queries"

          }
            ]
     }

     }
   response = megams.post_sensor(tmp_hash)
   assert_equal(200, response.status)
end
#=end
end
