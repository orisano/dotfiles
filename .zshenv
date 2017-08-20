# ref: http://memo.sugyan.com/entry/20151211/1449833480
# To disable /usr/libexec/path_helper
setopt no_global_rcs
typeset -U path PATH

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/less/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

export PATH="$HOME/.nodebrew/current/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"
export PYENV_SHELL=zsh
source "$PYENV_ROOT/completions/pyenv.zsh"
pyenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  activate|deactivate|rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}

export EDITOR="nvim"
export PAGER="less"

export XDG_CONFIG_HOME="$HOME/.config"
