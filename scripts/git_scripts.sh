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
  # checkout to master/main/staging and delete the current branch
  CURR_BRANCH=$(git branch | grep "*" | cut -d" " -f2)
  git checkout staging
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

function guri {
    # Converts a string like "3f9ee86da22d sandbox/sandbox/w/render.py:108-169"
    # to a GitHub URL like .../blob/3f9ee86da22d/sandbox/sandbox//w/render.py#L108-L169

    if [ $# -eq 0 ]; then
        echo "Usage: guri '<commit> <file_path>:<line_range>'" >&2
        echo "   or: guri <commit> <file_path>:<line_range>" >&2
        exit 1
    fi

    # Handle both "commit file:lines" (1 arg) and commit file:lines (2 args)
    if [ $# -eq 1 ]; then
        commit=$(echo "$1" | awk '{print $1}')
        file_with_lines=$(echo "$1" | awk '{print $2}')
    else
        commit="$1"
        file_with_lines="$2"
    fi

    # Split file path and line range
    file_path=$(echo "$file_with_lines" | cut -d: -f1)
    line_range=$(echo "$file_with_lines" | cut -d: -f2)

    # Convert line range (108-169 -> L108-L169)
    if [[ "$line_range" == *-* ]]; then
        start_line=$(echo "$line_range" | cut -d- -f1)
        end_line=$(echo "$line_range" | cut -d- -f2)
        line_fragment="#L${start_line}-L${end_line}"
    elif [[ "$line_range" =~ ^[0-9]+$ ]]; then
        line_fragment="#L${line_range}"
    else
        line_fragment=""
    fi

    # Build the URL / TODO
    url="https://github.com//blob/${commit}/${file_path}${line_fragment}"

    echo "$url" | tee >(pbcopy)
}

