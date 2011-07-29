require File.expand_path('spec_helper', File.dirname(__FILE__))

describe Herodotus::Git do

  def git
    @git ||= Herodotus::Git.new('/tmp/herodotus/bacon')
  end

  it 'uses the configured base_path if none is provided' do
    Herodotus::Configuration.run do |config|
      config.base_path = 'foo'
    end

    Herodotus::Git.new.base_path.must_equal 'foo'
  end

  describe 'with some commits' do
    before do
      FileUtils.mkdir_p '/tmp/herodotus'
      FileUtils.cd '/tmp/herodotus' do
        `git init`
        `touch file`
        `git add file`
        `git commit -m "Added file"`
        `git tag -a v1 -m "the MVP"`
        `touch file2`
        `git add file2`
        `git commit -m "Added file2"`
        FileUtils.mkdir_p 'bacon'
      end
    end

    after do
      FileUtils.rm_rf '/tmp/herodotus'
    end

    it 'locates the closest git repo' do
      git.repo.path.must_equal '/tmp/herodotus/.git'
    end

    it 'pulls out commits from the repo' do
      git.commits.map(&:message).must_equal ['Added file2', 'Added file']
    end

    it 'pulls out commits since a given ref' do
      git.commits('v1').map(&:message).must_equal ['Added file2']
    end
  end
end
