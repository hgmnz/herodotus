require File.expand_path('spec_helper', File.dirname(__FILE__))
require 'ruby-debug'

describe Herodotus::Git do

  def git
    @git ||= Herodotus::Git.new('tmp/bacon')
  end

  before do
    FileUtils.cd 'tmp' do
      `git init`
      `touch file`
      `git add file`
      `git commit -m "Added file"`
      `touch file2`
      `git add file2`
      `git commit -m "Added file2"`
      FileUtils.mkdir_p 'bacon'
    end

  end

  after do
    FileUtils.rm_rf 'tmp/*'
  end

  it 'locates the closest git repo' do
    git.repo.path.must_match %r{/tmp/.git$}
  end

  it 'pulls out commits from the repo' do
    git.commits.map(&:message).must_equal ['Added file2', 'Added file']
  end
end
