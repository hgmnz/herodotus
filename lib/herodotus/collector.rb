module Herodotus
  class Collector
    attr_accessor :git, :since_ref, :changes, :changelog_filename
    CHANGES_REGEX = /changelog.*?\n(.*)/mi.freeze

    def initialize(base_path, since_ref = nil)
      @git                = Git.new(base_path)
      @since_ref          = since_ref
      @changes            = []
      find_changes
    end

    Change = Struct.new(:author, :time, :message) do
      def pretty_author
        "#{author.name} <#{author.email}>"
      end

      def log_entry
        "#{time.to_date}  #{pretty_author}" +
        "\n#{message}" +
        "\n\n"
      end
    end

    def print
      reporter.print
    end

    def append_to_changelog
      reporter.append_to_changelog
    end

    def find_changes
      git.commits.each do |commit|
        if commit.message =~ CHANGES_REGEX
          @changes.unshift Change.new(commit.author, commit.authored_date, $1)
        end
      end
    end
    private :find_changes

    def reporter
      Herodotus::Reporter.new(self)
    end
  end
end
