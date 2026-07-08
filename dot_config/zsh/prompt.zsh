# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

export FUNCNEST=100

export STARSHIP_CONFIG=$ZDOTDIR/starship.toml
eval "$(starship init zsh)"
