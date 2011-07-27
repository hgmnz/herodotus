module Herodotus
  class Git
    attr_accessor :repo
    def initialize(base_dir)
      @base_dir = base_dir
      @repo     = Grit::Repo.new(guess_repo)
    end

    def commits(since_ref = nil)
      if since_ref
        output = repo.git.rev_list({'pretty' => 'raw'}, "#{since_ref}..")
        Grit::Commit.list_from_string(repo, output)
      else
        Grit::Commit.find_all(@repo, since_ref)
      end
    end

    private
    def guess_repo
      current_dir = File.expand_path(@base_dir)
      until current_dir == '/' do
        maybe_repo = File.expand_path(".git", current_dir)
        if File.directory?(maybe_repo)
          return maybe_repo
        else
          current_dir = File.expand_path('..', current_dir)
        end
      end
    end
  end
end
