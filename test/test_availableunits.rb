require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
#=begin
  def test_post_availableunits1
    tmp_hash = { :name => "name", 
                 :duration => "duration",
                 :charges_per_duration => "charges_per_duration"
    }

    response = megams.post_availableunits(tmp_hash)
    assert_equal(201, response.status)
  end
#=end

=begin
  def test_get_availableunits
    response = megams.get_availableunits
    assert_equal(200, response.status)
  end
=end
=begin
  def test_get_availableunits
    response = megams.get_availableunit("iaas_default")
    assert_equal(200, response.status)
  end
=end
end

