# Must have Path exports: export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PATH=/usr/local/cuda/bin:$PATH
export CUDA_PATH=/usr/local/cuda

if [ -z "$SINGULARITY_CONTAINER" ]; then
  # pyenv:
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH=${PYENV_ROOT}/bin:$PATH
  if command -v pyenv 1>/dev/null 2>&1; then
    # eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
  fi
else
    echo "running a singularity container!!!!! (zshenv)"
fi

# modmap
{
  cmd=`xmodmap -pke | grep -w Caps_Lock`
  if [ $? -eq 0 ]; then
    xmodmap .Xmodmap
  fi
} 2> /dev/null

# xmodmap $HOME/.xmodmap-`uname -n`

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
PATH="$PATH:$HOME/scripts"
if [ -d "$HOME/.cargo" ]; then
  . "$HOME/.cargo/env"
fi