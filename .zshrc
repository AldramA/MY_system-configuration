HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

export QT_STYLE_OVERRIDE=Adwaita-Dark
export GTK_THEME=Adwaita:dark
export EDITOR=nvim

#vim mode
set -o vi

#loadkey
doas loadkeys ~/.config/loadkey/loadkeysrc

# ls
alias ls='lsd --color=always --icon=always'
alias ll='lsd -l --color=always --icon=always'
alias la='lsd -la --color=always --icon=always'
alias lt='lsd --tree --color=always --icon=always'

## Directory Navigation
alias cd.="cd .."
alias cd..="cd ../.."
alias cd...="cd ../../.."
alias cd....="cd ../../../.."
alias cd.....="cd ../../../../.."

## Git Commands
alias gs="git status"
alias gst="git status -sb"
alias gl="git log"
alias ga="git add"
alias gaa="git add -A"
alias gal="git add ."
alias gca="git commit -a"
alias gc="git commit -m"
alias gcot="git checkout"
alias go="git push -u origin"
alias gsh='git stash'
alias gw='git whatchanged'
alias gitlg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias nah="git clean -df && git checkout -- ."

## History Commands
alias h="history"
alias h1="history 10"
alias h2="history 20"
alias h3="history 30"
alias hgrep='history | grep'


# Auto suggestion plugin
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# vim Short Aliases
alias nv='nvim'

# Void Linux Package Management Short Aliases

# Install a package
alias i='doas xbps-install -S'

# Update package database and upgrade all packages
alias u='doas xbps-install -Su'

# Query/search for a package
alias q='xbps-query -Rs'

# Remove a package
alias r='doas xbps-remove -R'

# Show info about a package
alias qi='xbps-query -R'

# List installed packages
alias ql='xbps-query -l'

# Clean cache (free up disk space)
alias cleanP='doas xbps-remove -O'

# Full clean (remove orphaned packages)
alias cleanall='doas xbps-remove -o'

# Check for updates
alias check='xbps-install -Mun'

# Alternative way to install a package
alias xi='doas xbps-install'

alias vi='vim'

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.9
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi


# Created by `pipx` on 2025-04-21 10:24:25
export PATH="$PATH:/home/mu/.local/bin"
export PATH="/home/mu/mambaforge/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mu/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mu/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/mu/mambaforge/etc/profile.d/conda.sh"
    fi
fi 
unset __conda_setup

if [ -f "/home/mu/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/mu/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<
