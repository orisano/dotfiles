[[ -d ~/.zplug ]] || {
  curl -fLo ~/.zplug/zplug --create-dirs https://git.io/zplug
  source ~/.zplug/zplug && zplug update --self
}

source ~/.zplug/zplug
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# plugins
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "rimraf/k"
zplug "plugins/git", from:oh-my-zsh, if:"which git"
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
# zplug "themes/agnoster", from:oh-my-zsh
zplug "themes/robbyrussell", from:oh-my-zsh

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

zplug load --verbose

export PATH=/usr/local/bin:$HOME/.nodebrew/current/bin:$PATH
export GOPATH=/usr/local/Cellar/go
export NODE_PATH=/usr/local/lib/node_modules
# export JAVA_HOME=`/usr/libexec/java_home`
export PYENV_ROOT=/opt/pyenv
export EDITOR=vim
if [ -d "${PYENV_ROOT}" ]; then
  export PATH=${PYENV_ROOT}/bin:$PATH
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

alias e=./a.out
alias co="g++ -std=c++11 -O2 -D_LOCAL_"
alias dco="g++ -std=c++11 -Og -g -D_LOCAL_ -D_GLIBCXX_DEBUG -fsanitize=address"
alias -s cpp="g++ -std=c++11"
alias -s c="gcc -std=c11"

# functions
# file to clipboard
function cbc() {
< $1 | pbcopy
}
# 直近のvimで編集したファイルをコンパイルする
function c() {
local fname
fname=$(history | grep vim | tail -n1 | cut -d' ' -f4)
echo "[*] compile $fname"
co $fname
}
