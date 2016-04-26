# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jrb/hdfs/version'

Gem::Specification.new do |spec|
  spec.name          = "jrb-hdfs"
  spec.version       = Jrb::Hdfs::VERSION
  spec.authors       = ["Yuli Mo"]
  spec.email         = ["lizz@lizz.me"]

  spec.summary       = %q{hdfs client for jruby.}
  spec.description   = %q{hdfs client for jruby.}
  spec.homepage      = "https://github.com/myl2821/jrb-hdfs"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
