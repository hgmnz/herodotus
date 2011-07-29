require File.expand_path('spec_helper', File.dirname(__FILE__))

describe Herodotus::Reporter do
  def collector
    @collector ||= Herodotus::Collector.new('/tmp/herodotus')
  end

  before do
    FileUtils.mkdir_p '/tmp/herodotus'
    FileUtils.cd '/tmp/herodotus' do
      `git init`
      `touch file1`
      `git add file1`
      `git commit -m "this is a change"`
      `touch file2`
      `git add file2`
      `git commit -m "Another\nChAnGeLOg:\nBroke everything again. Don't update to this version."`
      `touch file3`
      `git add file3`
      `git commit -m "Another\nchangelog:\nNevermind, everything is fixed now."`
    end
  end

  after { FileUtils.rm_rf '/tmp/herodotus' }

  it 'takes a Collector instance' do
    reporter = Herodotus::Reporter.new(collector)
    reporter.collector.must_equal collector
  end

  it 'appends changelog entries to the changelog file' do
    reporter = Herodotus::Reporter.new(collector)
    reporter.changelog_filename = File.expand_path('tmp/test_changes')
    reporter.append_to_changelog
    changelog = IO.read(reporter.changelog_filename)
    changelog.must_include "Broke everything again. Don't update to this version."
    changelog.must_include "Nevermind, everything is fixed now."
    FileUtils.rm_rf 'tmp/test_changes'
  end

  it 'uses the configured changelog_filename' do
    Herodotus::Configuration.run do |config|
      config.changelog_filename = 'los cambios van aqui!'
    end

    reporter = Herodotus::Reporter.new('base dir')
    reporter.changelog_filename.must_equal 'los cambios van aqui!'
  end
end
