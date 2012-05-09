# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nexty/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paolo Perego"]
  gem.email         = ["thesp0nge@gmail.com"]
  gem.description   = %q{A command line interface to your Nexpose VA tool}
  gem.summary       = %q{A command line interface to your Nexpose VA tool}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "nexty"
  gem.require_paths = ["lib"]
  gem.version       = Nexty::VERSION

end
