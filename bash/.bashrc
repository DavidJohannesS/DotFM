# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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


# Function to get the current git branch
function parse_git_branch {
  git symbolic-ref --short HEAD 2>/dev/null
}

# Function to get the current Kubernetes context
function parse_kube_context {
    local context=$(kubectl config current-context 2>/dev/null)
  if [ -n "$context" ]; then
    # Check if the cluster is online
    kubectl cluster-info &> /dev/null
    if [ $? -eq 0 ]; then
      echo "$context"
    fi
  fi
}
function get_branches()
{
    local context=$(git branch -a | paste -sd ' ' - 2>/dev/null)
       echo "$context" 
}
# Function to set the prompt
function set_prompt {
  # Start building the prompt
  PS1='${debian_chroot:+($debian_chroot)}'

  # Arrow symbol in blue
  PS1+='\[\033[38;5;153m\]→ '

  # Full path in white
  PS1+='\[\033[38;5;15m\]\w 
  '


  # Second flower - Kubernetes context
  if [ -n "$(parse_kube_context)" ]; then
    # Connected to a cluster - yellow flower with context name
    PS1+='\[\033[38;5;226m\] ❀ ' # Yellow flower
    PS1+='\[\033[38;5;225m\]$(parse_kube_context) 
    '
  else
    # Not connected to a cluster - blue flower
    PS1+='\[\033[38;5;153m\] ❀ '
  fi

  # First flower - determine the color based on git status
  if git rev-parse --show-toplevel > /dev/null 2>&1; then
      # We're inside a Git repository - green flower with branch name
      PS1+='\[\033[38;5;82m\]❀ ($(parse_git_branch)) '
  else
      # Not in a git repo - blue flower
      PS1+='\[\033[38;5;153m\]❀ '
  fi
  # Reset color
  PS1+='\[\033[00m\]'
}

# Set the PROMPT_COMMAND to call the set_prompt function
PROMPT_COMMAND=set_prompt




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
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases

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

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
