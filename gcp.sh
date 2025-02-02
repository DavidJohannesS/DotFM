#!/bin/bash

# get current branch
get_current_branch() {
  git branch --show-current
}

# get remote of branch
get_remote() {
  local branch
  branch=$(git symbolic-ref --short -q HEAD)
  git config --get branch."$branch".remote
}

# get commit message
read -rp "Enter commit message: " commit_message

# assigned default remote/branch
default_remote=$(get_remote)
default_branch=$(get_current_branch)

# if Upstream not set...
if [ -z "$default_remote" ]; then
  echo "No upstream remote found. Please enter the remote:"
  read -rp "Enter remote: " remote
else
  read -rp "Enter remote (default: $default_remote): " remote
  remote=${remote:-$default_remote}
fi
# if branch name not set...
if [ -z "$default_branch" ]; then
  echo "No upstream branch found. Please enter the branch name:"
  read -rp "Enter branch name: " branch
else
  read -rp "Enter branch name (default: $default_branch): " branch
  branch=${branch:-$default_branch}
fi


git add .
git commit -m "$commit_message"
git push "$remote" "$branch"

