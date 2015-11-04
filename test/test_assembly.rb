require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_assembly
    tmp_hash = { "name" => "calcines",
      "components" => ["COM1270769168056188928",""],
      "tosca_type" => "",
    "policies" => [{
        "name" => "bind policy",
        "ptype" => "colocated",
        "members" => ["calcines.megam.co/MattieGarcia","calcines.megam.co/parsnip"]
      }],
    "inputs" => [],
   "output" => [],
    "status" => "Launching",
    "created_at" => "2015-10-12 13:24:06 +0000"

    }

    response = megams.post_assembly(tmp_hash)
    assert_equal(201, response.status)
  end
#=end
=begin
  def test_get_assembly
    response = megams.get_one_assembly("ASY1273588307275677696")
    assert_equal(200, response.status)
  end
=end
=begin
  def test_update_assembly
    tmp_hash =  {

      "id" => "ASM1265630517177483264",
      "json_claz" => "Megam::Assembly",
      "name" => "calcines",
      "tosca_type" => "",
      "components" => ["COM1265630517194260480",""],
      "policies" => [{
          "name" => "bind policy",
          "ptype" => "colocated",
          "members" => ["calcines.megam.co/MattieGarcia","calcines.megam.co/parsnip"]
        }],
      "inputs" => [],
     "output" => [],
      "status" => "Launching",
      "created_at" => "2015-10-12 13:24:06 +0000"
    }
    response = megams.update_assembly(tmp_hash)
    assert_equal(201, response.status)
    end
=end
end
