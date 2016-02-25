require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

#=begin
  def test_get_assemblies
   response = megams.get_assemblies
   assert_equal(200, response.status)
 end
#=end
#=begin
 def test_get_assembly
   response = megams.get_one_assemblies("AMS5105841605333553811")
   assert_equal(200, response.status)
 end
#=end

#=begin
 def test_post_assembly
   tmp_hash =  {
     "name"=>"",
     "org_id"=>"ORG123",
     "assemblies"=>[{
       "name"=>"covey",
       "tosca_type"=>"tosca.app.java",
       "inputs"=>[
         {"key"=>"domain","value"=>"megambox.com"},
         {"key"=>"sshkey","value"=>"a@b.com_rtr"},
         {"key"=>"provider","value"=>"one"},
         {"key"=>"cpu","value"=>"0.5"},
         {"key"=>"ram","value"=>"896"},
         {"key"=>"version","value"=>"8.x"},
         {"key"=>"lastsuccessstatusupdate","value"=>"02 Feb 16 13:20 IST"},
         {"key"=>"status","value"=>"error"}
         ],
       "outputs"=>[],
       "policies"=>[],
       "status"=>"error",
       "created_at"=>"2016-02-02 07:50:49 +0000",
       "components"=>[
         {
           "name"=>"sheba",
           "tosca_type"=>"tosca.app.java",
           "inputs"=>[
             {"key"=>"domain","value"=>"megambox.com"},
             {"key"=>"sshkey","value"=>"a@b.com_rtr"},
             {"key"=>"provider","value"=>"one"},
             {"key"=>"cpu","value"=>"0.5"},
             {"key"=>"ram","value"=>"896"},
             {"key"=>"version","value"=>"8.x"},
             {"key"=>"lastsuccessstatusupdate","value"=>"02 Feb 16 13:20 IST"},
             {"key"=>"status","value"=>"error"}
             ],
           "outputs"=>[],
           "envs"=>[
             {"key"=>"port","value"=>"8080"},
             {"key"=>"tomcat_username","value"=>"megam"},
             {"key"=>"tomcat_password","value"=>"megam"}
             ],
           "repo"=>{
             "rtype"=>"source",
             "source"=>"github",
             "oneclick"=>"","url"=>"https://github.com/rajthilakmca/java-spring-petclinic.git"
             },
            "artifacts"=>{"artifact_type"=>"","content"=>"","requirements"=>[]},
            "related_components"=>[],
            "operations"=>[{
              "operation_type"=>"CI",
              "description"=>"always up to date code. sweet.",
              "properties"=>[
                {"key"=>"type","value"=>"github"},
                {"key"=>"token","value"=>"066b697558f048459412410483ca8965415bf7de"},
                {"key"=>"username","value"=>"rajthilakmca"}],
              "status"=>"notbound"}],
              "status"=>"error"}]}],
              "inputs"=>[
                {"key"=>"domain","value"=>"megambox.com"},
                {"key"=>"sshkey","value"=>"a@b.com_rtr"},
                {"key"=>"provider","value"=>"one"},
                {"key"=>"cpu","value"=>"0.5"},
                {"key"=>"ram","value"=>"896"},
                {"key"=>"version","value"=>"8.x"},
                {"key"=>"lastsuccessstatusupdate","value"=>"02 Feb 16 13:20 IST"},
                {"key"=>"status","value"=>"error"}]
                }

   response = megams.post_assemblies(tmp_hash)
   assert_equal(200, response.status)
end
#=end
end
