require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

require 'jars/installer'
task :install_jars do
    Jars::Installer.vendor_jars!
end

task :default => :test
