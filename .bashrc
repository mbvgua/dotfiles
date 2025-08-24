#################################################################
#Filename: .bashrc                                              #
#Sections:                                                      #   
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


############################################
# 2.Aliases                                #
############################################


if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
export PATH="$PATH:/opt/mssql-tools/bin"

# downloading entire websites with wget
alias wget-ds="wget --mirror --convert-links --adjust-extension --page-requisites --no-parent "

# managing dotfiles repo
alias dotfiles='/usr/bin/git --git-dir=/home/daagi/.dotfiles/ --work-tree=/home/daagi'

# substitute ls with eza. Modern with inbuilt icons
alias ls='eza --icons --sort=extension'

# open files easily
alias files='xdg-open .'

#easy tree navigation
alias treee='tree --filelimit 15'

############################################
# 3.Packages                               #                     
############################################


# Load Angular CLI autocompletion.
source <(ng completion script)

# Set up fzf key bindings and fuzzy completion
#eval "$(fzf --bash)"

#cargo
. "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/home/daagi/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# default for opening files with ranger
export EDITOR="nvim"
export VISUAL="nvim"
