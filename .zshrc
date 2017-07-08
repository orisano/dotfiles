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

zplug "miekg/lean", use:"*.zsh"
zplug "zsh-users/zsh-completions"
zplug load

bindkey -e

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export CLICOLOR=1

alias ls="ls -G -F"
alias e="./a.out"
alias vim="nvim"
alias git="hub"

cbc() {
    cat $1 | pbcopy
}
