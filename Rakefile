require 'bundler'
require 'bundler/setup'
require 'herodotus'
Bundler::GemHelper.install_tasks
include Rake::DSL

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

task :default => :test
