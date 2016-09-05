export CLICOLOR=1
export TERM=xterm-256color
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
alias ll="ls -alh"
alias grep="grep --colour=always"
alias ..="cd ../"
alias ...="cd ../../"
alias jtop="htop"
alias ㄔㄣ="htop"
export PAGER=most

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
