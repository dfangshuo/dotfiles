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

function gbD {
  # checkout to Main and delete the current branch
  CURR_BRANCH=$(git branch | grep "*" | cut -d" " -f2)
  git checkout main
  git branch -D $CURR_BRANCH
  git pull
}

