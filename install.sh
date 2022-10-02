#!/bin/bash
VERSION="0.0.1"

# https://stackoverflow.com/questions/4023830/how-to-compare-two-strings-in-dot-separated-version-format-in-bash
vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

install() {
 sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    sudo curl -fsSL -o /usr/local/bin/gh-ssh-keygen https://raw.githubusercontent.com/maxam2017/gh-ssh-keygen/HEAD/gh-ssh-keygen.sh
    sudo chmod +x /usr/local/bin/gh-ssh-keygen
}

gh-ssh-keygen -h &> /dev/null
if [ $? -ne 0 ];then
    install
    echo "✅ Installation successful!"
    echo
    gh-ssh-keygen -h
    echo
else
    CUR_VERSION=$(gh-ssh-keygen -v)
    vercomp $CUR_VERSION $VERSION
    if [ $? = 2 ]; then
        echo -en "🔑 The current version(v$CUR_VERSION) is not the latest.\x1b[2m(Press Enter to upgrade)\x1b[0m"
        read
        install
        echo "✅ Upgrade successful!"
        echo
        gh-ssh-keygen -h
        echo
    else
        echo -e "\x1b[2mgh-ssh-keygen is installed and already up to date."
    fi
fi
