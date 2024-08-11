## Set path for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH=${PYENV_ROOT}/bin:$PATH
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  echo "set pyenv"
fi

# run .bashrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
if [ -d "$HOME/.cargo" ]; then
  . "$HOME/.cargo/env"
fi