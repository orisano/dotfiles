[[ -d ~/.zplug ]] || {
    curl -sL zplug.sh/installer | zsh
}
source ~/.zplug/init.zsh

setopt print_eight_bit
setopt no_beep
setopt prompt_subst
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug load

bindkey -e

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PGDATA="/usr/local/var/postgres"
export RUST_SRC_PATH="$HOME/opt/rust/src"
export CLICOLOR=1

alias ls="ls -G -F"
alias e="./a.out"
alias vim="nvim"
alias -s rs="rustc"
alias git="hub"
alias -s cpp="g++-7 -std=c++14"

cbc() {
    < $1 | pbcopy
}

function powerline_precmd() {
    PS1="$(~/.powerline/powerline-go -error $? -shell zsh)
 -> "
}

function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
            return
        fi
    done
    precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi
