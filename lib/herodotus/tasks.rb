require 'rake'
require 'herodotus'

namespace :herodotus do
  def default_base_path
    File.expand_path(File.dirname(__FILE__))
  end

  def configured_base_path
    Herodotus::Configuration.config.base_path
  end

  desc 'Prints out the change log from git'
  task :print, :since_ref do |t, args|
    base_path  = ENV['base_path'] || configured_base_path || default_base_path
    Herodotus::Collector.new(base_path, args['since_ref']).
      print
  end

  desc 'Appends changes to your changelog'
  task :append, :since_ref do |t, args|
    base_path  = ENV['base_path'] || configured_base_path || default_base_path
    Herodotus::Collector.new(base_path, args['since_ref']).
      append_to_changelog
  end
end
