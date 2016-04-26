require "jrb/hdfs/version"

module Jrb
  module Hdfs
    fail 'jrb/hdfs gem only supports jruby' unless RUBY_PLATFORM == "java"
  end
end

Dir[("#{__dir__}/jars/*.jar")].each { |jar| require jar }
require "jrb/hdfs/client"
