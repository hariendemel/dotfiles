#custom aliases for ZSH

#DNS
alias digs='dig +short'
alias dns-clear='dscacheutil -flushcache & sudo killall -HUP mDNSResponder'

#Git
alias gls="git log --pretty='%Cred%h%Creset | %C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %C(cyan)[%an]%Creset'"
alias gcr="gco --track"
alias gcob="gco -b"
alias grguo="gr get-url origin"

#Terraform
alias t="terraform"
alias ti="t init"
alias tp="t plan"
alias ta="t apply"
alias tc="t console"
alias tdes="t destroy"
alias tim="t import"
alias ts="t state"
alias tsl="ts list"
alias tss="ts show"
alias tsrm="ts rm"
alias tsmv="ts mv"
alias tw="t workspace"

