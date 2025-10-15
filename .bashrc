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
export HISTCONTROL=ignoredups:erasedups

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# downloads
# entire websites with wget
alias wget-ds="wget --mirror --convert-links --adjust-extension --page-requisites --no-parent "
alias ytv="yt-dlp -f 'bestvideo+bestaudio/best'"   # Best video + audio merged
alias yta="yt-dlp -f bestaudio --extract-audio --audio-format mp3"          # Best audio extracted as mp3

# substitutions
alias vim='nvim'                                # the time has come!!!Sorry Bram ;(
alias ls='eza --icons --sort=extension'         # ls for eza. modern with icons
alias fdir='find . -type d -name'               # find directories
alias ff='find . -type f -name'                 # find files
alias hist='history'                            # show history
alias cl='clear'                                # clear things quickly
alias hgrep='history | grep'                    # search for command in history
alias lgrep='ls -l | grep'                      # search for file/directory in .
alias files='xdg-open .'                        # open files easily
alias notes='wezterm -e nvim ~/notes.md'           # notes app? whats that
# view images with feh {default image and slideahow}
alias feh='feh --fullscreen --draw-filename --info %h%S -f Jet Brains Mono'
alias fehs='feh --fullscreen --draw-filename --slideshow-delay 5 -f Jet Brains Mono'

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
# Create a new git directory and enter it
gitdir() {
    mkdir -p "$@" && cd "$@" && git init
}

# extract files cleanly
# from DistroTube
#https://gitlab.com/dwt1/dotfiles/-/blob/master/.bashrc?ref_type=heads
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

### ARCHIVE EXTRACTION
# usage: ex <file>
function ex {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "ex: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

# Calc app? whats that
calc() {
	local result=""
	result="$(printf "scale=10;%s\\n" "$*" | bc --mathlib | tr -d '\\\n')"
	#						└─ default (when `--mathlib` is used) is 20

	if [[ "$result" == *.* ]]; then
		# improve the output for decimal numbers
		# add "0" for cases like ".5"
		# add "0" for cases like "-.5"
		# remove trailing zeros
		printf "%s" "$result" |
			sed -e 's/^\./0./'  \
			-e 's/^-\./-0./' \
			-e 's/0*$//;s/\.$//'
	else
		printf "%s" "$result"
	fi
	printf "\\n"
}
