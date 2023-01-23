#!/bin/bash

function replace_str_with_source {
  echo $@ | awk "{gsub(\"${SOURCE}\",\"\$SOURCE\"); print}"
}

function ts {
  # function name, semantically: to $source
  # replace the value of $SOURCE with the text $SOURCE

  # if the file path starts with /...
  if [[ $@ =~ ^/.* ]]
  then
   replace_str_with_source $@ | pbcopy
  else
   # TODO: put this into a common function
   IFS=: read SRC_CODE_FILE_PATH SRC_CODE_LINE_NUMBER <<< $@
   echo "\$SOURCE/src/py/$SRC_CODE_FILE_PATH" | pbcopy
  fi

}


function ygp {
  # yank github python

  # TODO: put this into a common function
  IFS=: read SRC_CODE_FILE_PATH SRC_CODE_LINE_NUMBER <<< $@
  echo "https://github.com/abnormal-security/source/tree/main/src/py/${SRC_CODE_FILE_PATH}#L$SRC_CODE_LINE_NUMBER" | pbcopy
}

# function yg {
#   # yank github
#   array=$(echo $1 | sed 's/:/\n/g')
#   echo ${array[0]}
#   echo ${array[1]}

#   # echo $1 | 
#   # echo "https://github.com/abnormal-security/source/tree/main/src/py/${STRIPPED_PATH}#L$2" | pbcopy
# }

function yg {
  # yank github
  STRIPPED_PATH=$(echo $1 | awk "{gsub(\"${SOURCE}\/\",\"\"); print}")
  echo "https://github.com/abnormal-security/source/tree/main/${STRIPPED_PATH}#L$2" | pbcopy
}


function debug_emp_db {
    COLS=$@
    cat ~/Downloads/employee_db.csv | awk -F"," -f ~/scripts/csv_header.awk -v cols=$COLS | column -ts $'\t' | less -N
}
