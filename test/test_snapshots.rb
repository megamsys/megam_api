require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

    def test_post_snapshots
        tmp_hash = {
            :account_id => "test@megam.io",
            :asm_id => "ASM53557642376448623",
            :org_id => "ORG787966332632133788",
            :name => "pop.megambox.com",
            :status => "progress",
            :tosca_type => "torpedo",

        }

        response = megams.post_snapshots(tmp_hash)
        assert_equal(201, response.status)
    end
#=begin

    def test_get_snapshots
        response = megams.get_snapshots("ASM535576423764486230")
        assert_equal(200, response.status)
    end
    def test_list_snapshots
        response = megams.list_snapshots
        assert_equal(200, response.status)
    end
#=end
end
