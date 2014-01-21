#!/usr/bin/env sh

echo "Installing brew cask and a few little apps"
brew update

brew tap phinze/cask
brew install brew-cask

brew cask install f-lux
brew cask install bittorrent-sync

brew cask alfred link

echo "Install some fonts"
brew tap caskroom/fonts
brew cask install font-source-code-pro
brew cask install font-inconsolata-dz-for-powerline
