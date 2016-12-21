[[ -d ~/.zplug ]] || {
    curl -sL zplug.sh/installer | zsh
}

source ~/.zplug/init.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zplug "miekg/lean", use:"*.zsh"
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/enhancd", use:"init.sh"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load 
export GOPATH=~/gocode
export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH

export PYENV_ROOT=~/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
export EDITOR=vim
export XDG_CONFIG_HOME=$HOME/.config


alias ls="ls --color=auto"
alias e=./a.out
alias -s cpp="g++-6 -std=c++11 -O2 -I/Users/orisano/proj/"

shost() {
    socat TCP-LISTEN:$2,reuseaddr,fork EXEC:$1    
}

spid() {
    ps lx | grep $1 | grep -v socat | grep -v grep | awk '{print $3}'
}

cbc() {
    < $1 | pbcopy
}
