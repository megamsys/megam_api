require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
  def test_get_assembly
    response = megams.get_one_assembly("ASM1133747830209511424")
    assert_equal(200, response.status)
  end

  def test_update_assembly
    tmp_hash = {
      "id" => "ASM1139235178976247808",
      "json_claz" => "Megam::Assembly",
      "name" => "calcines",
      "tosca_type" => "",
      "components" => ["COM1139235178934304768",""],
      "policies" => [{
          "name" => "bind policy",
          "ptype" => "colocated",
          "members" => ["calcines.megam.co/MattieGarcia","calcines.megam.co/parsnip"]
        }],
      "inputs" => [],
      "operations" => [],
      "output" => [],
      "status" => "Launching",
      "created_at" => "2014-10-29 13:24:06 +0000"
    }

    response = megams.update_assembly(tmp_hash)
    assert_equal(201, response.status)
  end

end
