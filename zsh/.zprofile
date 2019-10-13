# EXPORTS
# Set go env stuff
export GOPATH=$HOME/code/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export PATH=$PATH:$HOME/.cargo/bin
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export EDITOR=nvim
#export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
fi
