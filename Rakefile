# This rakefile was inspired by ( & partially copied from) yadr

require 'rake'
require 'fileutils'

# Where all these files are supposed to be:
$DOTFILES = "#{ENV['HOME']}/.dotfiles"

desc "Install homebrew (Mac only) and symlink some basics"
task :install => [:gitsubmodules] do
    homebrew if RUBY_PLATFORM.downcase.include?("darwin")

    Rake::Task["start_brewing"].execute
    Rake::Task["tmux"].execute


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
  run %{git submodule update --recursive}
end

desc "Install a few brew kegs"
task :start_brewing => [:install] do
   puts
   puts "Installing a few things with Brew"
   run %{brew install automake ctags git hub cmake}
   puts 
end

task :tmux => [:powerline] do
  puts
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

task :vim => [:python,:powerline] do
    puts "Lovely vim with YouCompleteMe"
    puts 
    # TODO check if it's already installed
    install_files(['vim', 'vim/vimrc'])
    #  Problematic python because of macvim formula:
    # https://github.com/mxcl/homebrew/issues/17908
    run %{brew install vim}
    run %{brew install macvim --env-std --override-system-vim}
    puts 
    puts "Recursively initialising git submodules"
    run %{git submodule update --init --recursive}
    
    puts "\nInstalling build tools for YCM"
    run %{brew install cmake automake boost}
    puts "Install vim bundles"
    run %{vim +BundleInstall +qall}
    puts
    puts 'Now you need to compile YouCompleteMe.'
    run %{cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer}

end

task :powerline do
    puts
    puts "Installing powerline to user packages"
    run %{pip install --user git+git://github.com/Lokaltog/powerline}
    #run %{ln -sf #{ENV['HOME']}/Library/Python/2.7/lib/python/site-packages/Powerline #{$DOTFILES}/powerline/repo}
    Rake::Task["gitsubmodules"].execute
    run %{mkdir $HOME/.config}
    run %{ln -sf "#{$DOTFILES}/powerline/config" "$HOME/.config/powerline"}
    run %{ln -sf fonts/powerline-fonts/Inconsolata/Inconsolata\ for\ Powerline.otf $HOME/Library/Fonts}
    run %{ln -sf fonts/powerline-fonts/Meslo/Meslo\ LG\ L\ Regular\ for\ Powerline.otf $HOME/Library/Fonts}
end

task :zsh do
    puts
    puts "Setting up ZSH with prezto"
    run %{brew install zsh}
    unless File.exists?(File.join(ENV['ZDOTDIR'] || ENV['HOME'], ".zprezto"))
        run %{ ln -nfs "#{$DOTFILES}/zsh/prezto" "${ZDOTDIR:-$HOME}/.zprezto" }
        run %{ cd "#{$DOTFILES}/zsh/prezto" && git submodule init && git submodule update}
        run %{chsh -s /bin/zsh}
    end

    # Copy my custom zsh files 
    install_files(Dir.glob('zsh/z*'))

    #reload the shell
    run %{exec $SHELL -l}
end

task :gitsubmodules do
    puts
    puts "Init and update submodules (also recursively e.g. for vundler)"
    run %{git submodule update --init --recursive}
end

task :python do
   
    # Need to get version (python --version doesn't seem to return properly)
    pyver = `python -c 'import sys; print(".".join(map(str, sys.version_info[:3])))'`

    unless pyver.strip.eql? "2.7.4" and RUBY_PLATFORM.downcase.include?("darwin")
        puts
        puts "Installing Python 2.7.4 from python.org"
        run %{curl -O http://www.python.org/ftp/python/2.7.4/python-2.7.4-macosx10.6.dmg}
        run %{hdiutil attach python-2.7.4-macosx10.6.dmg}
        run %{sudo installer -pkg "/Volumes/Python 2.7.4/Python.mpkg" -target /}
        run %{hdiutil detach "/Volumes/Python 2.7.4/"}
        run %{rm -f python-2.7.4-macosx10.6.dmg}
    end
    puts "Installing PIP"
    run %{sudo easy_install pip}
end

task :ruby do
    puts
    puts "Installing rbenv"
    run %{brew install rbenv ruby-build rbenv-gemset} 
    #TODO check if installed
    #run %{git clone git://github.com/sstephenson/rbenv.git ~/.rbenv}
    #run %{echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc}
    #irun %{echo 'eval "$(rbenv init -)"' >> ~/.zshrc}
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

# def link_folder(path)
#   source = "#{ENV['PWD']}/#{path}"
# 
# end

def install_files(files, method = :symlink)
    files.each do |f|
        file = f.split('/').last
        source = "#{ENV['PWD']}/#{f}"
        target = "#{ENV['HOME']}/.#{file}"

        puts "=========#{file}=========="
        puts "Source: #{source}"
        puts "Target: #{target}"
        puts
        # Let's backup the old one, if it's not from this repo
        if File.exists?(target) && (!File.symlink?(target) ||
                                    (File.symlink?(target) && File.readlink(target) != source))
            puts "[Overwriting] #{target}...leaving original at original.#{file}..."
            run %{ mv "$HOME/.#{file}" "$HOME/original.#{file}" }
        end

        # This where the magic happens
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
