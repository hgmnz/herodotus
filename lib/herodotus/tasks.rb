require 'rake'
require 'herodotus'

def default_base_dir
  File.expand_path(File.dirname(__FILE__))
end

namespace :herodotus do
  desc 'Prints out the change log from git'
  task :print, :since_ref do |t, args|
    base_dir  = ENV['BASE_DIR'] || default_base_dir
    Herodotus::Collector.new(base_dir, args['since_ref']).
      print
  end

  desc 'Appends changes to your changelog'
  task :append, :since_ref do |t, args|
    base_dir  = ENV['BASE_DIR'] || default_base_dir
    Herodotus::Collector.new(base_dir, args['since_ref']).
      append_to_changelog
  end
end
