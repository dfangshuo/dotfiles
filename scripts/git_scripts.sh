#!/bin/bash

function goto {
  # Checkout to a new branch, creating it if it doesnt exist
  set +e
  git checkout $@
  if [ $? != 0 ]
  then 
    echo 'Creating new branch...'
    git checkout -b  $@
  fi
}

# function gto {
#   set +e
#   PR_OUTPUT=$(gh pr checkout $@ 2>&1)
#   PR_EXIT_CODE=$?
# 
#   # If the command succeeded or the output doesn't contain "no pull requests found"
#   if [ $PR_EXIT_CODE -eq 0 ]; then
#     set -e
#     return 0
#   fi
# 
#   # If that fails, try checking out the branch or creating it
#   echo "No PR found for '$@'. Trying to checkout or create branch..."
#   git checkout $@ 2>/dev/null
#   BRANCH_EXIT_CODE=$?
#   if [ $BRANCH_EXIT_CODE -ne 0 ]; then
#     echo "Creating new branch '$@'..."
#     git checkout -b $@
#   fi
#   set -e
# }


# alias gbr='g branch --sort=-committerdate'
alias gbr='g checkout $(g branch --sort=-committerdate| sed "s/^[ *]*//" | fzf --height 40% --layout=reverse)'

function gbD {
  # checkout to Main and delete the current branch
  CURR_BRANCH=$(git branch | grep "*" | cut -d" " -f2)
  git checkout main
  git branch -D $CURR_BRANCH
  git pull
}

function gbC {
  git branch -d $(gh pr view $1 --json headRefName -q .headRefName)
}

function gbDD {
  # Cleand up local branches that no longer exist on remote
  DELETED_BRANCHES=($(git branch -vv | grep ': gone]'|  grep -v "\*" | awk '{ printf $1 " "; }'))
  for branch in "${DELETED_BRANCHES[@]}"; do
      git branch -D "${branch}"
  done
}
