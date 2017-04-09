[[ -d ~/.zplug ]] || {
    curl -sL zplug.sh/installer | zsh
}

source ~/.zplug/init.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zplug "miekg/lean", use:"*.zsh"
zplug "zsh-users/zsh-completions"

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
export PATH=$HOME/.rbenv/shims:$PATH

export PYENV_ROOT=~/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
export EDITOR=nvim
export XDG_CONFIG_HOME=$HOME/.config

export CXX="g++-6"
alias ls="ls --color=auto"
alias e=./a.out
alias -s cpp="$CXX -std=c++11 -O2 -I/Users/orisano/proj/"
alias dco="$CXX -std=c++11 -Og -g -D_LOCAL_ -D_GLIBCXX_DEBUG -fsanitize=address"
alias vim=nvim
alias -s rs="rustc"

shost() {
    socat TCP-LISTEN:$2,reuseaddr,fork EXEC:$1    
}

spid() {
    ps lx | grep $1 | grep -v socat | grep -v grep | awk '{print $3}'
}

cbc() {
    < $1 | pbcopy
}

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

export PGDATA=/usr/local/var/postgres
[ -e ~/.cargo/env ] && source ~/.cargo/env
export RUST_SRC_PATH=~/opt/rust/src
