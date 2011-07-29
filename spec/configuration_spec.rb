require File.expand_path('spec_helper', File.dirname(__FILE__))

describe Herodotus::Configuration do

  before { Herodotus::Configuration.reset! }

  %w(base_path changelog_filename).each do |configurable|
    it "allows you to configure a #{configurable}" do
      Herodotus::Configuration.run do |config|
        config.must_be_kind_of Herodotus::Configuration
        config.send("#{configurable}=", 'foo')
      end

      Herodotus::Configuration.config.send(configurable).must_equal 'foo'
    end

  end

  it 'has a default changelog filename of CHANGES' do
    Herodotus::Configuration.config.changelog_filename.must_equal 'CHANGES'
  end
end
