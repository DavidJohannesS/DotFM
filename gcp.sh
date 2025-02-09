#!/bin/bash

export FZF_DEFAULT_OPTS="--bind 'j:down,k:up' --header='=== Maven-Ctrl Menu ===' --multi"

get_current_branch() {
  git branch --show-current
}

get_remotes() {
  git remote -v | awk '{print $1}' | uniq
}

get_files() {
  git status --porcelain | awk '{print $2}'
}

get_remote() {
  local branch
  branch=$(git symbolic-ref --short -q HEAD)
  git config --get branch."$branch".remote
}

git status
read -rp "Enter commit message: " commit_message
selected_files=$(get_files | fzf --prompt='Select files to add: ')
for file in $selected_files; do
  git add "$file"
done

default_remote=$(get_remote)
default_branch=$(get_current_branch)
remotes=$(get_remotes)

if [ -z "$default_remote" ]; then
  if [[ $(echo "$remotes" | wc -l) -gt 1 ]]; then
    echo "No upstream remote found. Please select a remote:"
    remote=$(echo "$remotes" | fzf --prompt='Select remote: ')
  else
    remote=$remotes
  fi
else
  remote=$default_remote
fi

if [ -z "$default_branch" ]; then
  echo "No upstream branch found. Please enter the branch name:"
  read -rp "Enter branch name: " branch
else
  branch=$default_branch
fi

git commit -m "$commit_message"
git push "$remote" "$branch"

