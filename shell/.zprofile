if [ -z "$SINGULARITY_CONTAINER" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
else
    echo "running a singularity container!!!!! (zprofile)"
fi