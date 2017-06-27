[[ -d ~/.zplug ]] || {
    curl -sL zplug.sh/installer | zsh
}
source ~/.zplug/init.zsh

setopt prompt_subst
zplug "miekg/lean", use:"*.zsh"
zplug "zsh-users/zsh-completions"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

alias ls="ls --color=auto"
alias e="./a.out"
alias vim="nvim"
alias -s rs="rustc"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PGDATA="/usr/local/var/postgres"
export RUST_SRC_PATH="$HOME/opt/rust/src"

cbc() {
    < $1 | pbcopy
}
