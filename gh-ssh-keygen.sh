#!/bin/bash
VERSION="0.0.3"

################################################################################
# ASCII                                                                        #
################################################################################
Reset='\x1b[0m'
Bright='\x1b[1m'
Cyan='\033[0;36m'
Dim='\x1b[2m'
Red='\x1b[31m'
Purple='\033[0;35m'

################################################################################
# Chalk                                                                        #
################################################################################
function echo_bright() {
    echo -e "${Bright}$1${Reset}"
}

################################################################################
# help                                                                         #
################################################################################
help()
{
   echo_bright "NAME"
   echo "     gh-ssh-keygen 🔑 - adding a new SSH key to your GitHub account automatically"
   echo

   echo_bright "VERSION"
   echo "     $(get_version)"
   echo

   echo_bright "SYNOPSIS"
   echo "     gh-ssh-keygen [-hv]"
   echo

   echo_bright "DESCRIPTION"
   echo "     Want to enable authentication for Git operations over SSH?"
   echo "     This script helps you generate a SSH key on your local machine and add the key to your account on GitHub.com."
   echo "     See more detail on GitHub official document - https://docs.github.com/en/authentication/connecting-to-github-with-ssh"
   echo
   echo

   echo "     The following options are available:"
   echo
   echo "     -h     show this message"
   echo "     -v     get the version"
   echo

   echo_bright "ENVIRONMENT"
   echo "     Currently only works on MacOS."
   echo

   echo_bright "AUTHOR"
   echo "     maxam2017 🦕"
   echo
}

################################################################################
# version                                                                      #
################################################################################
get_version() {
    echo $VERSION
}

while getopts ":hv" option; do
    case $option in
        h)
            help
            exit;;
        v)
            get_version
            exit;;
    esac
done

# install gh (if not exist)
gh -h &> /dev/null
if [ $? -ne 0 ];then
    echo -e "${Red}!${Reset} ${Dim}GitHub CLI is not found.${Reset}"
    echo -e "${Purple}>${Reset} ${Dim}Let's install by \`brew\`...${Reset}"
    echo

    # install brew (if not found)
    brew -h &> /dev/null
    if [ $? -ne 0 ];then
        echo -e "${Red}!${Reset} ${Dim}Package manager \`brew\` is not found.${Reset}"
        echo -e "${Purple}>${Reset} ${Dim}Let's install install from internet...${Reset}"
        echo
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    brew install gh
    clear
fi

# get email
GH_MAIL=$(git config --global user.email)
if [ ! $GH_MAIL ]; then
    echo -e "${Red}!${Reset} ${Dim}We can't find your GitHub email address in global git config.${Reset}"

    while true; do
        echo -en "${Cyan}?${Reset} Please Enter your GitHub email address: "
        read GH_MAIL
        [[ $GH_MAIL =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]

        if [ $? -ne 0 ]; then
            echo -e "${Red}x${Reset} ${Dim}Validation error: \"$GH_MAIL\" is not a valid email address.${Reset}"
            echo
        else
            break
        fi
    done
else
    echo -e "${Purple}>${Reset} Your GitHub email address \"$GH_MAIL\" was found in global git config.${Reset}"
    echo -e "${Purple}>${Reset} Directly use for ssh key generation...${Reset}"
fi

# generate ssh key
echo
echo -e "${Purple}>${Reset} Generating ssh key for \"$GH_MAIL\"..."
ssh-keygen -t ed25519 -C "$GH_MAIL" -f ~/.ssh/id_ed25519

# add ssh key to ssh-agent
echo
echo -e "${Purple}>${Reset} Adding your SSH key to the ssh-agent..."
grep -q "IdentityFile ~/.ssh/id_ed25519" ~/.ssh/config
if [ $? -ne 0 ]; then
    printf "Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_ed25519
    " >> ~/.ssh/config
fi
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# github new ssh key
echo
echo -e "${Purple}>${Reset} Adding your SSH key to your account on GitHub.com..."
gh auth login -w -s admin:public_key,write:gpg_key

while true; do
    echo -en "${Cyan}?${Reset} Enter the title for the new key: "
    read
    gh ssh-key add ~/.ssh/id_ed25519.pub -t "$REPLY"

    if [ $? = 0 ]; then
        break
    fi
done
