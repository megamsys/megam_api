require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_get_component
    response = megams.get_components("COM6782254747239955545")
    assert_equal(200, response.status)
  end
#=end
#=begin
  def test_update_component
    tmp_hash = {
      "id" => "COM6782254747239955545",
      "name" => "NettieMoore",
      "tosca_type" => "tosca.web.redis",
      "inputs" => [],
      "outputs" => [],
      "envs" => [
      {
           "key" => "REDIS_HOST",
           "value" => "tempp.megambox.com"
       },
    ],
      "artifacts" => {
        "artifact_type" => "tosca type",
        "content" => "",
        "artifact_requirements" => []
      },
      "related_components" => ["AntonioMcCormick.megam.co/TimothyHenderson"],
      "operations" => [],
      "repo" => {
        "rtype" => "image", "source" => "github", "oneclick" => "yes", "url" => "imagename"},

      "status" => "",
      "created_at" => "2014-10-29 14:06:39 +0000"
    }
    response = megams.update_component(tmp_hash)
    assert_equal(201, response.status)
  end
#=end
end
