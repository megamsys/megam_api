require File.expand_path("#{File.dirname(__FILE__)}/megam_attributes")

module Megam
    class Mixins
        class CommonDeployable
            include Nilavu::MegamAttributes
            attr_reader :status, :state, :inputs, :tosca_type

              DEFAULT_VERTICE_PREFIX  = 'vertice'.freeze
              DEFAULT_BITNAMI_PREFIX  = 'bitnami'.freeze
              DEFAULT_DOCKER_PREFIX   = 'docker'.freeze

            ATTRIBUTES = [
                :tosca_type,
                :status,
                :state,
            :inputs]

            def attributes
                ATTRIBUTES
            end

            def initialize(params)
                @tosca_type = ''
                @status = 'initialized'
                @state = 'initialized'
                bld_toscatype(params)
                set_attributes(params)
                @inputs = InputGroupData.new(params)

            end

            def to_hash
                h = {
                    status: status,
                    state: state,
                    tosca_type: tosca_type,
                    inputs: inputs.to_hash
                }
            end

            def bld_toscatype(params)
                case params[:scm_name]
              when DEFAULT_BITNAMI_PREFIX
                @tosca_type = DEFAULT_BITNAMI_PREFIX + ".#{params[:cattype].downcase}.#{params[:mkp_name].downcase}" if params[:cattype] != nil  && params[:mkp_name] != nil
              when DEFAULT_DOCKER_PREFIX
                @tosca_type = DEFAULT_DOCKER_PREFIX + ".#{params[:cattype].downcase}.#{params[:mkp_name].downcase}" if params[:cattype] != nil  && params[:mkp_name] != nil
              else
                @tosca_type = DEFAULT_VERTICE_PREFIX + ".#{params[:cattype].downcase}.#{params[:mkp_name].downcase}" if params[:cattype] != nil  && params[:mkp_name] != nil
              end

            end
        end

        class InputGroupData
            include Nilavu::MegamAttributes

            attr_reader :domain, :keypairoption, :root_password, :sshkey, :provider, :cpu, :ram, :hdd,
            :version, :display_name, :password, :region, :resource, :storage_hddtype,
            :public_ipv4, :private_ipv4, :public_ipv6, :private_ipv6, :bitnami_username, :bitnami_password, :root_username, :backup, :backup_name, :quota_ids,
            :vm_cpu_cost_per_hour, :vm_ram_cost_per_hour,
            :vm_disk_cost_per_hour, :container_cpu_cost_per_hour, :container_memory_cost_per_hour,:app_username, :app_password

            ATTRIBUTES = [
                :domain,
                :keypairoption,
                :root_password,
                :sshkey,
                :provider,
                :cpu,
                :ram,
                :hdd,
                :version,
                :display_name,
                :password,
                :region,
                :resource,
                :storage_hddtype,
                :private_ipv4,
                :public_ipv4,
                :private_ipv6,
                :public_ipv6,
                :bitnami_password,
                :bitnami_username,
                :app_username,
                :app_password,
                :root_username,
                :backup,
                :backup_name,
                :quota_ids,
                :vm_cpu_cost_per_hour,
                :vm_ram_cost_per_hour,
                :vm_disk_cost_per_hour,
                :container_cpu_cost_per_hour,
                :container_memory_cost_per_hour]

            def attributes
                ATTRIBUTES
            end

            def initialize(params)
                set_attributes(params)
            end

        end
    end
end
