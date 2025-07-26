#!/bin/bash

# function replace_str_with_source {
#   echo $@ | awk "{gsub(\"${SOURCE}\",\"\$SOURCE\"); print}"
# }

# function ts {
#   # function name, semantically: to $source
#   # replace the value of $SOURCE with the text $SOURCE

#   # if the file path starts with /...
#   if [[ $@ =~ ^/.* ]]
#   then
#    replace_str_with_source $@ | pbcopy
#   else
#    # TODO: put this into a common function
#    IFS=: read SRC_CODE_FILE_PATH SRC_CODE_LINE_NUMBER <<< $@
#    echo "\$SOURCE/src/py/$SRC_CODE_FILE_PATH" | pbcopy
#   fi

# }


function r {
    local target_path="$1"
    shift                   # Remove the path from the argument list, so "$@" is now the rest

#     echo "--- r function debug ---" >&2
#     echo "target_path: '${target_path}'" >&2
#     echo "Remaining arguments (\$@): '${@}'" >&2
#     echo "SOURCE variable: '${SOURCE}'" >&2
#     echo "--- end debug ---" >&2
# 
    if [[ -z "$target_path" ]]; then
        echo "Error: No path provided to r function." >&2
        return 1
    fi

    if [[ "$target_path" == src/* ]]; then
        # Path starts with src/, prepend $SOURCE
        run_pytests -p no:warnings --no-header --showlocals "$SOURCE/$target_path" "$@"
    else
        # Path does not start with src/, use as is
        run_pytests -p no:warnings --no-header --showlocals "$target_path" "$@"
    fi
}


function goto_cursor_line() {
  if [ -z "$1" ]; then
    echo "Usage: goto_cursor_line path/to/file:line_number"
    return 1
  fi

  local target_path="$1"

  # Check if the path is absolute (starts with /)
  if [[ "$target_path" != /* ]]; then
    # It's a relative path, check if it needs 'src/py/' prepended
    if [[ "$target_path" != src/py/* ]]; then
      target_path="src/py/$target_path"
    fi
  # else it's an absolute path, leave it as is
  fi

  # Assume 'cursor' command exists and call it
  cursor -g "$target_path"
}

alias o=goto_cursor_line
