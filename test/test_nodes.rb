require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase
  def test_get_nodes
    response = megam.get_nodes
    assert_equal(200, response.status)
  end

  def test_get_node
    name = random_name

    response = megam.get_node(name)
    assert_equal(200, response.status)
  end

  def test_get_node_not_found
    assert_raises(Megam::API::Errors::NotFound) do
      megam.get_node(random_name)
    end
  end

  def test_post_node
    response = megam.post_node
    assert_equal(202, response.status)
  end

  def test_post_node_with_name
    name = random_name
    response = megam.post_node('name' => name)
    assert_equal(202, response.status)
  end
  

end
