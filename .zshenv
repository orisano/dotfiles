# ref: http://memo.sugyan.com/entry/20151211/1449833480
# To disable /usr/libexec/path_helper
setopt no_global_rcs

export GOPATH="$HOME/go"
export PYENV_ROOT="$HOME/.pyenv"

PATH="$HOME/.cargo/bin:$PATH"
PATH="$GOPATH/bin:$PATH"
PATH="$HOME/.nodebrew/current/bin:$PATH"
PATH="$PYENV_ROOT/bin:$PATH"

export PATH

export EDITOR="nvim"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
