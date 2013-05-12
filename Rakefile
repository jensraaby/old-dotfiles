require 'rake'
require 'fileutils'

desc "Install homebrew (Mac only) and symlink some basics"
task :install do
    homebrew if RUBY_PLATFORM.downcase.include?("darwin")
end


def homebrew()
    run %{which brew}
    unless $?.success?
        puts "Installing brew"
        run %{ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"}
    end
    run %{brew update}
end

task :start_brewing do
   puts
   puts "Installing a few things with Brew"
   run %{brew install automake zsh ctags git hub tmux reattach-to-user-namespace}
   puts 
end

def run(cmd)
    puts "[Running] #{cmd}"
    `#{cmd}` unless ENV['DEBUG']
end
