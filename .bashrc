# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# If not running interactively, don't do anything
#case $- in
#    *i*) ;;
#      *) return;;
#esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# save multi-line command as one command
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [[ "$TERM" =~ 256color ]]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[38;5;63m\]\D{%T} \[\e[38;5;117m\]\u@\h:\[\e[38;5;27m\]\w \n\[\e[38;5;22m\]\$ \[\e[00m\]'
elif [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[32m\]\D{%T}\ \u@\h\[\e[00m\]:\[\e[34m\]\w\n\[\e[32m\]\$\[\e[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\D{%T} \u@\h:\w\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

shopt -s cdspell

#Shortens Directory length
PROMPT_DIRTRIM=2

####### Setup sublime to run
export PATH=~/usr/bin:$PATH

####### Change the default file creation permissions
umask ug=rwx,o=

####### Setup bazel to run
export PATH=~/bin:$PATH:~/.local/bin

#function my_ip() # get IP adresses 
my_ip () {  
        MY_IP=$(/sbin/ifconfig wlan0 | awk "/inet/ { print $2 } " | sed -e s/addr://) 
                #/sbin/ifconfig | awk /'inet addr/ {print $2}'  
        MY_ISP=$(/sbin/ifconfig wlan0 | awk "/P-t-P/ { print $3 } " | sed -e s/P-t-P://) 
} 
 
# get current host related info 
ii () { 
    echo -e "\nYou are logged on ${red}$HOST" 
    echo -e "\nAdditionnal information:$NC " ; uname -a 
    echo -e "\n${red}Users logged on:$NC " ; w -h 
    echo -e "\n${red}Current date :$NC " ; date 
    echo -e "\n${red}Machine stats :$NC " ; uptime 
    echo -e "\n${red}Memory stats :$NC " ; free 
    echo -en "\n${red}Local IP Address :$NC" ; /sbin/ifconfig wlan0 | awk /'inet addr/ {print $2}' | sed -e s/addr:/' '/  
    #my_ip 2>&. ; 
    #my_ip 2>&1 ; 
    #echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:."Not connected"} 
    #echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:."Not connected"} 
    #echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP} #:."Not connected"} 
    #echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP} #:."Not connected"} 
    echo 
} 
 
 
# Easy extract 
extract () { 
  if [ -f $1 ] ; then 
      case $1 in 
          *.tar.bz2)   tar xvjf $1    ;; 
          *.tar.gz)    tar xvzf $1    ;; 
          *.bz2)       bunzip2 $1     ;; 
          *.rar)       rar x $1       ;; 
          *.gz)        gunzip $1      ;; 
          *.tar)       tar xvf $1     ;; 
          *.tbz2)      tar xvjf $1    ;; 
          *.tgz)       tar xvzf $1    ;; 
          *.zip)       unzip $1       ;; 
          *.Z)         uncompress $1  ;; 
          *.7z)        7z x $1        ;; 
          *)           echo "don't know how to extract '$1'..." ;; 
      esac 
  else 
      echo "'$1' is not a valid file!" 
  fi 
}

# consider using bash themes: 
# git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
# ~/.bash_it/install.sh
#add 
#export BASH_IT="/home/$USER/.bash_it"
#export BASH_IT_THEME="bobby" # or whatever other theme I want to use/try

