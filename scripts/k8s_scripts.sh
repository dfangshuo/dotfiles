#!/bin/bash

kctx() {
  local oldc=$(kubectl config current-context)
  local selected=$(kubectl config get-contexts | fzf)
  local new_context=$(echo "$selected" | awk '{if ($1 == "*") print $2; else print $1}')
  
  # Ensure we have a valid context
  if [[ -z "$new_context" ]]; then
    echo "No context selected!"
    return 1
  fi
  
  kubectl config use-context "$new_context"
  echo "$new_context" | pbcopy
  echo "Prev: $oldc"
}
