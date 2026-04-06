# downloads entire websites with wget
alias wget-ds="wget --mirror --convert-links --adjust-extension --page-requisites --no-parent "
alias ytv="yt-dlp -f 'bestvideo+bestaudio/best'"                            # Best video + audio merged
alias yta="yt-dlp -f bestaudio --extract-audio --audio-format mp3"          # Best audio extracted as mp3

# substitutions
# alias vim='nvim -u ~/.vimrc'                    # the time has come!!!Sorry Bram ;(
alias fdir='find . -type d -name'               # find directories
alias ff='find . -type f -name'                 # find files
alias cl='clear'                                # clear things quickly
alias hist='history'                            # show history
alias hgrep='history | grep'                    # search for command in history
alias lgrep='ls -1a | grep'                     # search for file/directory in .
alias files='thunar'                            # open files easily

# view images with feh {default image and slideahow}
alias feh='feh --fullscreen --draw-filename --info %h%S'
alias fehs='feh --fullscreen --draw-filename --slideshow-delay 5'

# creature of habit?
alias :q="exit"
alias :qa="exit"
alias :wq="exit"
alias :wqa="exit"

# navigation
alias treee='tree --filelimit 15'
alias ls='ls --group-directories-first --indicator-style=slash --color -1'
alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

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

# excuse my fat fingers
alias :Wq="exit"
alias :Wqa="exit"
alias la="ls"

# temp-> haveno 'fn' key on keyboard
alias vol+='wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+'
alias vol-='wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-'
