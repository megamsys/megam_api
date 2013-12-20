# Copyright:: Copyright (c) 2012, 2013 Megam Systems
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module Megam
  class MakeNode
    def megam_rest
      options = { :email => Megam::Config[:email], :api_key => Megam::Config[:api_key]}
      Megam::API.new(options)
    end

    def self.create(data, group, action)

      make_command = self.new()
      begin
        pc_collection = make_command.megam_rest.get_predefclouds        
        ct_collection = make_command.megam_rest.get_cloudtools          
        cts_collection = make_command.megam_rest.get_cloudtoolsettings                
      rescue ArgumentError => ae
        hash = {"msg" => ae.message, "msg_type" => "error"}
        re = Megam::Error.from_hash(hash)        
        return re
      rescue Megam::API::Errors::ErrorWithResponse => ewr
        hash = {"msg" => ewr.message, "msg_type" => "error"}
        re = Megam::Error.from_hash(hash)  
        return re
      rescue StandardError => se
        hash = {"msg" => se.message, "msg_type" => "error"}
        re = Megam::Error.from_hash(hash)        
      return re
      end      
      predef_cloud = pc_collection.data[:body].lookup("#{data[:predef_cloud_name]}")      
      tool = ct_collection.data[:body].lookup(data[:provider])      
      template = tool.cloudtemplates.lookup(predef_cloud.spec[:type_name])      
      cloud_instruction = template.lookup_by_instruction(group, action)
      cts = cts_collection.data[:body].lookup(data[:repo])      
      ci_command = "#{cloud_instruction.command}"       
      if ci_command["<node_name>"].present?     
      ci_command["<node_name>"] = "#{data[:book_name]}"
      end                
      u = URI.parse(predef_cloud.access[:vault_location])
      u.path[0]=""
      if ci_command["-f"].present?     
      ci_command["-f"] = "-f " + u.path + "/" + predef_cloud.spec[:type_name] + ".json"     
      end      
      if ci_command["-c"].present?  
      ci_command["-c"] = "-c #{cts.conf_location}"      
      end      
      ci_name = cloud_instruction.name
      command_hash = {
        "systemprovider" => {
          "provider" => {
            "prov" => "#{data[:provider]}"
          }
        },
        "compute" => {
          "cctype" => "#{predef_cloud.spec[:type_name]}",
          "cc"=> {
            "groups" => "#{predef_cloud.spec[:groups]}",
            "image" => "#{predef_cloud.spec[:image]}",
            "flavor" => "#{predef_cloud.spec[:flavor]}",
            "tenant_id" => "#{predef_cloud.spec[:tenant_id]}"
          },
          "access" => {
            "ssh_key" => "#{predef_cloud.access[:ssh_key]}",
            "identity_file" => "#{predef_cloud.access[:identity_file]}",
            "ssh_user" => "#{predef_cloud.access[:ssh_user]}",
            "vault_location" => "#{predef_cloud.access[:vault_location]}",
            "sshpub_location" => "#{predef_cloud.access[:sshpub_location]}",
            "zone" => "#{predef_cloud.access[:zone]}",
            "region" => "#{predef_cloud.access[:region]}"
          }
        },
        "cloudtool" => {
          "chef" => {
            "command" => "#{tool.cli}",
            "plugin" => "#{template.cctype} #{ci_command}",
            "run_list" => "'role[#{data[:provider_role]}]'",
            "name" => "#{ci_name} #{data[:book_name]}"
          }
        }
      }

      node_hash = {
        "node_name" => "#{data[:book_name]}#{data[:domain_name]}",
        "node_type" => "#{data[:book_type]}",
        "req_type" => "#{action}",
        "noofinstances" => data[:no_of_instances],
        "command" => command_hash,
        "predefs" => {"name" => data[:predef_name], "scm" => "#{data[:deps_scm]}",
          "db" => "postgres@postgresql1.megam.com/morning.megam.co", "war" => "#{data[:deps_war]}", "queue" => "queue@queue1", "runtime_exec" => data[:runtime_exec]},
        "appdefns" => {"timetokill" => "", "metered" => "", "logging" => "", "runtime_exec" => ""},
        "boltdefns" => {"username" => "", "apikey" => "", "store_name" => "", "url" => "", "prime" => "", "timetokill" => "", "metered" => "", "logging" => "", "runtime_exec" => ""},
        "appreq" => {},
        "boltreq" => {}
      }

      if data[:book_type] == "APP"
        node_hash["appdefns"] = {"timetokill" => "#{data[:timetokill]}", "metered" => "#{data[:metered]}", "logging" => "#{data[:logging]}", "runtime_exec" => "#{data[:runtime_exec]}"}
      end
      if data[:book_type] == "BOLT"
        node_hash["boltdefns"] = {"username" => "#{data['user_name']}", "apikey" => "#{data['password']}", "store_name" => "#{data['store_db_name']}", "url" => "#{data['url']}", "prime" => "#{data['prime']}", "timetokill" => "#{data['timetokill']}", "metered" => "#{data['monitoring']}", "logging" => "#{data['logging']}", "runtime_exec" => "#{data['runtime_exec']}" }
      end      
      node_hash
    end
  end
end
