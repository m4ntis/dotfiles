#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Add colours to ls
alias ls='ls --color=auto --group-directories-first -h'
alias la='ls -A'

# Add advanced globbing options:
# +(x[ | x ... ]) Matches when any x appears once or above
# *(x[ | x ... ]) Matches when any x appears any amount of times
# ?(x[ | x ... ]) Matches when any x appears once or none
# @(x[ | x ... ]) Matches when any x appears just once
# !(x[ | x ... ]) Matches no x match
shopt -s extglob

# [user@pcname curdir]$
PS1='[\u@\h \W]\$ '

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
