[[ "${aliases[dots]}" ]] && unalias dots
[[ "${aliases[dots-ls-untracked]}" ]] && unalias dots-ls-untracked

function dots {
  # If a git alias is a passed as the first argument
  # prepend the custom arguments to the command
  if [[ $# -gt 0 ]] && [[ "${aliases[$1]}" ]]; then
    local cmd=${aliases[$1]}
    if [[ "${cmd%% *}" == "git" ]]; then
      shift
      eval "GIT_DIR=$HOME/.dots.git GIT_WORK_TREE=$HOME $cmd "$@""
      return;
    fi
  elif [[ $# -eq 0 ]]; then
    set -- status .
  fi
  git --git-dir=$HOME/.dots.git --work-tree=$HOME "$@"
}
compdef _git dots="git"

function dots-ls-untracked {
  [[ $# -eq 0 ]] && {
    set -- "."
  }
  dots status -u "$@"
}
