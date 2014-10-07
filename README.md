Megam Ruby Client
==================

[![Gem Version](https://badge.fury.io/rb/megam_api.svg)](http://badge.fury.io/rb/megam_api)

Megam Ruby Client is used to interact with the Megam API Server.

For more about the Megam' REST API <http://gomegam.com/docs>.[Megam API server](https://github.com/indykish/megam_play.git)

[![Build Status](https://travis-ci.org/indykish/megam_api.png)](https://travis-ci.org/indykish/megam_api)

We are on beta [register at:](https://www.megam.co)

Usage
-----

Start by creating a connection to Megam with your credentials:

    require 'megam_api'

    megam = Megam::API.new(:headers => {:api_key => API_KEY, :email => EMAIL})

Now you can make requests to the api.

Requests
--------

What follows is an overview of commands you can run for the client.

For additional details about any of the commands, see the [API docs](http://docs.megam.co).

### Nodes

    megam.get_nodes                              # get a list of your nodes
    megam.get_node(POGO)                         # get info about the node named POGO
    megam.create_node('name' => POGO, 
    'type' => 'rails')  			 # create an nodep with a generated name and the default type
    megam.delete_node(POGO)                      # delete the node named POGO


### Predefs

    megam.get_predefs                             # list all predefs 
    megam.get_predef('type' => rails)             # list a specific predef named 'rails'

### Accounts

    megam.get_accounts(email)                     # list accounts associated with email
    megam.post_accounts(email, api_key)           # onboard an account


We are glad to help if you have questions, or request for new features.

[twitter](http://twitter.com/megamsys) [email](<alrin@megam.co.in>)

#### TO - DO

*  
	
# License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Kishorekumar Neelamegam (<nkishore@megam.co.in>)
|                      | Subash Sethurajan (<subash.avc@gmail.com>)
|                      | Thomas Alrin (<alrin@megam.co.in>)
| **Copyright:**       | Copyright (c) 2012-2013 Megam Systems.
| **License:**         | Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

