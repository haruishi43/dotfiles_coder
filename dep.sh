#!/bin/bash
sudo apt-get update

# Must Install!
sudo apt install -y \
    git zsh wget htop psmisc less xsel xclip
sudo apt install -y \
    software-properties-common cmake g++ libtool libtool-bin \
    unzip curl ninja-build autoconf automake \
    gettext pkg-config doxygen

### Install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
chsh -s $(which zsh) $USER

### Install nvim
sudo apt install -y neovim
# change alias
sudo update-alternatives --install /usr/bin/vi vi $NVIM_PATH 60
sudo update-alternatives --auto vi
sudo update-alternatives --install /usr/bin/vim vim $NVIM_PATH 60
sudo update-alternatives --auto vim
sudo update-alternatives --install /usr/bin/editor editor $NVIM_PATH 60
sudo update-alternatives --auto editor

### Install tmux
sudo apt install -y tmux

# tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

### Install pyenv
if hash pyenv 2>/dev/null; then
    echo "pyenv installed"
else
    sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
        xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
fi
git clone git://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
git clone https://github.com/alefpereira/pyenv-pyright.git $(pyenv root)/plugins/pyenv-pyright

### Get imgcat command
sudo curl -o /usr/local/bin/imgcat -O https://gitlab.com/wincent/wincent/raw/master/roles/dotfiles/files/.zsh/bin/imgcat && sudo chmod +x /usr/local/bin/imgcat
