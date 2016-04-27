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
  spec.platform      = "java"

  spec.files         = Dir['lib/**/*.rb', 'lib/**/*.jar']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  #Jar dependencies
  spec.requirements << "jar 'org.apache.hadoop:hadoop-hdfs', '2.7.1'"
  spec.requirements << "jar 'org.apache.hadoop:hadoop-common', '2.7.1'"
  spec.requirements << "jar 'org.slf4j:slf4j-log4j12', '1.7.10'"

  spec.add_development_dependency 'jar-dependencies', '~> 0.3.2'
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
