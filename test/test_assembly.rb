require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

#=begin
  def test_get_assembly
    response = megams.get_one_assembly("ASM5405446528593826612")
    puts response.inspect
    assert_equal(200, response.status)
  end
#=end
=begin
  def test_update_assembly
    tmp_hash =  {

      "id" => "ASM6175632897198829431",
      "org_id" => "ORG123",
      "json_claz" => "Megam::Assembly",
      "name" => "calcines",
      "tosca_type" => "tosca.app.java",
      "components" => ["COM1265630517194260480",""],
      "policies" => [{
          "name" => "bind policy",
          "ptype" => "colocated",
          "members" => ["calcines.megam.co/MattieGarcia","calcines.megam.co/parsnip"]
        }],
      "inputs" => [],
     "output" => [],
      "status" => "Launching",
      "state" => "Launching",
      "created_at" => "2015-10-12 13:24:06 +0000"
    }
    response = megams.update_assembly(tmp_hash)
    assert_equal(201, response.status)
    end
=end
end
