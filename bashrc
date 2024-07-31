# .bashrc - A comprehensive bash configuration file

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable programmable completion features
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# History settings
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Improved Bash prompt
PS1='\[\e[32m\]╭─\[\e[34m\]\u@\h \[\e[35m\]\w\[\e[0m\]\n\[\e[32m\]╰─\[\e[0m\]❯ '



# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -m'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout main'
alias gb='git branch'

#General Aliases
alias lv='lvim'

# Custom functions
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1    ;;
            *.tar.gz)    tar xzf $1    ;;
            *.bz2)       bunzip2 $1    ;;
            *.rar)       unrar e $1    ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1     ;;
            *.tbz2)      tar xjf $1    ;;
            *.tgz)       tar xzf $1    ;;
            *.zip)       unzip $1      ;;
            *.Z)         uncompress $1 ;;
            *.7z)        7z x $1       ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Add color support to common commands
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Set PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Editor settings
export EDITOR=nano
export VISUAL=nano

# Enable autojump if installed
if [ -f /usr/share/autojump/autojump.sh ]; then
    . /usr/share/autojump/autojump.sh
fi

# Enable fzf if installed
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Enable rbenv if installed
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Enable pyenv if installed
if command -v pyenv 1>/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# Load NVM (Node Version Manager) if installed
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Python virtual environment prompt
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi

# Custom aliases for navigation
alias docs='cd ~/Documents'
alias dls='cd ~/Downloads'
alias desk='cd ~/Desktop'

# Source additional scripts if they exist
for file in ~/.bashrc.d/*; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# Clean up
unset file
. "$HOME/.cargo/env"

export PATH=/home/steve/.cargo/bin:/home/steve/.cargo/bin:/home/steve/bin:/home/steve/.local/bin:/home/steve/.cargo/bin:/home/steve/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

#gnu++ Rust Alternative Aliases
alias cat='bat --paging=always'
alias ls='exa -la'
alias diff='git-delta'
alias du='du-dust'
alias tree='broot'
alias find='fd'
alias grep='rg'
alias find='fd'
alias cut='choose'
alias sed='sd'
alias top='btm'
alias ps='procs'
alias cd='z'
eval "$(zoxide init bash)"
alias dig='doge'

export PAGER="lvim -c 'Man!' -o -"
