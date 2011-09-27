# Alias a few commands 
alias ls='ls -G' #Colours enabled
alias ll='ls -lG' #Show details
alias la='ls -alG' #Show all files on lines with colours

# Work proxy setup
#export HTTP_PROXY=http://wwwcache.sanger.ac.uk:3128
#export http_proxy=http://wwwcache.sanger.ac.uk:3128
#export HTTPS_PROXY=http://wwwcache.sanger.ac.uk:3128
#export https_proxy=http://wwwcache.sanger.ac.uk:3128

# OS X command for getting proxy address: tosystem_profiler SPNetworkDataType|grep "HTTP Proxy Server"|awk {'sub(/^.*:[ \t]*/, "", $0); print $0;'}
proxyaddress=`system_profiler SPNetworkDataType|grep "HTTP Proxy Server"|awk {'sub(/^.*:[ \t]*/, "", $0); print $0;'}`
proxyport=`system_profiler SPNetworkDataType|grep "HTTP Proxy Port"|awk {'sub(/^.*:[ \t]*/, "", $0); print $0;'}`
if [ -n $proxyaddress ];
	then
		ALL_PROXY=http://$proxyaddress:$proxyport
		export http_proxy=ALL_PROXY
		export HTTP_PROXY=ALL_PROXY
		export HTTPS_PROXY=ALL_PROXY
		export https_proxy=ALL_PROXY
	fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Nice git completion
source ~/.git-completion.sh

# Add tab completion for `defaults read|write NSGlobalDomain`
complete -W "NSGlobalDomain" defaults

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function