#require File.expand_path("#{File.dirname(__FILE__)}/../test_helper")

gem 'minitest' # ensure we are using the gem version
require 'minitest/autorun'

require File.expand_path("#{File.dirname(__FILE__)}/../../lib/megam/mixins/assemblies")
class TestMixinsAssemblies < MiniTest::Unit::TestCase

#=begin
  def test_torpedo
    ## input the torpedo hash
    tmp_hash = {"utf8"=>"✓", "mkp_name" => "ubuntu", "cattype":"TORPEDO", "version":"14.04", "assemblyname"=>"biblical", "domain"=>"megambox.com", "ram"=>"896", "cpu"=>"0.5", "SSH_USEOLD_name"=>"tom", "SSH_NEW_name"=>"", "sshoption"=>"SSH_USEOLD", "provider"=>"one", "componentname"=>"ovid", "commit"=>" Create ", "controller"=>"marketplaces", "action"=>"create", "email"=>"8@8.com", "api_key"=>"-NQi-aSKHcmKntCsXb03jw==", "host"=>"192.168.1.105", "org_id"=>"ORG1270367691894554624", "ssh_keypair_name"=>"tom", "name"=>"tom", "path"=>"8@8.com_tom"}

    envs_hash = {"utf8"=>"✓", "authenticity_token"=>"EXNN8YBO01ebNv8RSbc3psdo+soP5Cxee8UXdi0qEdm78hkwKVIBaPzPh0IQBXcNtL6efvSkCbMkT1nca80zkA==", "version"=>"1.5.0", "mkp_name"=>"HotelManangement", "cattype"=>"ANALYTICS", "envs"=>[{"key":"spark_master","value":"<spark_master>"},{"key":"oja_assembly_id","value":"<oja_assembly_id>"},{"key":"file2","value":"<file2>"},{"key":"oja_email","value":"<oja_email>"},{"key":"oja_component_id","value":"<oja_component_id>"},{"key":"file1","value":"<file1>"},{"key":"oja_apikey","value":"<oja_apikey>"}], "assemblyname"=>"sweet", "domain"=>"megambox.com", "ram"=>"896", "cpu"=>"0.5", "SSH_USEOLD_name"=>"megam_sss", "SSH_NEW_name"=>"", "sshoption"=>"SSH_USEOLD", "provider"=>"one", "componentname"=>"minute", "commit"=>" Create "}
#{"utf8"=>"✓", "version"=>"14.04", "mkp_name"=>"ubuntu", "cattype"=>"TORPEDO", "assemblyname"=>"implanting", "domain"=>"megambox.com", "ram"=>"896", "cpu"=>"0.5", "SSH_USEOLD_name"=>"tom", "SSH_NEW_name"=>"", "sshoption"=>"SSH_USEOLD", "provider"=>"one", "componentname"=>"sad", "commit"=>" Create "}


#assemblies: [{"status"=>"launching", "tosca_type"=>"tosca.torpedo.ubuntu", "inputs"=>[{"key"=>"domain", "value"=>"megambox.com"}, {"key"=>"provider", "value"=>"one"}, {"key"=>"cpu", "value"=>"0.5"}, {"key"=>"ram", "value"=>"896"}, {"key"=>"version", "value"=>"14.04"}], "name"=>"implanting", "components"=>[], "outputs"=>[], "policies"=>[]}]

assembly_array = Megam::Mixins::Assemblies.new(envs_hash).to_hash
puts "=========================================> END <==============================================="
puts assembly_array.inspect

    #response = megams.post_billings(tmp_hash)
    #assert_equal(201, response.status)
  end
#=end
=begin
  def test_app_starterpack
    ## input the torpedo hash
    tmp_hash = {"utf8"=>"✓", "version"=>"8.x", "mkp_name"=>"Java", "cattype"=>"APP", "componentname"=>"marine", "sshoption"=>"SSH_NEW", "scm_name"=>"", "type"=>"source", "provider"=>"one", "assemblyname"=>"umiak", "domain"=>"megambox.com", "ram"=>"896", "cpu"=>"0.5", "radio_app_scm"=>"starter_pack", "source"=>"https://github.com/megamsys/java-spring-petclinic.git", "check_ci"=>"true", "starterpack_git"=>"https://github.com/megamsys/java-spring-petclinic.git", "SSH_NEW_name"=>"tom", "commit"=>" Create "}



    assembly_array = Megam::Mixins::Assemblies.new(tmp_hash).to_hash
puts "=========================================> END <==============================================="
puts assembly_array.inspect

  end
=begin
  def test_app_git
    ## input the torpedo hash
    tmp_hash = { :accounts_id => "ACT93476985797",
                 :line1 => "paypal",
                 :line2 => "#kjbh76",
                 :country_code => "",
                 :postal_code => "",
                 :state => "",
                 :phone => "",
                 :bill_type => ""
    }

    # comp_dable
    # compare the results
    response = megams.post_billings(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_app_oneclick
    ## input the torpedo hash
    tmp_hash = { :accounts_id => "ACT93476985797",
                 :line1 => "paypal",
                 :line2 => "#kjbh76",
                 :country_code => "",
                 :postal_code => "",
                 :state => "",
                 :phone => "",
                 :bill_type => ""
    }

    # comp_dable
    # compare the results
    response = megams.post_billings(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_service
    ## input the torpedo hash
    tmp_hash = { :accounts_id => "ACT93476985797",
                 :line1 => "paypal",
                 :line2 => "#kjbh76",
                 :country_code => "",
                 :postal_code => "",
                 :state => "",
                 :phone => "",
                 :bill_type => ""
    }

    # comp_dable
    # compare the results
    response = megams.post_billings(tmp_hash)
    assert_equal(201, response.status)
  end

  def test_microservice
    ## input the torpedo hash
    tmp_hash = { :accounts_id => "ACT93476985797",
                 :line1 => "paypal",
                 :line2 => "#kjbh76",
                 :country_code => "",
                 :postal_code => "",
                 :state => "",
                 :phone => "",
                 :bill_type => ""
    }

    # comp_dable
    # compare the results
    response = megams.post_billings(tmp_hash)
    assert_equal(201, response.status)
  end
=end
end
