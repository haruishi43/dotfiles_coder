## Set path for pyenv

if [ -z "$SINGULARITY_CONTAINER" ]; then
  # pyenv:
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH=${PYENV_ROOT}/bin:$PATH
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    echo "set pyenv"
  fi
else
    echo "singularity container!!!!!"
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# run .bashrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
if [ -d "$HOME/.cargo" ]; then
  . "$HOME/.cargo/env"
fi