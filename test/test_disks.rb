require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
    def test_post_disks
        tmp_hash = {
            :account_id => "",
            :asm_id => "ASM53557642376448625",
            :org_id => "ORG7879663326321337888",
            :size => "2GB",
            :status => "progress",

        }

        response = megams.post_disks(tmp_hash)
        assert_equal(201, response.status)
    end
    def test_get_disks
        response = megams.get_disks("ASM53557642376448625")
        assert_equal(200, response.status)
    end
    def test_list_disks
        response = megams.list_disks
        assert_equal(200, response.status)
    end
end
