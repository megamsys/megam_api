require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestApps < MiniTest::Unit::TestCase

=begin
  def test_post_predef
    tmp_hash = {
      "node_name" => "sundown.megam.co",
      "command" => "commands2",
      "predefs" => {"name" => "rails", "scm" => "https://github.com/awesome.git",
        "db" => "postgres@postgresql2.megam.com/morning.megam.co", "war" => "http://s3pub.com/0.1/orion.war", "queue" => "rabbit@queue1"}
    }
    response = megams.post_node(tmp_hash)
    assert_equal(201, response.status)
  end
=end

  def test_get_predefs
    response = megams.get_predefs
    assert_equal(200, response.status)
  end
  
  def test_get_predef_faulty
    response = megams.get_predef("faulty")
    assert_equal(200, response.status)
  end

  def test_get_predef_rails
    response = megams.get_predef("rails")
    assert_equal(200, response.status)
  end
  
  def test_get_predef_java
    response = megams.get_predef("java")
    assert_equal(200, response.status)
  end
  
  def test_get_predef_play
    response = megams.get_predef("play")
    assert_equal(200, response.status)
  end
  
  def test_get_predef_nodejs
    response = megams.get_predef("nodejs")
    assert_equal(200, response.status)
  end
  
  def test_get_predef_akka
    response = megams.get_predef("akka")
    assert_equal(200, response.status)
  end
  
  def test_get_predef_postgresql
    response = megams.get_predef("riak")
    assert_equal(200, response.status)
  end
  
  def test_get_predef_postgresql
    response = megams.get_predef("postgresql")
    assert_equal(200, response.status)
  end
  
  def test_get_predef_rabbitmq
    response = megams.get_predef("rabbitmq")
    assert_equal(200, response.status)
  end
  
  def test_get_predef_rabbitmq
    response = megams.get_predef("redis")
    assert_equal(200, response.status)
  end


end