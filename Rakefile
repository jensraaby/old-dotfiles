# This rakefile was inspired by (partially copied from) yadr

require 'rake'
require 'fileutils'

# Where all these files are supposed to be:
$DOTFILES = "#{ENV['HOME']}/.dotfiles"


desc "Install homebrew (Mac only) and symlink some basics"
task :install => [:gitsubmodules] do
    homebrew if RUBY_PLATFORM.downcase.include?("darwin")
    
end

desc "Update the repostitory from github and update the submodules"
task :update do
  puts "Updating repository"
  run %{git pull}
  puts
  puts "Updating homebrew"
  run %{brew update}
  puts
  puts "Updating submodules"
  run %{git submodule update}
  
end


task :start_brewing => [:install] do
   puts
   puts "Installing a few things with Brew"
   run %{brew install automake ctags git hub }
   puts 
end

task :tmux do
  puts "Installing tmux"
  
  run %{brew install tmux reattach-to-user-namespace}
  puts
  install_files(['tmux/tmux.conf'])
  
  
end

task :git do
  puts "Setting up git config"
  puts
  install_files(Dir.glob('git/*'))
  
  puts 
  puts "Setting up os x keychain auth"
  # TODO check for credential helper first!
  run %{git config --global credential.helper osxkeychain}
  
  
end


task :zsh do
  puts
  puts "Setting up ZSH with prezto"
  
  run %{brew install zsh}
  
  unless File.exists?(File.join(ENV['ZDOTDIR'] || ENV['HOME'], ".zprezto"))
      run %{ ln -nfs "#{$DOTFILES}/zsh/prezto" "${ZDOTDIR:-$HOME}/.zprezto" }
      run %{ cd "#{$DOTFILES}/zsh/prezto" && git submodule init && git submodule update}
      # install_files(Dir.glob('zsh/prezto/runcoms/z*'))
      
      run %{chsh -s /bin/zsh}
  end
  
  # Copy my custom zsh files (will possibly overwrite the ones we just installed)
  install_files(Dir.glob('zsh/z*'))
  
  #reload the shell
  run %{exec $SHELL -l}
end

task :uninstallzsh do
  if File.exists?(File.join(ENV['ZDOTDIR'] || ENV['HOME'], ".zprezto"))
    run %{unlink ~/.zprezto}
  end
end

task :gitsubmodules do
  puts
  puts "Getting submodules"
  run %{git submodule init}
  run %{git submodule update}
end

private

def run(cmd)
    puts "[Running] #{cmd}"
    `#{cmd}` unless ENV['DEBUG']
end

def homebrew()
    run %{which brew}
    unless $?.success?
        puts "Installing brew"
        run %{ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"}
    end
    run %{brew update}
end

def install_files(files, method = :symlink)
  files.each do |f|
    file = f.split('/').last
    source = "#{ENV['PWD']}/#{f}"
    target = "#{ENV['HOME']}/.#{file}"
    
    puts "=========#{file}=========="
    puts "Source: #{source}"
    puts "Target: #{target}"
    
    # Let's backup the old one, if it's not from this repo
    if File.exists?(target) && (!File.symlink?(target) ||
       (File.symlink?(target) && File.readlink(target) != source))
          puts "[Overwriting] #{target}...leaving original at original.#{file}..."
          run %{ mv "$HOME/.#{file}" "$HOME/original.#{file}" }
    end
        
    case method
    when :symlink
      puts "Creating symlink"
      run %{ln -nfs "#{source}" "#{target}"}
    when :copy
      puts "Copying directly"
      run %{cp -f "#{source}" "#{target}"}
    end
      
  end
end
