#!/bin/bash

# Assumes the log files follow the format ~/tmp/{INT}
# Semantics ->  rerr: read err ; rout: read out

rerr  () {
        if [ $1 ] ; then
# r               dir_name="~/tmp/${1}"
                # echo $dir_name
                # ls -d ~/tmp/1/*
                # echo $("~/tmp/1/*")
                # ls -d $("~/tmp/1/*")
                # ls -d ~/tmp/$1/*

                # working string interpolation
                # ls -d ~/tmp/"$1"/*
                # echo "$dir_name"
                # ls -d ~/tmp/"$1"/* | grep 'stderr' | grep '.gz$'
                # echo $dir_name | xargs ls -d
                # ls -d ~/tmp/1/*
                { cat  $(ls -d ~/tmp/"$1"/* | grep 'stderr' | grep '.gz$') | zcat  ; cat $(ls -d ~/tmp/"$1"/* | grep 'stderr' | grep -v '.gz') } | less -N

                # order matters! this will print stderr last, which is not in the right order
                # { cat $(ls -d ~/tmp/"$1"/* | grep 'stderr' | grep -v '.gz') ; cat  $(ls -d ~/tmp/1/* | grep 'stderr' | grep '.gz$') | zcat } | less -N
        fi
}

rout  () {
        if [ $1 ] ; then
                # we want to interpolate the $1 variable into the shell path. We need the wildcard character
                # to be interpreted as is, we can't just construct a string with the * character in there
                # bc that gets interpreted as a string
                # 
                # Not entirely sure about this but it seems like we are concatenaing the input of 2 streams 1 after the other 
                # and putting them into less -N
                # TODO(DFS): i wonder if this works with more than 2 inputs (in my mind, it should be generalizable
                { cat  $(ls -d ~/tmp/"$1"/* | grep 'stdout' | grep '.gz$') | zcat  ; cat $(ls -d ~/tmp/"$1"/* | grep 'stdout' | grep -v '.gz') } | less -N
        fi
}
