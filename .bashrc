#################################################################
# We programmers are lazy,                                      #
# so let’s bring laziness to a whole new level,                 #
# shall we?                                                     #
# Sections:                                                     #
#    1.General...................general bash behaviour         #
#    2.Aliases....................general aliases               #
#    3.Packages .................installed packages             #
#################################################################

############################################
# 1.General                                #
############################################

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# default for opening files with ranger
export EDITOR="nvim"
export VISUAL="nvim"

# open man pages in neovim
# thanks mental outlaw
export MANPAGER="nvim +Man!"

# ignore duplicates in history
HISTCONTROL=ignoredups

############################################
# 2.Aliases                                #
############################################

# managing dotfiles repo
# moved to Gnu Stow!
# alias dotfiles='/usr/bin/git --git-dir=/home/daagi/.dotfiles/ --work-tree=/home/daagi'

# downloading entire websites with wget
alias wget-ds="wget --mirror --convert-links --adjust-extension --page-requisites --no-parent "

# substitute ls with eza. Modern with inbuilt icons
alias ls='eza --icons --sort=extension'

# open files easily
alias files='xdg-open .'

#easy tree navigation
alias treee='tree --filelimit 15'

#exit terminal easily. like vim
alias :q="exit"

############################################
# 3.Packages                               #
############################################

# mssql-server
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
export PATH="$PATH:/opt/mssql-tools/bin"

# Load Angular CLI autocompletion.
source <(ng completion script)

# cargo for rust
. "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/home/daagi/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

