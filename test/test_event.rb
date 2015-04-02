require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
  def test_get_events
   
  end

  def test_post_event()
    tmp_hash = {
      "id" => "ASM1139235178976247808",
      "name" => "calcines",
      
      "command" => "Start",
      "type" => "APP",
    }

    response = megams.post_event(tmp_hash)
    assert_equal(201, response.status)
  end

end
