#################################################################
# We programmers are lazy,                                      #
# so let’s bring laziness to a whole new level,                 #
# shall we?                                                     #
# Sections:                                                     #
#    1.General...................general bash behaviour         #
#    2.Packages .................installed packages             #
#    3.Aliases....................general aliases               #
#    3.Functions..................useful functions              #
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

############################################
# 2.Aliases                                #
############################################

# default for opening files in ranger
export EDITOR="nvim"
export VISUAL="nvim"

# open man pages in neovim
# thanks @mental_outlaw - Yt
export MANPAGER="nvim +Man!"

# ignore duplicates in history
HISTCONTROL=ignoredups

# downloads
# entire websites with wget
alias wget-ds="wget --mirror --convert-links --adjust-extension --page-requisites --no-parent "
alias ytv="yt-dlp -f 'bestvideo+bestaudio/best' mp4"   # Best video + audio merged as mp4
alias yta="yt-dlp -f bestaudio --extract-audio --audio-format mp3"          # Best audio extracted as mp3

# substitutions
alias vim='nvim'                                # the time has come!!!Sorry Bram ;(
alias ls='eza --icons --sort=extension'         # ls for eza. modern with icons
alias fdir='find . -type d -name'               # find directories
alias ff='find . -type f -name'                 # find files
alias hist='history'                            # show history
alias hgrep='history | grep'                    # search for command in history
alias lgrep='ls -l | grep'                      # search for file/directory in .
alias files='xdg-open .'                        # open files easily

# typos
alias :q="exit"
alias :wq="exit"
alias :Wq="exit"
alias :wqa="exit"
alias :Wqa="exit"
alias quit="exit"

# navigation
alias treee='tree --filelimit 15'
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Bookmarks
alias dots='cd ~/.dotfiles && ls -1a'
alias dt='cd ~/Desktop && ls -1a'
alias docs='cd ~/Documents && ls -1a'
alias dl='cd ~/Downloads'
alias vids='cd ~/Videos && ls -1a'
alias music='cd ~/Music && ls -1a'
alias pics='cd ~/Pictures'

# working with docker
alias dils="docker image ls"
alias dcls="docker container ls"
alias dclsa="docker container ls -a"

# get window class name for qtile
alias wn="xprop WM_CLASS"

############################################
# 4.Functions                              #
############################################
# Create a new directory and enter it
mkd() {
    mkdir -p "$@" && cd "$@"
}

