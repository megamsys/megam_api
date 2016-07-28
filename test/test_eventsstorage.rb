require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
    def test_list_eventsstorage
        response = megams.list_eventsstorage("0")
        assert_equal(200, response.status)
    end
    def test_index_eventsstorage
        response = megams.index_eventsstorage
        assert_equal(200, response.status)
    end
end
