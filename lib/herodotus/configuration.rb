module Herodotus
  class Configuration
    attr_accessor :base_path, :changelog_filename

    def initialize
      @changelog_filename = 'CHANGES'
    end

    class << self
      attr_accessor :config
    end
    @config = Configuration.new

    def self.run
      yield config
    end

    def self.reset!
      self.config = Configuration.new
    end
  end
end
