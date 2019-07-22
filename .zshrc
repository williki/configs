## Willis .zshrc 18.08
######################

# {{{1 Options

zmodload  zsh/termcap zsh/complist zsh/computil
autoload -Uz compinit colors history-search-end url-quote-magic
compinit
colors

export XCOMPOSE=~/.Xcompose
export HISTFILE=~/.zshhist
export HISTSIZE=8192
export SAVEHIST=8192
export EDITOR=vim

# Completion
setopt complete_in_word     # ~/Dev/pro -> <Tab> -> ~/Development/project
setopt complete_aliases

# Directories
setopt auto_cd              # Automatically cd to paths
setopt autopushd            # Automatically append dirs to the push/pop list
setopt pushdignoredups      # ... and don't duplicate them

# Expansion and globbing
#setopt glob_complete
setopt brace_ccl			# Expand alphabetic brace exrpressions
setopt bad_pattern			# If a pattern is badly formatted, print it
setopt extended_glob		# Treat #, ~ and ^ chars as part of a pattern

# History
#setopt hist_ignore_all_dups # when I run a command several times, only store one
setopt hist_ignore_dups		# When I run a command several times, only store one
setopt hist_no_functions    # Don't show function definitions in history
setopt hist_reduce_blanks   # Reduce whitespace in history
setopt hist_ignore_space	# Dont add commands with a leading space to history
setopt hist_find_no_dups
# setopt extended_history	# Save commands beginning and duration time
setopt inc_append_history	# When multiple session are active, append to histfile
setopt share_history

# Misc
setopt correct				# Spellcheck for commands only
setopt numeric_glob_sort    # When globbing numbered files, use real counting
setopt interactive_comments # Allow comments even in interactive shells
setopt prompt_subst			# Parameter expansions and command subst on prompt string
setopt check_jobs			# Check suspended jobs before exit
setopt check_running_jobs	# ... aswell as running jobs


## {{{1 Prompt

PROMPT="
%B%n %bon%B %m %bis%B %(?.%F{green}:)%f.%F{red}:(%f) %bat%B %32<*<%~ %v
%#%b "
#RPROMPT="%~ (%*)" #show date on right prompt

function precmd() {
    PSVAR=`git_prompt_precmd`
}


## {{{1 Keys

# mappings for Ctrl-left-arrow and Ctrl-right-arrow for word moving 
bindkey -M emacs '^[[1;5C' forward-word 
bindkey -M emacs '^[[1;5D' backward-word 
bindkey '^R'  history-incremental-search-backward
bindkey '^[[5~' history-search-backward     #PgUp
bindkey '^[[6~' history-search-forward      #PgDwn
bindkey '^[[H' beginning-of-line            #Home
bindkey '^[[F' end-of-line                  #Home
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Move one directory up
function cdParentKey {
	pushd ..
	zle reset-prompt
	echo
	ls
	zle reset-prompt
}

# Undo cd
function cdUndoKey {
	popd
	zle reset-prompt
	echo
	ls
	zle reset-prompt
}

zle -N cdParentKey	&& bindkey "^[[1;3A" cdParentKey	# Alt+Up 
zle -N cdUndoKey	&& bindkey "^[[1;3D" cdUndoKey		# Alt+Left

## {{{1 Style 

# formatting and messages
zstyle ':completion:*' verbose 'yes'
zstyle ':completion:*:descriptions' format "%B-- %d --%b"
zstyle ':completion:*:messages' format "%B--${green} %d ${nocolor}--%b"
zstyle ':completion:*:warnings' format "%B--${red} no match for: %d ${nocolor}--%b"
zstyle ':completion:*:corrections' format "%B--${yellow} %d ${nocolor}-- (errors %e)%b"
zstyle ':completion:*' group-name ''

# describe options
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d' -x NULLCMD=cat

# completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 1
zstyle ':completion:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:processes' command 'ps -A'
zstyle ':completion:*:manuals' menu yes select
zstyle ':completion:*history*' remove-all-dups yes
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
zstyle ':completion:*' rehash true

# Colored less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


## {{{1 Alias

alias -g ...="../.."
alias -g ....="../../.."
alias checknet="ip addr; ping google.de"
alias df="df -h"
alias la="ls -ACF --group-directories-first"
alias ll="ls -l -h --color=auto -F --group-directories-first"
alias ls="ls --color=auto -F --group-directories-first"
alias lsd="ls -d */"
alias grep="grep --color=auto"
alias -g ND='$(ls --color=none -d *(/om[1]))' # newest directory
alias -g NF='$(ls --color=none *(.om[1]))'    # newest file
alias maps="telnet mapscii.me"
alias own="sudo chown $(whoami)"
alias pwd="/bin/pwd"	# inbuild pwd does not show realpath (symlink problem)
#alias pud="pwd | xsel -s"
#alias pod="cd '$(xsel -so)'"
alias readbios="sudo dd if=/dev/mem bs=1k skip=768 count=512 2>/dev/null | strings -n 8"
alias showip="curl icanhazip.com"
alias srm="mv -t ~/.local/share/Trash/files --backup=t --verbose"
alias tron="ssh sshtron.zachlatta.com"
alias weather="curl -s wttr.in/bonn+germany | head -n 7" # 2> /dev/null"

