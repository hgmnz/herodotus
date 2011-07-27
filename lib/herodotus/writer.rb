module Herodotus
  class Writer
    CHANGES_REGEX = /changelog.*?\n(.*)/mi

    def initialize(base_dir, since_ref = nil)
      @git                = Git.new(base_dir)
      @since_ref          = since_ref
      @changes            = []
      @changelog_filename = 'CHANGES'
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

    attr_accessor :git, :since_ref, :changes, :changelog_filename

    def print
      @changes.each do |change|
        puts change.log_entry
      end
    end

    def append_to_changelog
      File.open(changelog_filename, 'a') do |file|
        @changes.each do |change|
          file.puts change.log_entry
        end
      end
    end

    def find_changes
      git.commits.each do |commit|
        if commit.message =~ CHANGES_REGEX
          @changes.unshift Change.new(commit.author, commit.authored_date, $1)
        end
      end
    end
    private :find_changes

  end
end
