# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# basic fedora-coloured+void-minimalist bash prompt
export PS1='\[\e[01;32m\][\u@\h \W]\$\[\e[00m\] '

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# add path to *my* scripts
export PATH="$PATH:$HOME/.local/scripts"

# set 3.10 as global python verions
# its of cultural significance whre im from
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# pnpm
export PNPM_HOME="/home/mbugua/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# load alises and functions
for file in ~/.{bash_aliases,bash_functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Load Angular CLI autocompletion.
source <(ng completion script)

# open man pages in neovim
# thanks @mental_outlaw - Yt
export MANPAGER="nvim +Man!"
export MANWIDTH="$((COLUMNS > 90 ? 90 : COLUMNS)) man"

# ignore duplicates in history
export HISTCONTROL=ignoredups:erasedups

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"
