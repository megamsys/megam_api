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
      "requirements" => {
        "host" => "clouddefault1139222212843274240",
        "dummy" => ""
      },
      "inputs" => {
        "domain" => "megam.co",
        "port" => "6379",
        "username" => "",
        "password" => "",
        "version" => "",
        "source" => "",
        "design_inputs" => {
          "id" => "39bb18e7.c644e8",
          "x" => "802",
          "y" => "331",
          "z" => "3f43bde9.c0bc42",
          "wires" => ["cae50d7.f351af"]
        },
        "service_inputs" => {
          "dbname" => "",
          "dbpassword" => ""
        }
      },
      "external_management_resource" => "",
      "artifacts" => {
        "artifact_type" => "tosca type",
        "content" => "",
        "artifact_requirements" => ""
      },
      "related_components" => "AntonioMcCormick.megam.co/TimothyHenderson",
      "operations" => {
        "operation_type" => "",
        "target_resource" => ""
      },
      "others" => [],
      "created_at" => "2014-10-29 14:06:39 +0000"
    }
    response = megams.update_component(tmp_hash)
    assert_equal(201, response.status)
  end

end