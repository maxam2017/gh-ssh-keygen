#!/bin/bash

gh-ssh-keygen -h &> /dev/null
if [ $? -ne 0 ];then
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    sudo curl -fsSL -o /usr/local/bin/gh-ssh-keygen https://raw.githubusercontent.com/maxam2017/gh-ssh-keygen/HEAD/gh-ssh-keygen.sh
    sudo chmod +x /usr/local/bin/gh-ssh-keygen

    echo "✅ Installation successful!"
    echo
    gh-ssh-keygen -h
    echo
else
    echo -e "\x1b[2mgh-ssh-keygen is already installed."
fi
