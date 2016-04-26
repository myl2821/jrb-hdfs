require "jrb/hdfs/version"

module Jrb
  module Hdfs
    fail 'jrb/hdfs gem only supports jruby' unless RUBY_PLATFORM == "java"
  end
end

Dir[File.expand_path("../jars/*.jar", __FILE__)].each { |jar| require jar }
require "jrb/hdfs/client"
