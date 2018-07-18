# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' expand suffix
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**' '+l:|=* r:|=*'
zstyle :compinstall filename '/home/m4ntis/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# Reduce lag time between zle mode switching
export KEYTIMEOUT=1

parse_git_dirty() {
  builtin cd -q /home/m4ntis/dotfiles
  test -z "$(git status --porcelain --ignore-submodules -unormal 2> /dev/null)" 
  #TODO: Make this insanity fucking work
  #(( $? )) && echo " *"
  zle reset-prompt 2> /dev/null
}

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
#zstyle ':vcs_info:*+*:*' debug true
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:git*' formats " [%b$(parse_git_dirty)]"
precmd() {
    vcs_info
}

setopt prompt_subst
PROMPT='%F{blue}[%F{magenta}%n%f@%F{cyan}%m%F{green}${vcs_info_msg_0_}%f %1~%F{blue}]%f '

# Display zle normal mode thingy on the wight
zle -N zle-line-init
zle -N zle-keymap-select
function zle-line-init zle-keymap-select {
  VIM_PROMPT="%F{red}[NORMAL]%f"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
  zle reset-prompt
}

alias ls='ls --color=auto --group-directories-first -h'

# Command caching
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache


# added by travis gem
[ -f /home/m4ntis/.travis/travis.sh ] && source /home/m4ntis/.travis/travis.sh
