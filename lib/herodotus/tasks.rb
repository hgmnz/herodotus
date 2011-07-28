require 'rake'
namespace 'herodotus' do
  desc 'Prints out the change log from git'
  task :print do
    base_dir  = ENV['REPO'] || File.expand_path(File.dirname(__FILE__))
    since_ref = ENV['SINCE']
    Herodotus::Writer.new(base_dir, since_ref).print
  end

  desc 'Appends changes to your changelog'
  task :append do
    base_dir  = ENV['REPO'] || File.expand_path(File.dirname(__FILE__))
    since_ref = ENV['SINCE']
    Herodotus::Writer.new(base_dir, since_ref).append_to_changelog
  end
end
