# Set/update git_current_branch on every prompt render.
# Mirrors the variable oh-my-zsh's git plugin used to set.
git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  git_current_branch=${ref#refs/heads/}
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd git_current_branch
