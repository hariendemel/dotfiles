# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

FUNCNEST=1000

export STARSHIP_CONFIG=$ZDOTDIR/starship.toml
eval "$(starship init zsh)"
