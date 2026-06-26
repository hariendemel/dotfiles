#custom aliases for ZSH

#enable colorls
if [ -x "$(command -v colorls)" ]; then
    alias ls="colorls"
    alias la="colorls -al"
fi

#Chezmoi
alias ch="chezmoi"
alias cha="ch apply"
alias chu="ch update"
alias che="ch edit"
alias chra="ch re-add"
alias chd="ch diff"

#DNS
alias digs='dig +short'
alias dns-clear='dscacheutil -flushcache & sudo killall -HUP mDNSResponder'

#Git
alias gls="git log --pretty='%Cred%h%Creset | %C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %C(cyan)[%an]%Creset'"
alias gcr="gco --track"
alias gcob="gco -b"
alias grguo="gr get-url origin"

#OpenCode
alias oc="opencode"
alias ocsl="oc session list"
alias ocso="oc -s"

