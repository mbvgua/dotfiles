# downloads entire websites with wget
alias wget-ds="wget --mirror --convert-links --adjust-extension --page-requisites --no-parent "
alias ytv="yt-dlp -f 'bestvideo+bestaudio/best'"                            # Best video + audio merged
alias yta="yt-dlp -f bestaudio --extract-audio --audio-format mp3"          # Best audio extracted as mp3

# substitutions
alias vi='nvim'; alias vim='nvim'               # the future is now!
alias fdir='find . -type d -name'               # find directories
alias ff='find . -type f -name'                 # find files
alias cl='clear'                                # clear things quickly
alias hist='history'                            # show history
alias hgrep='history | grep'                    # search for command in history
alias lgrep='ls -1a | grep'                     # search for file/directory in
alias ll='ls -alF'                              # list files and minor details
alias la='ls -A'                                # list even hidden files
alias treee='tree --filelimit 15'               # list nested files & directories
alias files='thunar'                            # open files easily

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --group-directories-first --indicator-style=slash --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto' 
    alias egrep='egrep --color=auto' 
fi

# colored GCC warnings and errors 
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# send alerts to system instantly using dunst: e.g sleep 5;alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# view images with feh {default image and slideahow}
alias feh='feh --fullscreen --draw-filename --info %h%S'
alias fehs='feh --fullscreen --draw-filename --slideshow-delay 5'

# creature of habit?
alias :q="exit"
alias :qa="exit"
alias :wq="exit"
alias :wqa="exit"

# navigation
alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'

# Bookmarks
alias dots='cd ~/.dotfiles && ls -1a'
alias dt='cd ~/Desktop && ls -1a'
alias docs='cd ~/Documents && ls -1a'
alias dl='cd ~/Downloads && ls -1a'
alias vids='cd ~/Videos && ls -1a'
alias music='cd ~/Music && ls -1a'
alias pics='cd ~/Pictures'

# working with docker
alias dils="docker image ls"
alias dcls="docker container ls"
alias dclsa="docker container ls -a"
alias dvls="docker volumes ls"
alias dpls='docker container ls --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}" -a'
alias digrep='docker image ls -a | grep'
alias dcgrep='docker container ls -a | grep'
alias drma='docker system prune -a --volumes'

# get window class name for qtile
alias wn="xprop WM_CLASS"

# fonts stuff
alias fonts="fc-cache -fv"
alias ls-fonts="fc-list : family , style"
