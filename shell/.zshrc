# move annoying .zcompdump files into a better hidden directory
autoload -Uz compinit
compinit -d ~/private/.zcompdump

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="refined"

plugins=(
  zsh-autosuggestions
  git
  ubuntu
  zsh-syntax-highlighting
  # zsh-nvm  # lazy load nvm
)

source $ZSH/oh-my-zsh.sh

#=============================================================================#
# appending anaconda envrionment
pathappend() {
  if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
    if [ "$2" = "after" ] ; then
      PATH=$PATH:$1
    else
      PATH=$1:$PATH
    fi
  fi
}
# removing anaconda evnrionment
pathremove() {
  # Delete path by parts so we can never accidentally remove sub paths
  PATH=${PATH//":$1:"/":"} # delete any instances in the middle
  PATH=${PATH/#"$1:"/} # delete any instance at the beginning
  PATH=${PATH/%":$1"/} # delete any instance in the at the end
}

# arg1 is the path, arg2 is where to put it
pythonpathappend() {
  if ! echo $PYTHONPATH | /bin/egrep -q "(^|:)$1($|:)" ; then
    if [ "$2" = "after" ] ; then
      PYTHONPATH=$PYTHONPATH:$1
    else
      PYTHONPATH=$1:$PYTHONPATH
    fi
    export PYTHONPATH
  fi
}

pythonpathremove() {
  # Delete path by parts so we can never accidentally remove sub paths
  PYTHONPATH=${PYTHONPATH//":$1:"/":"} # delete any instances in the middle
  PYTHONPATH=${PYTHONPATH/#"$1:"/} # delete any instance at the beginning
  PYTHONPATH=${PYTHONPATH/%":$1"/} # delete any instance in the at the end
}

# better way to add path since this checks path existance
addToPATH() {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

# alias acond='pathappend $HOME/anaconda3/bin'
# alias rcond='pathremove $HOME/anaconda3/bin'

# Virtual Environment Wrapper
# source /usr/local/bin/virtualenvwrapper.sh

# anaconda python path
# acond

pythonpathappend /usr/local/lib
# export PYTHONPATH=$PYTHONPATH:/usr/local/lib

#=============================================================================#
# alias:
alias nvwatch='watch -n 2 nvidia-smi'
alias ns='nvidia-smi'
alias gpuwatch='watch -n 2 -c gpustat -F -P --color'
alias sensors-watch='watch -n 2 sensors'
alias chrome='google-chrome'
alias vim='nvim'

# Type Alias:
alias vzsh="vim ~/.zshrc"
alias szsh="source ~/.zshrc"

# ls, the common ones I use a lot shortened for rapid fire usage
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list

# I'll start by adding the most essential.
alias o="nautilus"
alias x="exit"
alias g="git"
alias gs='git status'
alias gd='git diff'
alias g-='git checkout -'
alias serve='python -m http.server 8000'
alias cppcompile='c++ -std=c++11'
alias tgz='tar -zxvf'
alias rm='rm -i'
alias hg='history | grep'
alias count='ls . | wc -l'
alias lsdisk='lsblk -io KNAME,TYPE,SIZE,MODEL'

# submodule things
alias git-sub-update="git submodule foreach git pull origin master"

# copy and paste
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

function gdrive_download() {
  CONFIRM=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$1" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')
  wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$CONFIRM&id=$1" -O $2
  rm -rf /tmp/cookies.txt
}

# Anaconda (pyenv conflicts)
# Note that there can be only 1 version of anaconda and the version needs to be updated...
alias activate="source $PYENV_ROOT/versions/anaconda3-2021.05/bin/activate"

#=============================================================================#

# Options:
setopt share_history
HISTFILE=~/private/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
function history-all() { history -E 1 }  # print out all history 

#=============================================================================#

# load pyenv
eval "$(pyenv init -)"

# load nvm (might be slow?)
export NVM_DIR="$HOME/.nvm"
function loadnvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
# FIXME: figure out a way to lazy load nvm and node -> nvim needs
loadnvm  # default, load nvm -> remove this when it's slow

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh