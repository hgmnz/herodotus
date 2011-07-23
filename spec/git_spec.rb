require File.expand_path('spec_helper', File.dirname(__FILE__))
require 'ruby-debug'

describe Herodotus::Git do

  before do
    # TODO: FakeFS. Don't have the gem, and don't have internet, so moving forward with ugly mocks
    # Can't stub a method on existing objects with minitest mocks
    def File.expand_path(dir, root=nil); root ? "/#{root}/#{dir}" : dir; end
    def File.directory?(dir); true; end

    grit_repo = MiniTest::Mock.new

    ::Grit::Repo.class_eval do
      define_method :initialize do |path|
        grit_repo.expect(:path, path)
        @grit_repo = grit_repo
      end
      define_method :path do
        @grit_repo.path
      end
    end
  end

  it 'locates the closest git repo' do
    git = Herodotus::Git.new('bacon')
    git.repo.path.must_equal '/bacon/.git'
  end
end
