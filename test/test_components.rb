require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
  def test_get_component
    response = megams.get_components("COM519839138036318208")
    assert_equal(200, response.status)
  end

  def test_update_component
    tmp_hash = {
      "id" => "COM1139245887592202240",
      "name" => "NettieMoore",
      "tosca_type" => "tosca.web.redis",      
      "inputs" => [],
      "outputs" => [],
      "artifacts" => {
        "artifact_type" => "tosca type",
        "content" => "",
        "artifact_requirements" => []
      },
      "related_components" => "AntonioMcCormick.megam.co/TimothyHenderson",
      "operations" => [],
      "status" => "",
      "created_at" => "2014-10-29 14:06:39 +0000"
    }
    response = megams.update_component(tmp_hash)
    assert_equal(201, response.status)
  end

end