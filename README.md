Megam Ruby Client
==================

[![Gem Version](https://badge.fury.io/rb/megam_api.svg)](http://badge.fury.io/rb/megam_api)

Megam Ruby Client is used to interact with the Megam API Server.

For more about the Megam' REST API <http://gomegam.com/docs>.[Megam API server](https://github.com/indykish/megam_play.git)

[![Build Status](https://travis-ci.org/indykish/megam_api.png)](https://travis-ci.org/indykish/megam_api)


Usage
-----

Start by creating a connection to Megam with your credentials:

    require 'megam_api'

    megam = Megam::API.new(:headers => {:api_key => API_KEY, :email => EMAIL})

Now you can make requests to the api.

Requests
--------

An overview of the commands you can run can be found in our documentation.


### Documentation

Refer [documentation] (http://www.gomegam.com/docs)



We are glad to help if you have questions, or request for new features..

[twitter @megamsys](http://twitter.com/megamsys) [email support@megam.co.in](<support@megam.co.in>)



	
# License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Kishorekumar Neelamegam (<nkishore@megam.co.in>)
|                      | Raj Thilak (<rajthilak@megam.co.in>)
|                      | Yeshwanth Kumar (<getyesh@megam.co.in>)
|                      | Subash Sethurajan (<subash.avc@gmail.com>)
|                      | Thomas Alrin (<alrin@megam.co.in>)
| **Copyright:**       | Copyright (c) 2012-2014 Megam Systems.
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

