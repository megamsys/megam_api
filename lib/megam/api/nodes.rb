module Megam
  class API

#Yet to be tested
    # GET /nodes
    def get_nodes(email)
      @options = {:path => '/nodes',
        :body => OkJson.encode({"email" => "#{email}"})}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        #:path     => @options[:path],
        :body     => @options[:body]
      )
    end

#Yet to be tested
    # GET /nodes/:id
    def get_node(node_id)
      @options = {:path => "/nodes/#{node_id}",
        :body => OkJson.encode({"node_id" => "#{node_id}"})}.merge(@options)

      request(
        :expects  => 200,
        :method   => :get,
        #:path     => @options[:path],
        :body     => @options[:body]
      )
    end
#successful Testing
    # POST /nodes/content
    # The body content needs to be a json.
    # The OkJson takes a hash of strings so use your symbols and build the json that is needed to be sent.

    def post_node()
      @options = {:path => '/nodes/content', :body => OkJson.encode(
=begin
{
    "systemprovider" => {
        "provider" => {
            "prov" => "chef"
        }
    },
    "compute" => {
        "ec2" => {
            "groups" => "megam",
            "image" => "ami-d783cd85",
            "flavor" => "t1.micro"
        },
        "access" => {
            "ssh-key" => "megam_ec2",
            "identity-file" => "~/.ssh/megam_ec2.pem",
            "ssh-user" => "ubuntu"
        }
    },
    "chefservice" => {
        "chef" => {
            "command" => "knife",
            "plugin" => "ec2 server create",
            "run-list" => "'role[opendj]'",
            "name" => "-N TestOverAll"
        }
    }
}
=end
{"node_name" => "alrin.megam.co","command" => "commands","predefs" => {"name" => "rails", "scm" => "scm", "db" => "db", "queue" => "queue"}}
      )}.merge(@options)

      request(
        :expects  => 201,
        :method   => :post,
        #:path     => @options[:path],
        :body     => @options[:body]
      )
    end
 
    
#Yet to be tested
    # DELETE /nodes/:node_id
    def delete_node(node_id)
      @options = {:path => '/nodes/#{node_id}',
        :body => OkJson.encode({"node_id" => "#{node_id}"})}.merge(@options)

      request(
        :expects  => 200,
        :method   => :delete,
        #:path     => @options[:path],
        :body     => @options[:body]
      )
    end

  end
end
