#!/bin/sh

sudo apt-get update

SNAPLIST="discord code spotify insomnia"
APPLIST="git vim terminator fonts-firacode openjdk-11-jdk zsh make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl ca-certificates gnupg llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev lsb-release"

for i in $SNAPLIST; do
	snap install "$i" --classic
done

for i in $APPLIST; do
	apt-get install -y "$i"
done

echo "Installing Ooh-my-Zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Pyenv and python 3.10.0"
curl https://pyenv.run | bash
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
pyenv install 3.10.0
pyenv global 3.10.0

echo "Installing Poetry"
sh -c "$(curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -)"

echo "Installing nvm"
sh -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash)"
nvm use --lts

echo "Installing docker"
sh -c "$(curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg)"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update &&
apt-get install docker-ce docker-ce-cli containerd.io
usermod -aG docker ${USER} &&
su - ${USER}

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
