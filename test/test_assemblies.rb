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
 def test_post_assembly
   tmp_hash =  {
      "name" => "testAsm",
     "org_id" => "ORG123",
     "assemblies" => [{
       "name" => "PaulineHarper",
       "components" => [{
        "name" => "GussieMathis",
        "tosca_type" => "tosca.web.riak",
        "inputs" => [],
        "status" => "",
        "related_components" => ["VernonDennis.megam.co"],
        "outputs" => [],
        "envs" => [{
            "key" => "REDIS_HOST",
            "value" => "tempp.megambox.com"
        }],
        "artifacts" => {
        "artifact_type" => "tosca_type",
        "content" => "",
        "artifact_requirements" => []
        },
        "operations" => [{
          "operation_type" => "CI",
          "description" => "continuous Integration",
          "properties" => []
           }],
           "repo" => {
             "rtype" => "image",
             "source" => "github",
             "oneclick" => "yes",
             "url" => "imagename"
           }
       }],
       "tosca_type" => "tosca.torpedo.coreos",
        "inputs" => [{
          "key" => "Domain",
          "value" => "megmbox.com"
        },
        {
          "key" => "sshKey",
          "value" => "rsa"
        }

        ],
      "outputs" => [],
      "status" => "",
      "policies" => [
       {
        "name" => "placement policy",
         "ptype" => "colocated",
         "members" => ["apache2-megam"]
       },
        {
         "name" => "HA policy",
        "ptype" => "colocated",
        "members" => ["apache2-megam"]
      },
      {
          "name" => "CPU scaling for apache2 server",
          "ptype" => "scaling",
          "members" => ["apache2-megam"],
          "rules" => {
            "name" => "cpu load",
             "type" => "cpu",
              "cpu_threshhold" => "80"
            }
          }
        ]
    } ],
     "inputs" => []
     }
   response = megams.post_assemblies(tmp_hash)
   assert_equal(200, response.status)
end
#=end
end
