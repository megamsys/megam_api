# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "megam/api/version"

Gem::Specification.new do |s|
  s.name        = "megam_api"
  s.version     = Megam::API::VERSION
  s.authors     = ["Rajthilak, Kishorekumar Neelamegam, Ranjitha R, Vinodhini V, Rathish VBR, Rajesh Rajagopalan, Thomas Alrin, Yeshwanth Kumar, Subash Sethurajan, Arunkumar sekar"]
  s.email       = ["rajthilak@megam.io","nkishore@megam.io","ranjithar@megam.io","vino.v@megam.io","rathishvbr@megam.io","rajeshr@megam.io","thomasalrin@gmail.com","morpheyesh@gmail.com","subash.avc@gmail.com","arunkumar.sekar@megam.io"]
  s.homepage    = "http://github.com/megamsys/megam_api"
  s.license = "MIT"
  s.extra_rdoc_files = ["README.md", "LICENSE" ]
  s.summary = %q{Ruby Client for the Megam Vertice}
  s.description = %q{Ruby Client for the Megam vertice. Performs REST calls to Vertice Gateway -  http://github.com/megamsys/vertice_gateway.git}
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_runtime_dependency 'excon', '~> 0.52.0'
  s.add_runtime_dependency 'highline', '~> 1.7'
  s.add_runtime_dependency 'ffi-yajl', '~> 2.3'
  s.add_runtime_dependency 'mixlib-config', '~> 2.2'
  s.add_runtime_dependency 'mixlib-log', '~> 1.6'
  s.add_development_dependency 'minitest', '~> 5.9'
  s.add_development_dependency 'rake', '~> 11.2'
end
