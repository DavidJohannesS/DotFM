export PATH="/usr/bin/python3:$PATH"
export PATH=$HOME/local/bin:$PATH
export KUBECONFIG=$HOME/.kube/config
export EDITOR=vim
export VISUAL=vim
eval "$(zoxide init bash)"
alias getcmd='cat /home/$USER/.bash_history | grep'
#--------------------------------------------------------------------------------------------JAVA
#---------------------------------------------------------------------JBANG
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"
#---------------------------------------------------------------------SDKMAN
export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
#--------------------------------------------------------------------------------------------JAVA END
#--------------------------------------------------NAVIGATION
alias ll='ls -lahs --color=auto'
alias home='cd ~'
alias dir='du -h --max-depth=1'
alias lt="tree -L 1"
alias la='ls -lh' 
alias hidden='ls -Adl .*'

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias untar='~/tools/untar.sh'
#-------------------------------------------NETWORK UTILS
alias openports='netstat -nape --inet'
alias resolv='cat /etc/resolv.conf'
#------------------------------------------GIT ALIASES
alias ggaa='git add .'
alias gga='git add'
alias ggs='git status'
alias ggc='git commit -m'
alias ggr='git remote -v'
alias pp='git remote -v && git branch -a'
alias ggb='git branch -a'
alias ggp='git push'
#-------------------------------------------------------SYSTEM UTILS

alias tray='pstree -AcuT $USER'
alias update="sudo nala update && sudo nala upgrade -y"

#--------------------------------------------------APPLICATION SHORTCUTS
alias kc='kubectl'
alias ap='ansible-playbook'
alias ag='ansible-galaxy'
#---------------------------Create project with nice-to-have dependencies
alias mkc='~/tools/mkc.sh'
alias mkj='~/tools/mkj.sh'

###################################################################################
##################  TMUX SETUP #######################
#----------------------------------------------------#
#ensure cmd history gets tracked
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
#clean tmux sessions
alias tmux-ka="tmux ls | cut -d: -f1 | xargs -n 1 tmux kill-session -t"
alias tmux-ks='function _tmux_kill_sessions(){ for session in "$@"; do tmux kill-session -t "$session"; done }; _tmux_kill_sessions'
# Function to check if a session exists and is attached
is_attached() {
  local session_name="$1"
  local status=$(tmux ls | grep "^${session_name}:" | awk '{ print $10 }')
  if [[ "$status" == "(attached)" ]]; then
    return 0  # true
  else
    return 1  # false
  fi
}

# Function to create a new tmux session with a given name
create_new_session() {
  local session_name="$1"
  if tmux has-session -t "$session_name" 2>/dev/null; then
    return 1
  else
    tmux new-session -s "$session_name"
    return 0
  fi
}
if [ -z "$TMUX" ]; then
  SESSION_NAME="meow"
  if ! create_new_session "$SESSION_NAME"; then
    if ! is_attached "$SESSION_NAME"; then
      tmux attach -t "$SESSION_NAME"
      exit 0
    fi
    SESSION_NAME="main"
    if ! create_new_session "$SESSION_NAME"; then
      if ! is_attached "$SESSION_NAME"; then
        tmux attach -t "$SESSION_NAME"
        exit 0
      fi
      # Create or attach tmp sessions
      count=0
      while true; do
        SESSION_NAME="tmp${count}"
        if ! create_new_session "$SESSION_NAME"; then
          if ! is_attached "$SESSION_NAME"; then
            tmux attach -t "$SESSION_NAME"
            exit 0
          fi
          ((count++))
        else
          break
        fi
      done
    fi
  else
    tmux attach -t "$SESSION_NAME"
  fi
fi
tmux source ~/.tmux.conf
#--------------------------------------------------------#
###################  TMUX CONFIG END #####################
#########################################################################
