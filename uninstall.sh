#!/bin/bash

which gh-ssh-keygen &> /dev/null

if [ $? = 0 ]; then
    sudo rm -rf $(which gh-ssh-keygen)
    echo "✅ Uninstall successfully!"
    echo
else
    echo -e "\x1b[31mx\x1b[0m \x1b[2mgh-ssh-keygen was not found.\x1b[0m"
    exit 1
fi
