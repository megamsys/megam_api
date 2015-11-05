gem 'minitest' # ensure we are using the gem version
require 'minitest/autorun'

require File.expand_path("#{File.dirname(__FILE__)}/../../lib/megam/mixins/components")

class TestMixinsComponent < MiniTest::Unit::TestCase

  def test_app_starterpack
    ## input the torpedo hash
    tmp_hash = {"utf8"=>"✓", "version"=>"8.x", "mkp_name"=>"Java", "cattype"=>"APP", "componentname"=>"marine", "sshoption"=>"SSH_NEW", "scm_name"=>"", "type"=>"source", "provider"=>"one", "assemblyname"=>"umiak", "domain"=>"megambox.com", "ram"=>"896", "cpu"=>"0.5", "radio_app_scm"=>"starter_pack", "source"=>"https://github.com/megamsys/java-spring-petclinic.git", "check_ci"=>"true", "starterpack_git"=>"https://github.com/megamsys/java-spring-petclinic.git", "SSH_NEW_name"=>"tom", "commit"=>" Create "}

	tmp_hash = Hash[tmp_hash.map{ |k, v| [k.to_sym, v] }]
    assembly_array = Megam::Mixins::Components.new(tmp_hash).to_hash
puts "=========================================> END <==============================================="
puts assembly_array.inspect

  end

end
