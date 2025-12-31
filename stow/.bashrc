#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(zoxide init bash)"
alias ls='eza -l'
alias grep='grep --color=auto'
alias pacfind="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias yayfind="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
alias pacrm="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias clear="clear; nitchrevived"
alias cd='z'
alias vi="nvim"
PS1='[\u@\h \W]\$ '
nitchrevived

#SSH config
eval $(ssh-agent -s)
#Put your github private key under ~/.ssh/github and use sudo chown 600 ~/.ssh/github
ssh-add ~/.ssh/github
