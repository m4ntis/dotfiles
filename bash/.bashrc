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

## [user@pcname curdir]$
#PS1='[\u@\h \W]\$ '

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}] "
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	if [ "${newfile}" == "0" ] || [ "${renamed}" == "0" ] || [ "${ahead}" == "0" ] || [ "${untracked}" == "0" ] || [ "${deleted}" == "0" ] || [ "${dirty}" == "0" ]; then
    echo " *"
	else
		echo ""
	fi
}

export PS1="\[\e[34m\][\[\e[31m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\] \[\e[32m\]\`parse_git_branch\`\[\e[m\]\W\[\e[34m\]]\[\e[m\] "

#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
