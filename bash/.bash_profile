#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# EXPORTS
# Set go env stuff
export GOPATH=$HOME/code/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"

export DOTNET_CLI_TELEMETRY_OPTOUT=1

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
fi
