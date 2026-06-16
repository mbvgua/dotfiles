# We programmers are lazy,
# so let’s bring laziness to a whole new level, shall we?

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export MANPAGER="nvim +Man!"
export MANWIDTH="$((COLUMNS > 90 ? 90 : COLUMNS)) man"

export HISTCONTROL=ignoredups:erasedups         # ignore duplicates in history
HISTSIZE=1000                                   # originally 500
HISTFILESIZE=2000                               # originally 500,makeit waaayy larger
shopt -s histappend                             # append to the history file, don't overwrite

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# substitutions
alias fdir='find . -type d -name'               # find directories
alias ff='find . -type f -name'                 # find files
alias cl='clear'                                # clear things quickly
alias hist='history'                            # show history
alias hgrep='history | grep'                    # search for command in history
alias lgrep='ls -l | grep'                      # search for file/directory in .

# creature of habit
alias :q="exit"
alias :wq="exit"
alias :Wq="exit"
alias :wqa="exit"
alias :Wqa="exit"
