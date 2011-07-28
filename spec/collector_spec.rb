require File.expand_path('spec_helper', File.dirname(__FILE__))

describe Herodotus::Collector do
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

  it 'starts off with a default git, changes and a since_ref of nil' do
    collector.git.wont_be_nil
    collector.since_ref.must_be_nil
    collector.changes.wont_be_nil
  end

  it 'finds commits containing the changelog keyword on the message' do
    collector.changes.length.must_equal 2
    collector.changes.first.message.must_equal "Broke everything again. Don't update to this version."
    collector.changes.last.message.must_equal "Nevermind, everything is fixed now."
  end
end
