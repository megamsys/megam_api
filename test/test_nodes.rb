require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

=begin
#Yet to be tested
  def test_get_nodes
    response = megams.get_nodes
    assert_equal(200, response.status)
  end

#Yet to be tested
  def test_get_node
    name = random_name
    response = megams.get_node(name)
    assert_equal(200, response.status)
  end

#Yet to be tested
  def test_get_node_not_found
    assert_raises(Megam::API::Errors::NotFound) do
      megam.get_node(random_name)
    end
  end

#Yet to be tested
  def test_post_node_with_name
    name = random_name
    response = megams.post_node('name' => name)
    assert_equal(202, response.status)
  end

#Get node details gives 400 Bad Request error
#It gets the node_id as input
  def test_get_node
    #name = random_name
    name = "content1"
    response = megams.get_node(name)
    assert_equal(200, response.status)
  end

end

#The above testings are yet to be tested

#Successful testing

#Post node successfully post the json in riak
#Send sandbox_email, sandbox_apikey as arguement to aunthenticate user.
#nodes.rb contains the json data to be posted in riak.
=end
  def test_post_node
    response = megams.post_node()
    assert_equal(200, response.status)
  end
end



