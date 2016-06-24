require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

#=begin
  def test_get_eventsbilling
    tmp_hash = {
     "account_id" => "",
      "created_at" => "2016-05-05 10:57:30 +0000",
       "assembly_id" => "ASM9038606864211614815",
       "event_type" => "",
       "data" => []
   }
    response = megams.get_eventsbilling("0", tmp_hash)

    assert_equal(200, response.status)
  end

#=end
#=begin
def test_list_eventsbilling
  response = megams.list_eventsbilling("0")
  assert_equal(200, response.status)
end
def test_index_eventsbilling
  response = megams.index_eventsbilling
  assert_equal(200, response.status)
end
#=end
end
