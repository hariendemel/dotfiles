# Mirrors the functions oh-my-zsh's git plugin used to provide.
# git_current_branch prints the current branch (used by aliases like
# `$(git_current_branch)`); _update_git_current_branch runs on precmd
# to keep the git_current_branch *variable* set for the prompt.
git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

git_main_branch() {
  command git rev-parse --git-dir &> /dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,master}; do
    if command git show-ref -q --verify "$ref"; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

_update_git_current_branch() {
  git_current_branch=$(git_current_branch)
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _update_git_current_branch
