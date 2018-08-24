#!/bin/bash
set -ex
ln -s dotfiles/vimrc .vimrc
ln -s dotfiles/tmux.conf .tmux.conf
sudo dd if=/dev/zero of=/var/swapfile bs=1M count=2048 &&\nsudo chmod 600 /var/swapfile &&\nsudo mkswap /var/swapfile &&\necho /var/swapfile none swap defaults 0 0 | sudo tee -a /etc/fstab &&\nsudo swapon -a
cd .vim/plugged/YouCompleteMe
python3 install.py
pip install awscli
pyenv global 3.6.0
wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64\nchmod +x kops-linux-amd64
curl -O https://storage.googleapis.com/kubernetes-release/release/v1.10.7/bin/linux/amd64/kubectl
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm ls-remote
source .zshrc
nvm ls-remote
nvm install v8.11.4
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-linux-amd64.tar.gz
wget -O ~/.vim/plugged/vim-snippets/UltiSnips/terraform.snippets https://github.com/sebosp/vim-snippets-terraform/raw/master/terraform.snippets
wget -O ~/.vim/plugged/vim-snippets/UltiSnips/kubernetes.snippets https://github.com/andrewstuart/vim-kubernetes/raw/master/UltiSnips/yaml.snippets
