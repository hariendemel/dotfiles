# --- ls ---
alias ls='eza --icons'
alias ll='eza -lh --icons --git'
alias la='eza -lah --icons --git'
alias tree='eza --tree --icons'
compdef eza=ls

# --- tool override ---
alias cat='bat'
alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'
alias vim='nvim'

# --- chezmoi ---
alias ch="chezmoi"
alias cha="ch apply"
alias chu="ch update"
alias che="ch edit"
alias chf="ch forget"
alias chst="ch status"
alias chad="ch add"
alias chra="ch re-add"
alias chd="ch diff"

# --- networking ---
alias digs='dig +short'
alias dns-clear='dscacheutil -flushcache & sudo killall -HUP mDNSResponder'

