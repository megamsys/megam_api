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
  class MakeCommand
    def megam_rest
      options = { :email => Megam::Config[:email], :api_key => Megam::Config[:api_key]}
      Megam::API.new(options)
    end

    def self.predef_clouds
      predef = self.new()
      pc_collection = predef.megam_rest.get_predefclouds
      pc_collection
    end

    def self.cloud_tools
      ct = self.new()
      ct_collection = ct.megam_rest.get_cloudtools
      ct_collection
    end

    def self.run(data, group, action, user)
      predef_cloud = predef_clouds.lookup("#{data[:cloud_book][:predef_cloud_name]}")
      tool = cloud_tools.lookup(data[:predef][:provider])
      template = tool.cloudtemplates.lookup(predef_cloud.spec[:type_name])
      cloud_instruction = template.lookup_by_instruction(group, action)
      ci_command = cloud_instruction.command
      ci_name = cloud_instruction.name

      hash = {
        "systemprovider" => {
          "provider" => {
            "prov" => "#{data[:predef][:provider]}"
          }
        },
        "compute" => {
          "cctype" => "#{predef_cloud.spec[:type_name]}",
          "cc"=> {
            "groups" => "#{predef_cloud.spec[:groups]}",
            "image" => "#{predef_cloud.spec[:image]}",
            "flavor" => "#{predef_cloud.spec[:flavor]}"
          },
          "access" => {
            "ssh_key" => "#{predef_cloud.access[:ssh_key]}",
            "identity_file" => user.email+"/"+"#{data[:cloud_book][:predef_cloud_name]}"+"/"+"#{predef_cloud.access[:identity_file]}",
            "ssh_user" => "#{predef_cloud.access[:ssh_user]}",
            "vault_location" => "#{predef_cloud.access[:vault_location]}",
            "sshpub_location" => "#{predef_cloud.access[:sshpub_location]}"
          }
        },
        "cloudtool" => {
          "chef" => {
            "command" => "#{tool.cli}",
            "plugin" => "#{template.cctype} #{ci_command}",
            "run_list" => "'role[#{data[:predef][:provider_role]}]'",
            "name" => "#{ci_name} #{data[:cloud_book][:name]}"
          }
        }
      }
      hash
    end
  =begin
  def self.create(data, group, action, user)
  com = run(data, group, action, user)

  node_hash = {
  "node_name" => "#{data[:cloud_book][:name]}#{data[:cloud_book][:domain_name]}",
  "node_type" => "#{data[:cloud_book][:book_type]}",
  "req_type" => "#{action}",
  "noofinstances" => data[:no_of_instances],
  "command" => com,
  "predefs" => {"name" => data[:predef][:name], "scm" => "#{data['deps_scm']}",
  "db" => "postgres@postgresql1.megam.com/morning.megam.co", "war" => "#{data[:deps_war]}", "queue" => "queue@queue1", "runtime_exec" => data[:predef][:runtime_exec]},
  "appdefns" => {"timetokill" => "", "metered" => "", "logging" => "", "runtime_exec" => ""},
  "boltdefns" => {"username" => "", "apikey" => "", "store_name" => "", "url" => "", "prime" => "", "timetokill" => "", "metered" => "", "logging" => "", "runtime_exec" => ""},
  "appreq" => {},
  "boltreq" => {}
  }

  if data[:cloud_book][:book_type] == "APP"
  node_hash["appdefns"] = {"timetokill" => "#{data['timetokill']}", "metered" => "#{data['monitoring']}", "logging" => "#{data['logging']}", "runtime_exec" => "#{data['runtime_exec']}"}
  end
  if data[:cloud_book][:book_type] == "BOLT"
  node_hash["boltdefns"] = {"username" => "#{data['user_name']}", "apikey" => "#{data['password']}", "store_name" => "#{data['store_db_name']}", "url" => "#{data['url']}", "prime" => "#{data['prime']}", "timetokill" => "#{data['timetokill']}", "metered" => "#{data['monitoring']}", "logging" => "#{data['logging']}", "runtime_exec" => "#{data['runtime_exec']}" }
  end

  end
  =end
  end
end
