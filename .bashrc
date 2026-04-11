# We programmers are lazy,
# so let’s bring laziness to a whole new level,
# shall we?

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export MANWIDTH="$((COLUMNS > 90 ? 90 : COLUMNS)) man"

# ignore duplicates in history
export HISTCONTROL=ignoredups:erasedups

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# downloads entire websites with wget
alias ytv="yt-dlp -f 'bestvideo+bestaudio/best'"   # Best video + audio merged
alias yta="yt-dlp -f bestaudio --extract-audio --audio-format mp3"          # Best audio extracted as mp3

# substitutions
alias fdir='find . -type d -name'               # find directories
alias ff='find . -type f -name'                 # find files
alias cl='clear'                                # clear things quickly
alias hist='history'                            # show history
alias hgrep='history | grep'                    # search for command in history
alias lgrep='ls -l | grep'                      # search for file/directory in .

# typos
alias :q="exit"
alias :wq="exit"
alias :Wq="exit"
alias :wqa="exit"
alias :Wqa="exit"

# navigation
alias treee='tree --filelimit 15'
alias ls='ls --group-directories-first --indicator-style=slash --color -1'
alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Create a new git directory and enter it
gitdir() {
    mkdir -p "$@" && cd "$@" && git init
}