## Command File Type Detection
compctl -/ -g '*.(ogg|ogv|avi|mpg|mpeg|wmv|mp4|mov|flv|divx|mkv|vob)' mplayer
compctl -/ -g '*.(png|jpg|gif|bmp|tiff|jpeg|tga|JPG)' feh

# auto open movies
alias -s {mpg,mpeg,avi,ogm,wmv,m4v,mp4,mov,mkv,vob,ogv,ogg}="mplayer -idx"

# auto open audio
alias -s {mp3,ogg,wav,flac}="mplayer"


## {{{1 Functions

function bcalc {
    if [[ ! -f /usr/bin/bc ]]; then
        echo "Please install bc before trying to use it!"
        return 1
    fi    
    if [[ -z "$1" ]] ; then
        /usr/bin/bc -q
    else
       echo "$@" | /usr/bin/bc -l
    fi
}

function cdl {
	cd "$@" && ls
}

function cleanthumbnails {
	echo "Thumbnail cache size before cleaning..."
	du -h ~/.cache/thumbnails
	find ~/.cache/thumbnails -type f -atime +90 -exec rm '{}' \;
	echo "Thumbnail cache size after cleaning..."
	du -h ~/.cache/thumbnails
}

function llgrep {
    ls -l  | grep -i ${1:-""} 
}

function locategrep  { 
	if [ "${#}" != 2 ]; then 
		echo "Usage: locategrep [string to locate] [string to grep]"
		return 1
	else 
		echo "locate -i ${1} | grep -i ${2}"
		command locate -i ${1} | grep -i ${2}
	fi; 
}

function lowercase-extensions {
	autoload zmv
	zmv '(**/)(*).(*)' '$1$2.${(L)3}'
}

function mvcd {
	mv -iv "${@}" && cd "${@: -1}"
}

function save {
	NAME=`basename $(pwd)`-`date "+%Y-%m-%d"`.7z
	7z a $NAME . -p
	mv $NAME ~/Dropbox/save
}

function showtopcmds {
    if [ "$1" = "" ] ; then
		1="10"
    fi
    print -l ${(o)history%% *} | uniq -c | sort -nr | head -n "$1"
    echo "* Roots top cmds:"
	grep sudo $HISTFILE | awk '{print $2}'| sort | uniq -c | sort -nr | head -n "$1"
    echo "* Total cmds: `wc -l $HISTFILE`"
}

function source-zsh-mod {
	local SYS_PLUGIN_FOLDER=/usr/share/zsh/plugins
	local USER_PLUGIN_FOLDER=~/.zsh
	if [ -f $1 ]; then
		source $1
	elif [ -f $USER_PLUGIN_FOLDER/$1 ]; then
		source $USER_PLUGIN_FOLDER/$1
	elif [ -f $SYS_PLUGIN_FOLDER/$1 ]; then
		source $SYS_PLUGIN_FOLDER/$1
	else
		ZSH_MISSING="$ZSH_MISSING\n$1"
	fi
}


function update {
	if [ -f /usr/bin/apt ];	then	# Debian based
		sudo apt update
		sudo apt dist-upgrade -y
	else							# Arch based
	    if  [  -f /usr/bin/yay ]; then
			yay --noconfirm -Syu
		else
			sudo pacman -Syu
		fi
	fi
}

function xterm_title_precmd {
	print -Pn '\e]2;  %1~ $(jobs) \a'
}

function xterm_title_preexec {
	print -Pn '\e]2;% %1~ %# '
}

source-zsh-mod zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source-zsh-mod zsh-autosuggestions/zsh-autosuggestions.zsh
source-zsh-mod /usr/share/doc/pkgfile/command-not-found.zsh
# https://github.com/joto/zsh-git-prompt/blob/master/git-prompt.zsh
source-zsh-mod git-prompt.zsh

# Used to display terminal title
autoload -Uz add-zsh-hook
add-zsh-hook -Uz precmd xterm_title_precmd
#add-zsh-hook -Uz preexec xterm_title_preexec

# When opening a new shell, display todo list (if it exists)
if ! type "fortune" > /dev/null; then
	[ -f .todo ] && cat .todo || true
else
	[ -f .todo ] && cat .todo || fortune -s
fi

