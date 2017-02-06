require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

    def test_post_quotas
        tmp_hash = {
            "name"=>"cloud-s01",
            "account_id"=>"test@megam.io",
            "allowed"=>[
            {
                 "key" => "ram",
                 "value" => "4GB"
             },
             {
                  "key" => "cpu",
                  "value" => "2cores"
              },
              {
                   "key" => "disk",
                   "value" => "10GB"
               },
          ],
            "allocated_to" => "",
            "quota_type"=> "vm",
            "status" => "active",
            "inputs" => [],

}

        response = megams.post_quotas(tmp_hash)
        assert_equal(201, response.status)
    end
  end
