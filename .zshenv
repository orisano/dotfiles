# ref: http://memo.sugyan.com/entry/20151211/1449833480
# To disable /usr/libexec/path_helper
setopt no_global_rcs

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/less/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

export PATH="$HOME/.nodebrew/current/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export EDITOR="nvim"
export PAGER="less"

export XDG_CONFIG_HOME="$HOME/.config"
