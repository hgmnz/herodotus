require File.expand_path('spec_helper', File.dirname(__FILE__))

describe Herodotus::Writer do
  before do

    Author = Struct.new(:name, :email)
    Commit = Struct.new(:author, :authored_date, :message)
    name = "Harold", email = "harold@example.com", date = Time.new('2012-02-04')

    Herodotus::Git.class_eval do
      define_method :commits do |since_ref|
        [
          Commit.new(Author.new(name, email), date, "this is a change"),
          Commit.new(Author.new(name, email), date, "Another\nChAnGeLOg:\nBroke everything again. Don't update to this version."),
          Commit.new(Author.new(name, email), date, "Another\nchangelog:\nNevermind, everything is fixed now."),
        ]
      end
    end
    @writer = Herodotus::Writer.new(File.dirname(__FILE__))
  end

  it 'starts off with a default git, changes and a since_ref of nil' do
    @writer.git.wont_be_nil
    @writer.since_ref.must_be_nil
    @writer.changes.wont_be_nil
  end

  it 'finds commits containing the changelog keyword on the message' do
    @writer.changes.length.must_equal 2
    @writer.changes.first.message.must_equal "Broke everything again. Don't update to this version."
    @writer.changes.last.message.must_equal "Nevermind, everything is fixed now."
  end
end
