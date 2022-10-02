#!/bin/bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo curl -fsSL -o /usr/local/bin/gh-ssh-keygen https://raw.githubusercontent.com/maxam2017/gh-ssh-keygen/HEAD/gh-ssh-keygen.sh
sudo chmod +x /usr/local/bin/gh-ssh-keygen
