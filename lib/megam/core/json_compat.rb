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

# Wrapper class for interacting with JSON.

require 'yajl/json_gem'
require 'yajl'

module Megam
  class JSONCompat
    JSON_MAX_NESTING = 1000

    JSON_CLAZ = "json_claz".freeze

    MEGAM_ACCOUNT                     = "Megam::Account".freeze
    MEGAM_ASSEMBLIES                  = "Megam::Assemblies".freeze
    MEGAM_ASSEMBLIESCOLLECTION        = "Megam::AssembliesCollection".freeze
    MEGAM_ASSEMBLY                    = "Megam::Assembly".freeze
    MEGAM_ASSEMBLYCOLLECTION          = "Megam::AssemblyCollection".freeze
    MEGAM_AUTH                        = "Megam::Auth".freeze
    MEGAM_AVAILABLEUNITS              = "Megam::Availableunits".freeze
    MEGAM_AVAILABLEUNITSCOLLECTION    = "Megam::AvailableunitsCollection".freeze
    MEGAM_BALANCES                    = "Megam::Balances".freeze
    MEGAM_BALANCESCOLLECTION          = "Megam::BalancesCollection".freeze
    MEGAM_BILLINGHISTORIES            = "Megam::Billinghistories".freeze
    MEGAM_BILLINGHISTORIESCOLLECTION  = "Megam::BillinghistoriesCollection".freeze
    MEGAM_BILLINGS                    = "Megam::Billings".freeze
    MEGAM_BILLINGSCOLLECTION          = "Megam::BillingsCollection".freeze
    MEGAM_CLOUDTOOLSETTING            = "Megam::CloudToolSetting".freeze
    MEGAM_CLOUDTOOLSETTINGCOLLECTION  = "Megam::CloudToolSettingCollection".freeze
    MEGAM_COMPONENTS                  = "Megam::Components".freeze
    MEGAM_COMPONENTSCOLLECTION        = "Megam::ComponentsCollection".freeze
    MEGAM_CREDITHISTORIES             = "Megam::Credithistories".freeze
    MEGAM_CREDITHISTORIESCOLLECTION   = "Megam::CredithistoriesCollection".freeze
    MEGAM_CSAR                        = "Megam::CSAR".freeze
    MEGAM_CSARCOLLECTION              = "Megam::CSARCollection".freeze
    MEGAM_DOMAIN                      = "Megam::Domains".freeze
    MEGAM_DISCOUNTS                   = "Megam::Discounts".freeze
    MEGAM_DISCOUNTSCOLLECTION         = "Megam::DiscountsCollection".freeze
    MEGAM_ERROR                       = "Megam::Error".freeze
    MEGAM_EVENT                       = "Megam::Event".freeze
    MEGAM_MARKETPLACE                 = "Megam::MarketPlace".freeze
    MEGAM_MARKETPLACECOLLECTION       = "Megam::MarketPlaceCollection".freeze
    MEGAM_MARKETPLACEADDON            = "Megam::MarketPlaceAddons".freeze
    MEGAM_MARKETPLACEADDONCOLLECTION  = "Megam::MarketPlaceAddonsCollection".freeze
    MEGAM_ORGANIZATION                = "Megam::Organizations".freeze
    MEGAM_ORGANIZATIONSCOLLECTION     = "Megam::OrganizationsCollection".freeze
    MEGAM_REQUEST                     = "Megam::Request".freeze
    MEGAM_REQUESTCOLLECTION           = "Megam::RequestCollection".freeze
    MEGAM_SSHKEY                      = "Megam::SshKey".freeze
    MEGAM_SSHKEYCOLLECTION            = "Megam::SshKeyCollection".freeze
    MEGAM_SUBSCRIPTIONS               = "Megam::Subscriptions".freeze
    MEGAM_SUBSCRIPTIONSCOLLECTION     = "Megam::SubscriptionsCollection".freeze
    MEGAM_PROMOS                      = "Megam::Promos".freeze


    class <<self
      # Increase the max nesting for JSON, which defaults
      # to 19, and isn't enough for some (for example, a Node within a Node)
      # structures.
      def opts_add_max_nesting(opts)
        if opts.nil? || !opts.has_key?(:max_nesting)
          opts = opts.nil? ? Hash.new : opts.clone
          opts[:max_nesting] = JSON_MAX_NESTING
        end
        opts
      end

      # Just call the JSON gem's parse method with a modified :max_nesting field
      def from_json(source, opts = {})
        obj = ::Yajl::Parser.parse(source)

        # JSON gem requires top level object to be a Hash or Array (otherwise
        # you get the "must contain two octets" error). Yajl doesn't impose the
        # same limitation. For compatibility, we re-impose this condition.
        unless obj.kind_of?(Hash) or obj.kind_of?(Array)
          raise JSON::ParserError, "Top level JSON object must be a Hash or Array. (actual: #{obj.class})"
        end

        # The old default in the json gem (which we are mimicing because we
        # sadly rely on this misfeature) is to "create additions" i.e., convert
        # JSON objects into ruby objects. Explicit :create_additions => false
        # is required to turn it off.
        if opts[:create_additions].nil? || opts[:create_additions]
          map_to_rb_obj(obj)
        else
        obj
        end
      end

      # Look at an object that's a basic type (from json parse) and convert it
      # to an instance of Megam classes if desired.
      def map_to_rb_obj(json_obj)

        case json_obj
        when Hash
          mapped_hash = map_hash_to_rb_obj(json_obj)

          if json_obj.has_key?(JSON_CLAZ) && (class_to_inflate = class_for_json_class(json_obj[JSON_CLAZ]))
          class_to_inflate.json_create(mapped_hash)

          else
          mapped_hash
          end
        when Array
          json_obj.map {|e| map_to_rb_obj(e)}
        else
        json_obj
        end
      end

      def map_hash_to_rb_obj(json_hash)
        json_hash.each do |key, value|
          json_hash[key] = map_to_rb_obj(value)
        end
        json_hash
      end

      def to_json(obj, opts = nil)
        obj.to_json(opts_add_max_nesting(opts))
      end

      def to_json_pretty(obj, opts = nil)
        ::JSON.pretty_generate(obj, opts_add_max_nesting(opts))
      end

      # Map +JSON_CLAZ+ to a Class object. We use a +case+ instead of a Hash
      # assigned to a constant because otherwise this file could not be loaded
      # until all the constants were defined, which means you'd have to load
      # the world to get json.
      def class_for_json_class(json_class)
        case json_class
        when MEGAM_ERROR
          Megam::Error
        when MEGAM_AUTH
          Megam::Auth
        when MEGAM_ACCOUNT
          Megam::Account
        when MEGAM_ASSEMBLIES
          Megam::Assemblies
        when MEGAM_ASSEMBLIESCOLLECTION
          Megam::AssembliesCollection
        when MEGAM_ASSEMBLY
          Megam::Assembly
        when MEGAM_ASSEMBLYCOLLECTION
          Megam::AssemblyCollection
        when MEGAM_COMPONENTS
          Megam::Components
        when MEGAM_COMPONENTSCOLLECTION
          Megam::ComponentsCollection
        when MEGAM_REQUEST
          Megam::Request
        when MEGAM_REQUESTCOLLECTION
          Megam::RequestCollection
        when MEGAM_SSHKEY
          Megam::SshKey
        when MEGAM_SSHKEYCOLLECTION
          Megam::SshKeyCollection
        when MEGAM_MARKETPLACE
          Megam::MarketPlace
        when MEGAM_MARKETPLACECOLLECTION
          Megam::MarketPlaceCollection
        when MEGAM_MARKETPLACEADDON
          Megam::MarketPlaceAddons
        when MEGAM_MARKETPLACEADDONCOLLECTION
          Megam::MarketPlaceAddonsCollection
        when MEGAM_ORGANIZATION
          Megam::Organizations
        when MEGAM_ORGANIZATIONSCOLLECTION
          Megam::OrganizationsCollection
        when MEGAM_CSAR
          Megam::CSAR
        when MEGAM_CSARCOLLECTION
          Megam::CSARCollection
        when MEGAM_DOMAIN
          Megam::Domains
        when MEGAM_EVENT
          Megam::Event
        when MEGAM_AVAILABLEUNITS
          Megam::Availableunits
        when MEGAM_AVAILABLEUNITSCOLLECTION
          Megam::AvailableunitsCollection
        when MEGAM_BALANCES
          Megam::Balances
        when MEGAM_BALANCESCOLLECTION
          Megam::BalancesCollection
        when MEGAM_BILLINGHISTORIES
          Megam::Billinghistories
        when MEGAM_BILLINGHISTORIESCOLLECTION
          Megam::BillinghistoriesCollection
        when MEGAM_BILLINGS
          Megam::Billings
        when MEGAM_BILLINGSCOLLECTION
          Megam::BillingsCollection
        when MEGAM_CREDITHISTORIES
          Megam::Credithistories
        when MEGAM_CREDITHISTORIESCOLLECTION
          Megam::CredithistoriesCollection
        when MEGAM_DISCOUNTS
          Megam::Discounts
        when MEGAM_DISCOUNTSCOLLECTION
          Megam::DiscountsCollection
        when MEGAM_SUBSCRIPTIONS
          Megam::Subscriptions
        when MEGAM_SUBSCRIPTIONSCOLLECTION
          Megam::SubscriptionsCollection
        when MEGAM_PROMOS
          Megam::Promos
        else
        raise JSON::ParserError, "Unsupported `json_class` type '#{json_class}'"
        end
      end

    end
  end
end
