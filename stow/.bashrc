#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza -l'
alias grep='grep --color=auto'
alias pacfind="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias yayfind="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
alias pacrm="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias clear="clear; nitchrevived"
PS1='[\u@\h \W]\$ '
nitchrevived

eval "$(zoxide init bash)"
alias cd='z'
export PATH="/home/beepew/.local/bin:$PATH"
