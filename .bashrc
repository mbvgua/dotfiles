# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# TODO: figure out which to retain
# # If not running interactively, don't do anything
# case $- in
#     *i*) ;;
#       *) return;;
# esac

# basic fedora-coloured+void-minimalist bash prompt
export PS1='\[\e[01;32m\][\u@\h \W]\$\[\e[00m\] '

# User specific environment. also add path to *my* scripts
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/scripts:$PATH"
fi
export PATH

# load alises and functions
for file in ~/.{bash_aliases,bash_functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# open man pages in neovim. thanks @mental_outlaw - Yt
export MANPAGER="nvim +Man!"
export MANWIDTH="$((COLUMNS > 90 ? 90 : COLUMNS)) man"

export HISTCONTROL=ignoredups:erasedups         # ignore duplicates in history
HISTSIZE=1000                                   # originally 500
HISTFILESIZE=2000                               # originally 500,makeit waaayy larger
shopt -s histappend                             # append to the history file, don't overwrite

# ignore differences in upper & lowercase for TAB completion
bind "set completion-ignore-case on"
