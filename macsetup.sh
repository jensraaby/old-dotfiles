
# install Homebrew
# install ZSH, Git, MacVim, Tmux etc.
brew install zsh git tmux tree 

chsh -s /bin/zsh

# symlink the dotfiles to the home folder

# setup YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
cd ~/

# setup powerline
brew install python
brew install macvim --env-std --override-system-vim
pip install --user git+git://github.com/Lokaltog/powerline
cp -f fonts/powerline-fonts/Inconsolata/Inconsolata\ for\ Powerline.otf $HOME/Library/Fonts
cp -f fonts/powerline-fonts/Meslo/Meslo\ LG\ L\ Regular\ for\ Powerline.otf $HOME/Library/Fonts
