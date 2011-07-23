module Herodotus
  class Writer
    CHANGES_REGEX = /changelog.*?\n(.*)/mi
    Change = Struct.new(:author, :date, :message) do
      def pretty_author
        "#{author.name} <#{author.email}>"
      end
    end

    attr_accessor :git, :since_ref, :changes

    def initialize(base_dir, since_ref = nil)
      @git       = Git.new(base_dir)
      @since_ref = since_ref
      @changes   = []
      find_changes
    end

    def find_changes
      git.commits(since_ref).each do |commit|
        if commit.message =~ CHANGES_REGEX
          @changes << Change.new(commit.author, commit.authored_date, $1)
        end
      end
    end
    private :find_changes

  end
end
