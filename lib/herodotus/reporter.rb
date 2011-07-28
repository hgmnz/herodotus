module Herodotus
  class Reporter
    attr_reader :collector
    attr_accessor :changelog_filename

    def initialize(collector)
      @collector          = collector
      @changelog_filename = 'CHANGES'
    end

    def print
      @changes.each do |change|
        puts change.log_entry
      end
    end

    def append_to_changelog
      File.open(changelog_filename, 'a') do |file|
        @collector.changes.each do |change|
          file.puts change.log_entry
        end
      end
    end
  end
end
